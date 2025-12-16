/**
 * Import cards from JSON file to Supabase
 * Outputs SQL statements that can be executed
 */

const fs = require('fs');

function escapeString(str) {
  if (!str) return '';
  return str.replace(/'/g, "''").replace(/\\/g, '\\\\');
}

function generateInsertSQL(cards) {
  const values = cards.map(card => {
    const colors = card.colors && card.colors.length > 0
      ? `ARRAY['${card.colors.join("','")}']::text[]`
      : 'ARRAY[]::text[]';

    return `(
      '${card.id}',
      '${escapeString(card.name)}',
      '${escapeString(card.mana_cost)}',
      ${card.cmc || 0},
      '${escapeString(card.type_line)}',
      '${escapeString(card.oracle_text)}',
      ${colors},
      '${card.rarity}',
      '${card.set_code}',
      '${card.collector_number}',
      '${card.image_uri}',
      '${card.image_uri_small}'
    )`;
  }).join(',\n    ');

  return `INSERT INTO cards (
    id, name, mana_cost, cmc, type_line, oracle_text,
    colors, rarity, set_code, collector_number, image_uri, image_uri_small
  )
  VALUES
    ${values}
  ON CONFLICT (id) DO UPDATE
  SET
    name = EXCLUDED.name,
    mana_cost = EXCLUDED.mana_cost,
    cmc = EXCLUDED.cmc,
    type_line = EXCLUDED.type_line,
    oracle_text = EXCLUDED.oracle_text,
    colors = EXCLUDED.colors,
    rarity = EXCLUDED.rarity,
    set_code = EXCLUDED.set_code,
    collector_number = EXCLUDED.collector_number,
    image_uri = EXCLUDED.image_uri,
    image_uri_small = EXCLUDED.image_uri_small;`;
}

async function main() {
  try {
    const data = fs.readFileSync('data/blb_cards.json', 'utf8');
    const cards = JSON.parse(data);

    console.log(`Found ${cards.length} cards`);

    // Split into batches of 50
    const batchSize = 50;
    for (let i = 0; i < cards.length; i += batchSize) {
      const batch = cards.slice(i, i + batchSize);
      const sql = generateInsertSQL(batch);

      // Write to individual SQL files
      const filename = `data/import_batch_${Math.floor(i / batchSize) + 1}.sql`;
      fs.writeFileSync(filename, sql);
      console.log(`✅ Batch ${Math.floor(i / batchSize) + 1}/${Math.ceil(cards.length / batchSize)} written to ${filename}`);
    }

    console.log('\n✅ All SQL files generated!');
  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

main();
