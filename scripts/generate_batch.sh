#!/bin/bash
# Generate individual batch SQL files for manual import

BATCH=$1
if [ -z "$BATCH" ]; then
  echo "Usage: $0 <batch_number>"
  echo "  Generates batch SQL (batches 1-10, 30 cards each)"
  exit 1
fi

START=$(( ($BATCH - 1) * 30 ))
END=$(( $START + 30 ))

node -e "
const fs = require('fs');
const cards = JSON.parse(fs.readFileSync('data/blb_cards.json'));

function esc(s) {
  if (!s) return 'NULL';
  return \"'\" + String(s).replace(/'/g, \"''\") + \"'\";
}

const batch = cards.slice($START, Math.min($END, cards.length));
if (batch.length === 0) {
  console.log('-- No cards in this batch');
  process.exit(0);
}

const vals = batch.map(c => {
  const col = c.colors?.length ? \`ARRAY['\${c.colors.join(\"','\")}']:text[]\` : 'ARRAY[]::text[]';
  return \`(\${esc(c.id)},\${esc(c.name)},\${esc(c.mana_cost)},\${c.cmc},\${esc(c.type_line)},\${esc(c.oracle_text)},\${col},\${esc(c.rarity)},\${esc(c.set_code)},\${esc(c.collector_number)},\${esc(c.image_uri)},\${esc(c.image_uri_small)})\`;
});

console.log('-- Batch $BATCH: Cards $START-' + Math.min($END, cards.length));
console.log('INSERT INTO cards(id,name,mana_cost,cmc,type_line,oracle_text,colors,rarity,set_code,collector_number,image_uri,image_uri_small)VALUES');
console.log(vals.join(',\\n'));
console.log('ON CONFLICT(id)DO NOTHING;');
"
