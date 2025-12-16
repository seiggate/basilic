INSERT INTO cards (
    id, name, mana_cost, cmc, type_line, oracle_text,
    colors, rarity, set_code, collector_number, image_uri, image_uri_small
  )
  VALUES
    (
      '7dd9946b-515e-4e0d-9da2-711e126e9fa6',
      'Agate Assault',
      '{2}{R}',
      3,
      'Sorcery',
      'Choose one —
• Agate Assault deals 4 damage to target creature. If that creature would die this turn, exile it instead.
• Exile target artifact.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '122',
      'https://cards.scryfall.io/normal/front/7/d/7dd9946b-515e-4e0d-9da2-711e126e9fa6.jpg?1721426563',
      'https://cards.scryfall.io/small/front/7/d/7dd9946b-515e-4e0d-9da2-711e126e9fa6.jpg?1721426563'
    ),
    (
      '39ebb84a-1c52-4b07-9bd0-b360523b3a5b',
      'Agate-Blade Assassin',
      '{1}{B}',
      2,
      'Creature — Lizard Assassin',
      'Whenever this creature attacks, defending player loses 1 life and you gain 1 life.',
      ARRAY['B']::text[],
      'common',
      'blb',
      '82',
      'https://cards.scryfall.io/normal/front/3/9/39ebb84a-1c52-4b07-9bd0-b360523b3a5b.jpg?1721426332',
      'https://cards.scryfall.io/small/front/3/9/39ebb84a-1c52-4b07-9bd0-b360523b3a5b.jpg?1721426332'
    ),
    (
      'b24c3e9c-2aff-45fd-9c87-3ebd33bbe807',
      'A-Heartfire Hero',
      '{R}',
      1,
      'Creature — Mouse Soldier',
      'Valiant — Whenever Heartfire Hero becomes the target of a spell or ability you control for the first time each turn, put a +1/+1 counter on it.
When Heartfire Hero dies, it deals damage equal to its power to each opponent.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      'A-138',
      'https://cards.scryfall.io/normal/front/b/2/b24c3e9c-2aff-45fd-9c87-3ebd33bbe807.jpg?1757377765',
      'https://cards.scryfall.io/small/front/b/2/b24c3e9c-2aff-45fd-9c87-3ebd33bbe807.jpg?1757377765'
    ),
    (
      '436d6a84-4cea-4ca7-94aa-9d08280652af',
      'Alania, Divergent Storm',
      '{3}{U}{R}',
      5,
      'Legendary Creature — Otter Wizard',
      'Whenever you cast a spell, if it''s the first instant spell, the first sorcery spell, or the first Otter spell other than Alania you''ve cast this turn, you may have target opponent draw a card. If you do, copy that spell. You may choose new targets for the copy.',
      ARRAY['R','U']::text[],
      'rare',
      'blb',
      '204',
      'https://cards.scryfall.io/normal/front/4/3/436d6a84-4cea-4ca7-94aa-9d08280652af.jpg?1721426997',
      'https://cards.scryfall.io/small/front/4/3/436d6a84-4cea-4ca7-94aa-9d08280652af.jpg?1721426997'
    ),
    (
      'd3871fe6-e26e-4ab4-bd81-7e3c7b8135c1',
      'Alania''s Pathmaker',
      '{3}{R}',
      4,
      'Creature — Otter Wizard',
      'When this creature enters, exile the top card of your library. Until the end of your next turn, you may play that card.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '123',
      'https://cards.scryfall.io/normal/front/d/3/d3871fe6-e26e-4ab4-bd81-7e3c7b8135c1.jpg?1721426565',
      'https://cards.scryfall.io/small/front/d/3/d3871fe6-e26e-4ab4-bd81-7e3c7b8135c1.jpg?1721426565'
    ),
    (
      '8b9e51d9-189b-4dd6-87cb-628ea6373e81',
      'Artist''s Talent',
      '{1}{R}',
      2,
      'Enchantment — Class',
      '(Gain the next level as a sorcery to add its ability.)
Whenever you cast a noncreature spell, you may discard a card. If you do, draw a card.
{2}{R}: Level 2
Noncreature spells you cast cost {1} less to cast.
{2}{R}: Level 3
If a source you control would deal noncombat damage to an opponent or a permanent an opponent controls, it deals that much damage plus 2 instead.',
      ARRAY['R']::text[],
      'rare',
      'blb',
      '124',
      'https://cards.scryfall.io/normal/front/8/b/8b9e51d9-189b-4dd6-87cb-628ea6373e81.jpg?1721426571',
      'https://cards.scryfall.io/small/front/8/b/8b9e51d9-189b-4dd6-87cb-628ea6373e81.jpg?1721426571'
    ),
    (
      '211af1bf-910b-41a5-b928-f378188d1871',
      'Azure Beastbinder',
      '{1}{U}',
      2,
      'Creature — Rat Rogue',
      'Vigilance
This creature can''t be blocked by creatures with power 2 or greater.
Whenever this creature attacks, up to one target artifact, creature, or planeswalker an opponent controls loses all abilities until your next turn. If it''s a creature, it also has base power and toughness 2/2 until your next turn.',
      ARRAY['U']::text[],
      'rare',
      'blb',
      '41',
      'https://cards.scryfall.io/normal/front/2/1/211af1bf-910b-41a5-b928-f378188d1871.jpg?1721426023',
      'https://cards.scryfall.io/small/front/2/1/211af1bf-910b-41a5-b928-f378188d1871.jpg?1721426023'
    ),
    (
      '5309354f-1ff4-4fa9-9141-01ea2f7588ab',
      'Bakersbane Duo',
      '{1}{G}',
      2,
      'Creature — Squirrel Raccoon',
      'When this creature enters, create a Food token.
Whenever you expend 4, this creature gets +1/+1 until end of turn. (You expend 4 as you spend your fourth total mana to cast spells during a turn.)',
      ARRAY['G']::text[],
      'common',
      'blb',
      '163',
      'https://cards.scryfall.io/normal/front/5/3/5309354f-1ff4-4fa9-9141-01ea2f7588ab.jpg?1721426764',
      'https://cards.scryfall.io/small/front/5/3/5309354f-1ff4-4fa9-9141-01ea2f7588ab.jpg?1721426764'
    ),
    (
      '485dc8d8-9e44-4a0f-9ff6-fa448e232290',
      'Bandit''s Talent',
      '{1}{B}',
      2,
      'Enchantment — Class',
      '(Gain the next level as a sorcery to add its ability.)
When this Class enters, each opponent discards two cards unless they discard a nonland card.
{B}: Level 2
At the beginning of each opponent''s upkeep, if that player has one or fewer cards in hand, they lose 2 life.
{3}{B}: Level 3
At the beginning of your draw step, draw an additional card for each opponent who has one or fewer cards in hand.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '83',
      'https://cards.scryfall.io/normal/front/4/8/485dc8d8-9e44-4a0f-9ff6-fa448e232290.jpg?1739659353',
      'https://cards.scryfall.io/small/front/4/8/485dc8d8-9e44-4a0f-9ff6-fa448e232290.jpg?1739659353'
    ),
    (
      '25a06f82-ebdb-4dd6-bfe8-958018ce557c',
      'Banishing Light',
      '{2}{W}',
      3,
      'Enchantment',
      'When this enchantment enters, exile target nonland permanent an opponent controls until this enchantment leaves the battlefield.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '1',
      'https://cards.scryfall.io/normal/front/2/5/25a06f82-ebdb-4dd6-bfe8-958018ce557c.jpg?1721425761',
      'https://cards.scryfall.io/small/front/2/5/25a06f82-ebdb-4dd6-bfe8-958018ce557c.jpg?1721425761'
    ),
    (
      'f77049a6-0f22-415b-bc89-20bcb32accf6',
      'Barkform Harvester',
      '{3}',
      3,
      'Artifact Creature — Shapeshifter',
      'Changeling (This card is every creature type.)
Reach
{2}: Put target card from your graveyard on the bottom of your library.',
      ARRAY[]::text[],
      'common',
      'blb',
      '243',
      'https://cards.scryfall.io/normal/front/f/7/f77049a6-0f22-415b-bc89-20bcb32accf6.jpg?1721427262',
      'https://cards.scryfall.io/small/front/f/7/f77049a6-0f22-415b-bc89-20bcb32accf6.jpg?1721427262'
    ),
    (
      '582637a9-6aa0-4824-bed7-d5fc91bda35e',
      'Bark-Knuckle Boxer',
      '{1}{G}',
      2,
      'Creature — Raccoon Berserker',
      'Whenever you expend 4, this creature gains indestructible until end of turn. (You expend 4 as you spend your fourth total mana to cast spells during a turn.)',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '164',
      'https://cards.scryfall.io/normal/front/5/8/582637a9-6aa0-4824-bed7-d5fc91bda35e.jpg?1721426764',
      'https://cards.scryfall.io/small/front/5/8/582637a9-6aa0-4824-bed7-d5fc91bda35e.jpg?1721426764'
    ),
    (
      '00e93be2-e06b-4774-8ba5-ccf82a6da1d8',
      'Baylen, the Haymaker',
      '{R}{G}{W}',
      3,
      'Legendary Creature — Rabbit Warrior',
      'Tap two untapped tokens you control: Add one mana of any color.
Tap three untapped tokens you control: Draw a card.
Tap four untapped tokens you control: Put three +1/+1 counters on Baylen. It gains trample until end of turn.',
      ARRAY['G','R','W']::text[],
      'rare',
      'blb',
      '205',
      'https://cards.scryfall.io/normal/front/0/0/00e93be2-e06b-4774-8ba5-ccf82a6da1d8.jpg?1721427006',
      'https://cards.scryfall.io/small/front/0/0/00e93be2-e06b-4774-8ba5-ccf82a6da1d8.jpg?1721427006'
    ),
    (
      'ca2215dd-6300-49cf-b9b2-3a840b786c31',
      'Bellowing Crier',
      '{1}{U}',
      2,
      'Creature — Frog Advisor',
      'When this creature enters, draw a card, then discard a card.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '42',
      'https://cards.scryfall.io/normal/front/c/a/ca2215dd-6300-49cf-b9b2-3a840b786c31.jpg?1721426026',
      'https://cards.scryfall.io/small/front/c/a/ca2215dd-6300-49cf-b9b2-3a840b786c31.jpg?1721426026'
    ),
    (
      'fc310a26-b6a0-4e42-98ab-bdfd7b06cb63',
      'Beza, the Bounding Spring',
      '{2}{W}{W}',
      4,
      'Legendary Creature — Elemental Elk',
      'When Beza enters, create a Treasure token if an opponent controls more lands than you. You gain 4 life if an opponent has more life than you. Create two 1/1 blue Fish creature tokens if an opponent controls more creatures than you. Draw a card if an opponent has more cards in hand than you.',
      ARRAY['W']::text[],
      'mythic',
      'blb',
      '2',
      'https://cards.scryfall.io/normal/front/f/c/fc310a26-b6a0-4e42-98ab-bdfd7b06cb63.jpg?1721425768',
      'https://cards.scryfall.io/small/front/f/c/fc310a26-b6a0-4e42-98ab-bdfd7b06cb63.jpg?1721425768'
    ),
    (
      '4bb318fa-481d-40a7-978e-f01b49101ae0',
      'Blacksmith''s Talent',
      '{R}',
      1,
      'Enchantment — Class',
      '(Gain the next level as a sorcery to add its ability.)
When this Class enters, create a colorless Equipment artifact token named Sword with "Equipped creature gets +1/+1" and equip {2}.
{2}{R}: Level 2
At the beginning of combat on your turn, attach target Equipment you control to up to one target creature you control.
{3}{R}: Level 3
During your turn, equipped creatures you control have double strike and haste.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '125',
      'https://cards.scryfall.io/normal/front/4/b/4bb318fa-481d-40a7-978e-f01b49101ae0.jpg?1739659737',
      'https://cards.scryfall.io/small/front/4/b/4bb318fa-481d-40a7-978e-f01b49101ae0.jpg?1739659737'
    ),
    (
      '0cd92a83-cec3-4085-a929-3f204e3e0140',
      'Blooming Blast',
      '{1}{R}',
      2,
      'Instant',
      'Gift a Treasure (You may promise an opponent a gift as you cast this spell. If you do, they create a Treasure token before its other effects. It''s an artifact with "{T}, Sacrifice this token: Add one mana of any color.")
Blooming Blast deals 2 damage to target creature. If the gift was promised, Blooming Blast also deals 3 damage to that creature''s controller.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '126',
      'https://cards.scryfall.io/normal/front/0/c/0cd92a83-cec3-4085-a929-3f204e3e0140.jpg?1721426579',
      'https://cards.scryfall.io/small/front/0/c/0cd92a83-cec3-4085-a929-3f204e3e0140.jpg?1721426579'
    ),
    (
      'ecfa2cc9-e427-4104-bad7-b0294e392b1f',
      'Blossoming Sands',
      '',
      0,
      'Land',
      'This land enters tapped.
When this land enters, you gain 1 life.
{T}: Add {G} or {W}.',
      ARRAY[]::text[],
      'common',
      'blb',
      '396',
      'https://cards.scryfall.io/normal/front/e/c/ecfa2cc9-e427-4104-bad7-b0294e392b1f.jpg?1721428122',
      'https://cards.scryfall.io/small/front/e/c/ecfa2cc9-e427-4104-bad7-b0294e392b1f.jpg?1721428122'
    ),
    (
      'faf226fa-ca09-4468-8804-87b2a7de2c66',
      'Bonebind Orator',
      '{1}{B}',
      2,
      'Creature — Squirrel Warlock Bard',
      '{3}{B}, Exile this card from your graveyard: Return another target creature card from your graveyard to your hand.',
      ARRAY['B']::text[],
      'common',
      'blb',
      '84',
      'https://cards.scryfall.io/normal/front/f/a/faf226fa-ca09-4468-8804-87b2a7de2c66.jpg?1721426343',
      'https://cards.scryfall.io/small/front/f/a/faf226fa-ca09-4468-8804-87b2a7de2c66.jpg?1721426343'
    ),
    (
      '82defb87-237f-4b77-9673-5bf00607148f',
      'Bonecache Overseer',
      '{B}',
      1,
      'Creature — Squirrel Warlock',
      '{T}, Pay 1 life: Draw a card. Activate only if three or more cards left your graveyard this turn or if you''ve sacrificed a Food this turn.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '85',
      'https://cards.scryfall.io/normal/front/8/2/82defb87-237f-4b77-9673-5bf00607148f.jpg?1721426349',
      'https://cards.scryfall.io/small/front/8/2/82defb87-237f-4b77-9673-5bf00607148f.jpg?1721426349'
    ),
    (
      'e200b8bf-f2f3-4157-8e04-02baf07a963e',
      'Brambleguard Captain',
      '{3}{R}',
      4,
      'Creature — Mouse Soldier',
      'At the beginning of combat on your turn, target creature you control gets +X/+0 until end of turn, where X is this creature''s power.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '127',
      'https://cards.scryfall.io/normal/front/e/2/e200b8bf-f2f3-4157-8e04-02baf07a963e.jpg?1721426582',
      'https://cards.scryfall.io/small/front/e/2/e200b8bf-f2f3-4157-8e04-02baf07a963e.jpg?1721426582'
    ),
    (
      'bac9f6f8-6797-4580-9fc4-9a825872e017',
      'Brambleguard Veteran',
      '{1}{G}{G}',
      3,
      'Creature — Raccoon Warrior',
      'Whenever you expend 4, Raccoons you control get +1/+1 and gain vigilance until end of turn. (You expend 4 as you spend your fourth total mana to cast spells during a turn.)',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '165',
      'https://cards.scryfall.io/normal/front/b/a/bac9f6f8-6797-4580-9fc4-9a825872e017.jpg?1721426774',
      'https://cards.scryfall.io/small/front/b/a/bac9f6f8-6797-4580-9fc4-9a825872e017.jpg?1721426774'
    ),
    (
      'b8dd4693-424d-4d6e-86cf-24401a23d6b1',
      'Brave-Kin Duo',
      '{W}',
      1,
      'Creature — Rabbit Mouse',
      '{1}, {T}: Target creature gets +1/+1 until end of turn. Activate only as a sorcery.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '3',
      'https://cards.scryfall.io/normal/front/b/8/b8dd4693-424d-4d6e-86cf-24401a23d6b1.jpg?1721425770',
      'https://cards.scryfall.io/small/front/b/8/b8dd4693-424d-4d6e-86cf-24401a23d6b1.jpg?1721425770'
    ),
    (
      '78b55a58-c669-4dc6-aa63-5d9dff52e613',
      'Brazen Collector',
      '{1}{R}',
      2,
      'Creature — Raccoon Rogue',
      'First strike
Whenever this creature attacks, add {R}. Until end of turn, you don''t lose this mana as steps and phases end.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '128',
      'https://cards.scryfall.io/normal/front/7/8/78b55a58-c669-4dc6-aa63-5d9dff52e613.jpg?1721426587',
      'https://cards.scryfall.io/small/front/7/8/78b55a58-c669-4dc6-aa63-5d9dff52e613.jpg?1721426587'
    ),
    (
      '390c96b3-68da-4a42-89ab-d9ccc79ce0dd',
      'Bria, Riptide Rogue',
      '{2}{U}{R}',
      4,
      'Legendary Creature — Otter Rogue',
      'Prowess (Whenever you cast a noncreature spell, this creature gets +1/+1 until end of turn.)
Other creatures you control have prowess. (If a creature has multiple instances of prowess, each triggers separately.)
Whenever you cast a noncreature spell, target creature you control can''t be blocked this turn.',
      ARRAY['R','U']::text[],
      'mythic',
      'blb',
      '379',
      'https://cards.scryfall.io/normal/front/3/9/390c96b3-68da-4a42-89ab-d9ccc79ce0dd.jpg?1724104634',
      'https://cards.scryfall.io/small/front/3/9/390c96b3-68da-4a42-89ab-d9ccc79ce0dd.jpg?1724104634'
    ),
    (
      'df7fea2e-7414-4bc8-adb0-9342e174c009',
      'Brightblade Stoat',
      '{1}{W}',
      2,
      'Creature — Weasel Soldier',
      'First strike, lifelink',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '4',
      'https://cards.scryfall.io/normal/front/d/f/df7fea2e-7414-4bc8-adb0-9342e174c009.jpg?1721425778',
      'https://cards.scryfall.io/small/front/d/f/df7fea2e-7414-4bc8-adb0-9342e174c009.jpg?1721425778'
    ),
    (
      '15fa581a-724e-4196-a9a3-ff84c54bdb7d',
      'Builder''s Talent',
      '{1}{W}',
      2,
      'Enchantment — Class',
      '(Gain the next level as a sorcery to add its ability.)
When this Class enters, create a 0/4 white Wall creature token with defender.
{W}: Level 2
Whenever one or more noncreature, nonland permanents you control enter, put a +1/+1 counter on target creature you control.
{4}{W}: Level 3
When this Class becomes level 3, return target noncreature, nonland permanent card from your graveyard to the battlefield.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '5',
      'https://cards.scryfall.io/normal/front/1/5/15fa581a-724e-4196-a9a3-ff84c54bdb7d.jpg?1739650809',
      'https://cards.scryfall.io/small/front/1/5/15fa581a-724e-4196-a9a3-ff84c54bdb7d.jpg?1739650809'
    ),
    (
      '5f0affd5-5dcd-4dd1-a694-37a9aedf4084',
      'Bumbleflower''s Sharepot',
      '{2}',
      2,
      'Artifact',
      'When this artifact enters, create a Food token. (It''s an artifact with "{2}, {T}, Sacrifice this token: You gain 3 life.")
{5}, {T}, Sacrifice this artifact: Destroy target nonland permanent. Activate only as a sorcery.',
      ARRAY[]::text[],
      'common',
      'blb',
      '244',
      'https://cards.scryfall.io/normal/front/5/f/5f0affd5-5dcd-4dd1-a694-37a9aedf4084.jpg?1721427267',
      'https://cards.scryfall.io/small/front/5/f/5f0affd5-5dcd-4dd1-a694-37a9aedf4084.jpg?1721427267'
    ),
    (
      '87138ace-3594-499e-bad5-ec76148613ea',
      'Burrowguard Mentor',
      '{G}{W}',
      2,
      'Creature — Rabbit Soldier',
      'Trample
Burrowguard Mentor''s power and toughness are each equal to the number of creatures you control.',
      ARRAY['G','W']::text[],
      'uncommon',
      'blb',
      '206',
      'https://cards.scryfall.io/normal/front/8/7/87138ace-3594-499e-bad5-ec76148613ea.jpg?1721427007',
      'https://cards.scryfall.io/small/front/8/7/87138ace-3594-499e-bad5-ec76148613ea.jpg?1721427007'
    ),
    (
      '0de60cf7-fa82-4b6f-9f88-6590fba5c863',
      'Bushy Bodyguard',
      '{1}{G}',
      2,
      'Creature — Squirrel Warrior',
      'Offspring {2} (You may pay an additional {2} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
When this creature enters, you may forage. If you do, put two +1/+1 counters on it. (To forage, exile three cards from your graveyard or sacrifice a Food.)',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '166',
      'https://cards.scryfall.io/normal/front/0/d/0de60cf7-fa82-4b6f-9f88-6590fba5c863.jpg?1721426775',
      'https://cards.scryfall.io/small/front/0/d/0de60cf7-fa82-4b6f-9f88-6590fba5c863.jpg?1721426775'
    ),
    (
      '6441abd3-320b-424a-9753-61e3581fe1a9',
      'Byrke, Long Ear of the Law',
      '{4}{G}{W}',
      6,
      'Legendary Creature — Rabbit Soldier',
      'Vigilance
When Byrke enters, put a +1/+1 counter on each of up to two target creatures.
Whenever a creature you control with a +1/+1 counter on it attacks, double the number of +1/+1 counters on it.',
      ARRAY['G','W']::text[],
      'mythic',
      'blb',
      '380',
      'https://cards.scryfall.io/normal/front/6/4/6441abd3-320b-424a-9753-61e3581fe1a9.jpg?1726396879',
      'https://cards.scryfall.io/small/front/6/4/6441abd3-320b-424a-9753-61e3581fe1a9.jpg?1726396879'
    ),
    (
      'f41fc718-641b-4f32-a8c1-3e5591a05bf8',
      'Byway Barterer',
      '{2}{R}',
      3,
      'Creature — Raccoon Rogue',
      'Menace
Whenever you expend 4, you may discard your hand. If you do, draw two cards. (You expend 4 as you spend your fourth total mana to cast spells during a turn.)',
      ARRAY['R']::text[],
      'rare',
      'blb',
      '129',
      'https://cards.scryfall.io/normal/front/f/4/f41fc718-641b-4f32-a8c1-3e5591a05bf8.jpg?1721426591',
      'https://cards.scryfall.io/small/front/f/4/f41fc718-641b-4f32-a8c1-3e5591a05bf8.jpg?1721426591'
    ),
    (
      'dfd977dc-a7c3-4d0a-aca7-b25bd154e963',
      'Cache Grab',
      '{1}{G}',
      2,
      'Instant',
      'Mill four cards. You may put a permanent card from among the cards milled this way into your hand. If you control a Squirrel or returned a Squirrel card to your hand this way, create a Food token. (To mill four cards, put the top four cards of your library into your graveyard. A Food token is an artifact with "{2}, {T}, Sacrifice this token: You gain 3 life.")',
      ARRAY['G']::text[],
      'common',
      'blb',
      '167',
      'https://cards.scryfall.io/normal/front/d/f/dfd977dc-a7c3-4d0a-aca7-b25bd154e963.jpg?1721426785',
      'https://cards.scryfall.io/small/front/d/f/dfd977dc-a7c3-4d0a-aca7-b25bd154e963.jpg?1721426785'
    ),
    (
      '178bc8b2-ffa0-4549-aead-aacb3db3cf19',
      'Calamitous Tide',
      '{4}{U}{U}',
      6,
      'Sorcery',
      'Return up to two target creatures to their owners'' hands. Draw two cards, then discard a card.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '43',
      'https://cards.scryfall.io/normal/front/1/7/178bc8b2-ffa0-4549-aead-aacb3db3cf19.jpg?1721431233',
      'https://cards.scryfall.io/small/front/1/7/178bc8b2-ffa0-4549-aead-aacb3db3cf19.jpg?1721431233'
    ),
    (
      '2c16eaec-924c-42f6-9fea-07edd7ed93b9',
      'Camellia, the Seedmiser',
      '{1}{B}{G}',
      3,
      'Legendary Creature — Squirrel Warlock',
      'Menace
Other Squirrels you control have menace.
Whenever you sacrifice one or more Foods, create a 1/1 green Squirrel creature token.
{2}, Forage: Put a +1/+1 counter on each other Squirrel you control. (To forage, exile three cards from your graveyard or sacrifice a Food.)',
      ARRAY['B','G']::text[],
      'rare',
      'blb',
      '207',
      'https://cards.scryfall.io/normal/front/2/c/2c16eaec-924c-42f6-9fea-07edd7ed93b9.jpg?1721933903',
      'https://cards.scryfall.io/small/front/2/c/2c16eaec-924c-42f6-9fea-07edd7ed93b9.jpg?1721933903'
    ),
    (
      'ad5ea98a-e36e-4ab9-b4da-cc572f3777db',
      'Caretaker''s Talent',
      '{2}{W}',
      3,
      'Enchantment — Class',
      '(Gain the next level as a sorcery to add its ability.)
Whenever one or more tokens you control enter, draw a card. This ability triggers only once each turn.
{W}: Level 2
When this Class becomes level 2, create a token that''s a copy of target token you control.
{3}{W}: Level 3
Creature tokens you control get +2/+2.',
      ARRAY['W']::text[],
      'rare',
      'blb',
      '6',
      'https://cards.scryfall.io/normal/front/a/d/ad5ea98a-e36e-4ab9-b4da-cc572f3777db.jpg?1721425789',
      'https://cards.scryfall.io/small/front/a/d/ad5ea98a-e36e-4ab9-b4da-cc572f3777db.jpg?1721425789'
    ),
    (
      'eb03bb4f-8b4b-417e-bfc6-294cd2186b2e',
      'Carrot Cake',
      '{1}{W}',
      2,
      'Artifact — Food',
      'When this artifact enters and when you sacrifice it, create a 1/1 white Rabbit creature token and scry 1. (Look at the top card of your library. You may put that card on the bottom.)
{2}, {T}, Sacrifice this artifact: You gain 3 life.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '7',
      'https://cards.scryfall.io/normal/front/e/b/eb03bb4f-8b4b-417e-bfc6-294cd2186b2e.jpg?1721425791',
      'https://cards.scryfall.io/small/front/e/b/eb03bb4f-8b4b-417e-bfc6-294cd2186b2e.jpg?1721425791'
    ),
    (
      '7d171802-2604-45a5-a0f2-ab5afa1db5d5',
      'Charmed Sleep',
      '{1}{U}{U}',
      3,
      'Enchantment — Aura',
      'Enchant creature
When this Aura enters, tap enchanted creature.
Enchanted creature doesn''t untap during its controller''s untap step.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '388',
      'https://cards.scryfall.io/normal/front/7/d/7d171802-2604-45a5-a0f2-ab5afa1db5d5.jpg?1721428082',
      'https://cards.scryfall.io/small/front/7/d/7d171802-2604-45a5-a0f2-ab5afa1db5d5.jpg?1721428082'
    ),
    (
      'b2ea10dd-21ea-4622-be27-79d03a802b85',
      'Cindering Cutthroat',
      '{2}{B/R}',
      3,
      'Creature — Lizard Assassin',
      'This creature enters with a +1/+1 counter on it if an opponent lost life this turn.
{1}{B/R}: This creature gains menace until end of turn. (It can''t be blocked except by two or more creatures.)',
      ARRAY['B','R']::text[],
      'common',
      'blb',
      '208',
      'https://cards.scryfall.io/normal/front/b/2/b2ea10dd-21ea-4622-be27-79d03a802b85.jpg?1721427019',
      'https://cards.scryfall.io/small/front/b/2/b2ea10dd-21ea-4622-be27-79d03a802b85.jpg?1721427019'
    ),
    (
      '7028130c-c91d-4bf7-b0b0-450f71107d7a',
      'Clement, the Worrywort',
      '{1}{G}{U}',
      3,
      'Legendary Creature — Frog Druid',
      'Vigilance
Whenever Clement or another creature you control enters, return up to one target creature you control with lesser mana value to its owner''s hand.
Frogs you control have "{T}: Add {G} or {U}. Spend this mana only to cast a creature spell."',
      ARRAY['G','U']::text[],
      'rare',
      'blb',
      '209',
      'https://cards.scryfall.io/normal/front/7/0/7028130c-c91d-4bf7-b0b0-450f71107d7a.jpg?1721427029',
      'https://cards.scryfall.io/small/front/7/0/7028130c-c91d-4bf7-b0b0-450f71107d7a.jpg?1721427029'
    ),
    (
      '662d3bcc-65f3-4c69-8ea1-446870a1193d',
      'Clifftop Lookout',
      '{2}{G}',
      3,
      'Creature — Frog Scout',
      'Reach
When this creature enters, reveal cards from the top of your library until you reveal a land card. Put that card onto the battlefield tapped and the rest on the bottom of your library in a random order.',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '168',
      'https://cards.scryfall.io/normal/front/6/6/662d3bcc-65f3-4c69-8ea1-446870a1193d.jpg?1721426786',
      'https://cards.scryfall.io/small/front/6/6/662d3bcc-65f3-4c69-8ea1-446870a1193d.jpg?1721426786'
    ),
    (
      '96d5de3e-0440-4dd1-899c-ab40c0752343',
      'Coiling Rebirth',
      '{3}{B}{B}',
      5,
      'Sorcery',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, they draw a card before its other effects.)
Return target creature card from your graveyard to the battlefield. Then if the gift was promised and that creature isn''t legendary, create a token that''s a copy of that creature, except it''s 1/1.',
      ARRAY['B']::text[],
      'rare',
      'blb',
      '86',
      'https://cards.scryfall.io/normal/front/9/6/96d5de3e-0440-4dd1-899c-ab40c0752343.jpg?1721426359',
      'https://cards.scryfall.io/small/front/9/6/96d5de3e-0440-4dd1-899c-ab40c0752343.jpg?1721426359'
    ),
    (
      'c2cad902-ffd2-4bab-b114-b4b6df2ac6b3',
      'Colossification',
      '{5}{G}{G}',
      7,
      'Enchantment — Aura',
      'Enchant creature
When this Aura enters, tap enchanted creature.
Enchanted creature gets +20/+20.',
      ARRAY['G']::text[],
      'rare',
      'blb',
      '392',
      'https://cards.scryfall.io/normal/front/c/2/c2cad902-ffd2-4bab-b114-b4b6df2ac6b3.jpg?1721428099',
      'https://cards.scryfall.io/small/front/c/2/c2cad902-ffd2-4bab-b114-b4b6df2ac6b3.jpg?1721428099'
    ),
    (
      '2f373dd6-2412-453c-85ba-10230dfe473a',
      'Conduct Electricity',
      '{4}{R}',
      5,
      'Instant',
      'Conduct Electricity deals 6 damage to target creature and 2 damage to up to one target creature token.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '130',
      'https://cards.scryfall.io/normal/front/2/f/2f373dd6-2412-453c-85ba-10230dfe473a.jpg?1721426597',
      'https://cards.scryfall.io/small/front/2/f/2f373dd6-2412-453c-85ba-10230dfe473a.jpg?1721426597'
    ),
    (
      'e50acc41-3517-42db-b1d3-1bdfd7294d84',
      'Consumed by Greed',
      '{1}{B}{B}',
      3,
      'Instant',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, they draw a card before its other effects.)
Target opponent sacrifices a creature with the greatest power among creatures they control. If the gift was promised, return target creature card from your graveyard to your hand.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '87',
      'https://cards.scryfall.io/normal/front/e/5/e50acc41-3517-42db-b1d3-1bdfd7294d84.jpg?1721426362',
      'https://cards.scryfall.io/small/front/e/5/e50acc41-3517-42db-b1d3-1bdfd7294d84.jpg?1721426362'
    ),
    (
      'c911a759-ed7b-452b-88a3-663478357610',
      'Corpseberry Cultivator',
      '{1}{B/G}{B/G}',
      3,
      'Creature — Squirrel Warlock',
      'At the beginning of combat on your turn, you may forage. (Exile three cards from your graveyard or sacrifice a Food.)
Whenever you forage, put a +1/+1 counter on this creature.',
      ARRAY['B','G']::text[],
      'common',
      'blb',
      '210',
      'https://cards.scryfall.io/normal/front/c/9/c911a759-ed7b-452b-88a3-663478357610.jpg?1721427036',
      'https://cards.scryfall.io/small/front/c/9/c911a759-ed7b-452b-88a3-663478357610.jpg?1721427036'
    ),
    (
      'dc2c1de0-6233-469a-be72-a050b97d2c8f',
      'Coruscation Mage',
      '{1}{R}',
      2,
      'Creature — Otter Wizard',
      'Offspring {2} (You may pay an additional {2} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
Whenever you cast a noncreature spell, this creature deals 1 damage to each opponent.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '131',
      'https://cards.scryfall.io/normal/front/d/c/dc2c1de0-6233-469a-be72-a050b97d2c8f.jpg?1721426600',
      'https://cards.scryfall.io/small/front/d/c/dc2c1de0-6233-469a-be72-a050b97d2c8f.jpg?1721426600'
    ),
    (
      'cab4539a-0157-4cbe-b50f-6e2575df74e9',
      'Cruelclaw''s Heist',
      '{B}{B}',
      2,
      'Sorcery',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, they draw a card before its other effects.)
Target opponent reveals their hand. You choose a nonland card from it. Exile that card. If the gift was promised, you may cast that card for as long as it remains exiled, and mana of any type can be spent to cast it.',
      ARRAY['B']::text[],
      'rare',
      'blb',
      '88',
      'https://cards.scryfall.io/normal/front/c/a/cab4539a-0157-4cbe-b50f-6e2575df74e9.jpg?1721426377',
      'https://cards.scryfall.io/small/front/c/a/cab4539a-0157-4cbe-b50f-6e2575df74e9.jpg?1721426377'
    ),
    (
      '3c7b3b25-d4b3-4451-9f5c-6eb369541175',
      'Crumb and Get It',
      '{W}',
      1,
      'Instant',
      'Gift a Food (You may promise an opponent a gift as you cast this spell. If you do, they create a Food token before its other effects. It''s an artifact with "{2}, {T}, Sacrifice this token: You gain 3 life.")
Target creature you control gets +2/+2 until end of turn. If the gift was promised, that creature also gains indestructible until end of turn.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '8',
      'https://cards.scryfall.io/normal/front/3/c/3c7b3b25-d4b3-4451-9f5c-6eb369541175.jpg?1721429540',
      'https://cards.scryfall.io/small/front/3/c/3c7b3b25-d4b3-4451-9f5c-6eb369541175.jpg?1721429540'
    ),
    (
      '64653b4a-e139-45f9-a915-ab49afb6b795',
      'Curious Forager',
      '{2}{G}',
      3,
      'Creature — Squirrel Druid',
      'When this creature enters, you may forage. When you do, return target permanent card from your graveyard to your hand. (To forage, exile three cards from your graveyard or sacrifice a Food.)',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '169',
      'https://cards.scryfall.io/normal/front/6/4/64653b4a-e139-45f9-a915-ab49afb6b795.jpg?1721426795',
      'https://cards.scryfall.io/small/front/6/4/64653b4a-e139-45f9-a915-ab49afb6b795.jpg?1721426795'
    )
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
    image_uri_small = EXCLUDED.image_uri_small;