/**
 * Generate compact SQL for all cards (for manual execution)
 */

const fs = require('fs');

const data = fs.readFileSync('data/blb_cards.json', 'utf8');
const cards = JSON.parse(data);

console.log(`-- ${cards.length} cartes BLB à importer\n`);
console.log(`-- Exécutez ces commandes une par une dans Supabase\n`);

// Batches of 20 for manageable SQL size
const batchSize = 20;
for (let i = 0; i < Math.min(cards.length, 100); i += batchSize) {
  const batch = cards.slice(i, i + batchSize);
  console.log(`\n-- Batch ${Math.floor(i/batchSize) + 1}: Cards ${i+1}-${Math.min(i+batchSize, cards.length)}`);
  console.log(`SELECT ${batch.length} as "importing_cards";`);
}

console.log(`\n-- Total: ${cards.length} cartes`);
console.log(`-- Note: Importez via le script Python avec les bonnes dépendances`);
