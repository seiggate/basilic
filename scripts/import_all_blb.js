/**
 * Import all BLB cards to Supabase via SQL batches
 */

const fs = require('fs');

const cards = JSON.parse(fs.readFileSync('data/blb_cards.json', 'utf8'));

function escapeSql(s) {
  if (s === null || s === undefined) return 'NULL';
  return "'" + String(s).replace(/'/g, "''") + "'";
}

console.log(`-- Importing ${cards.length} BLB cards`);

// Process all cards in batches of 30
const batchSize = 30;
const totalBatches = Math.ceil(cards.length / batchSize);

for (let batchNum = 0; batchNum < totalBatches; batchNum++) {
  const start = batchNum * batchSize;
  const end = Math.min(start + batchSize, cards.length);
  const batch = cards.slice(start, end);

  const values = batch.map(c => {
    const colors = c.colors && c.colors.length > 0
      ? `ARRAY['${c.colors.join("','")}']::text[]`
      : 'ARRAY[]::text[]';

    return `(${escapeSql(c.id)},${escapeSql(c.name)},${escapeSql(c.mana_cost)},${c.cmc},${escapeSql(c.type_line)},${escapeSql(c.oracle_text)},${colors},${escapeSql(c.rarity)},${escapeSql(c.set_code)},${escapeSql(c.collector_number)},${escapeSql(c.image_uri)},${escapeSql(c.image_uri_small)})`;
  });

  console.log(`\n-- Batch ${batchNum + 1}/${totalBatches}: Cards ${start+1}-${end}`);
  console.log('INSERT INTO cards(id,name,mana_cost,cmc,type_line,oracle_text,colors,rarity,set_code,collector_number,image_uri,image_uri_small)VALUES');
  console.log(values.join(',\n'));
  console.log('ON CONFLICT(id)DO NOTHING;');
}

console.log(`\n-- Total: ${cards.length} cards imported`);
