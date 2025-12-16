/**
 * Import Bloomburrow cards from Scryfall to local JSON file
 */

const https = require('https');
const fs = require('fs');

function fetchJSON(url) {
  return new Promise((resolve, reject) => {
    const options = {
      headers: {
        'User-Agent': 'BasilicMTG/1.0',
        'Accept': 'application/json'
      }
    };

    https.get(url, options, (res) => {
      let data = '';
      res.on('data', (chunk) => { data += chunk; });
      res.on('end', () => {
        try {
          resolve(JSON.parse(data));
        } catch (e) {
          reject(e);
        }
      });
    }).on('error', reject);
  });
}

async function fetchAllCards(setCode) {
  console.log(`Fetching cards for ${setCode}...`);

  let url = `https://api.scryfall.com/cards/search?q=set:${setCode}`;
  const allCards = [];

  while (url) {
    const data = await fetchJSON(url);

    if (!data.data || !Array.isArray(data.data)) {
      console.error('Unexpected response:', data);
      break;
    }

    for (const card of data.data) {
      // Skip tokens
      if (['token', 'double_faced_token', 'art_series'].includes(card.layout)) {
        continue;
      }

      // Handle images
      let imageUri = '';
      let imageUriSmall = '';
      if (card.image_uris) {
        imageUri = card.image_uris.normal || '';
        imageUriSmall = card.image_uris.small || '';
      } else if (card.card_faces && card.card_faces[0] && card.card_faces[0].image_uris) {
        imageUri = card.card_faces[0].image_uris.normal || '';
        imageUriSmall = card.card_faces[0].image_uris.small || '';
      }

      allCards.push({
        id: card.id,
        name: card.name,
        mana_cost: card.mana_cost || '',
        cmc: card.cmc || 0,
        type_line: card.type_line || '',
        oracle_text: card.oracle_text || '',
        colors: card.colors || [],
        rarity: card.rarity || 'common',
        set_code: card.set || '',
        collector_number: card.collector_number || '',
        image_uri: imageUri,
        image_uri_small: imageUriSmall
      });
    }

    url = data.next_page || null;
    if (url) {
      // Rate limit
      await new Promise(resolve => setTimeout(resolve, 100));
    }
  }

  return allCards;
}

async function main() {
  try {
    const cards = await fetchAllCards('blb');
    console.log(`✅ Fetched ${cards.length} cards`);

    // Write to file
    fs.writeFileSync(
      'data/blb_cards.json',
      JSON.stringify(cards, null, 2)
    );

    console.log(`💾 Saved to data/blb_cards.json`);
    console.log('\nSample cards:');
    cards.slice(0, 5).forEach((card, i) => {
      console.log(`${i+1}. ${card.name} - ${card.rarity} - ${card.type_line}`);
    });
  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

main();
