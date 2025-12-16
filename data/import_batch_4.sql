INSERT INTO cards (
    id, name, mana_cost, cmc, type_line, oracle_text,
    colors, rarity, set_code, collector_number, image_uri, image_uri_small
  )
  VALUES
    (
      '8ba1bc5a-03e7-44ec-893e-44042cbc02ef',
      'Mouse Trapper',
      '{2}{W}',
      3,
      'Creature — Mouse Soldier',
      'Flash
Valiant — Whenever this creature becomes the target of a spell or ability you control for the first time each turn, tap target creature an opponent controls.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '22',
      'https://cards.scryfall.io/normal/front/8/b/8ba1bc5a-03e7-44ec-893e-44042cbc02ef.jpg?1721425888',
      'https://cards.scryfall.io/small/front/8/b/8ba1bc5a-03e7-44ec-893e-44042cbc02ef.jpg?1721425888'
    ),
    (
      '53ec4ad3-9cf0-4f1b-a9db-d63feee594ab',
      'Mudflat Village',
      '',
      0,
      'Land',
      '{T}: Add {C}.
{T}: Add {B}. Spend this mana only to cast a creature spell.
{1}{B}, {T}, Sacrifice this land: Return target Bat, Lizard, Rat, or Squirrel card from your graveyard to your hand.',
      ARRAY[]::text[],
      'uncommon',
      'blb',
      '257',
      'https://cards.scryfall.io/normal/front/5/3/53ec4ad3-9cf0-4f1b-a9db-d63feee594ab.jpg?1721639657',
      'https://cards.scryfall.io/small/front/5/3/53ec4ad3-9cf0-4f1b-a9db-d63feee594ab.jpg?1721639657'
    ),
    (
      'b40e4658-fd68-46d0-9a89-25570a023d19',
      'Muerra, Trash Tactician',
      '{1}{R}{G}',
      3,
      'Legendary Creature — Raccoon Warrior',
      'At the beginning of your first main phase, add {R} or {G} for each Raccoon you control.
Whenever you expend 4, you gain 3 life. (You expend 4 as you spend your fourth total mana to cast spells during a turn.)
Whenever you expend 8, exile the top two cards of your library. Until the end of your next turn, you may play those cards.',
      ARRAY['G','R']::text[],
      'rare',
      'blb',
      '227',
      'https://cards.scryfall.io/normal/front/b/4/b40e4658-fd68-46d0-9a89-25570a023d19.jpg?1721427159',
      'https://cards.scryfall.io/small/front/b/4/b40e4658-fd68-46d0-9a89-25570a023d19.jpg?1721427159'
    ),
    (
      '8c9c3cc3-2aa2-453e-a17c-2baeeaabe0a9',
      'Nettle Guard',
      '{1}{W}',
      2,
      'Creature — Mouse Soldier',
      'Valiant — Whenever this creature becomes the target of a spell or ability you control for the first time each turn, it gets +0/+2 until end of turn.
{1}, Sacrifice this creature: Destroy target artifact or enchantment.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '23',
      'https://cards.scryfall.io/normal/front/8/c/8c9c3cc3-2aa2-453e-a17c-2baeeaabe0a9.jpg?1721425890',
      'https://cards.scryfall.io/small/front/8/c/8c9c3cc3-2aa2-453e-a17c-2baeeaabe0a9.jpg?1721425890'
    ),
    (
      '0928e04f-2568-41e8-b603-7a25cf5f94d0',
      'Nightwhorl Hermit',
      '{2}{U}',
      3,
      'Creature — Rat Rogue',
      'Vigilance
Threshold — As long as there are seven or more cards in your graveyard, this creature gets +1/+0 and can''t be blocked.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '62',
      'https://cards.scryfall.io/normal/front/0/9/0928e04f-2568-41e8-b603-7a25cf5f94d0.jpg?1721426168',
      'https://cards.scryfall.io/small/front/0/9/0928e04f-2568-41e8-b603-7a25cf5f94d0.jpg?1721426168'
    ),
    (
      '742c0409-9abd-4559-b52e-932cc90c531a',
      'Nocturnal Hunger',
      '{2}{B}',
      3,
      'Instant',
      'Gift a Food (You may promise an opponent a gift as you cast this spell. If you do, they create a Food token before its other effects. It''s an artifact with "{2}, {T}, Sacrifice this token: You gain 3 life.")
Destroy target creature. If the gift wasn''t promised, you lose 2 life.',
      ARRAY['B']::text[],
      'common',
      'blb',
      '102',
      'https://cards.scryfall.io/normal/front/7/4/742c0409-9abd-4559-b52e-932cc90c531a.jpg?1721426459',
      'https://cards.scryfall.io/small/front/7/4/742c0409-9abd-4559-b52e-932cc90c531a.jpg?1721426459'
    ),
    (
      '0d49b016-b02b-459f-85e9-c04f6bdcb94e',
      'Oakhollow Village',
      '',
      0,
      'Land',
      '{T}: Add {C}.
{T}: Add {G}. Spend this mana only to cast a creature spell.
{G}, {T}: Put a +1/+1 counter on each Frog, Rabbit, Raccoon, or Squirrel you control that entered the battlefield this turn.',
      ARRAY[]::text[],
      'uncommon',
      'blb',
      '258',
      'https://cards.scryfall.io/normal/front/0/d/0d49b016-b02b-459f-85e9-c04f6bdcb94e.jpg?1721639587',
      'https://cards.scryfall.io/small/front/0/d/0d49b016-b02b-459f-85e9-c04f6bdcb94e.jpg?1721639587'
    ),
    (
      '7d8238dd-858f-466c-96de-986bd66861d7',
      'Osteomancer Adept',
      '{1}{B}',
      2,
      'Creature — Squirrel Warlock',
      'Deathtouch
{T}: Until end of turn, you may cast creature spells from your graveyard by foraging in addition to paying their other costs. If you cast a spell this way, that creature enters with a finality counter on it. (To forage, exile three cards from your graveyard or sacrifice a Food. If a creature with a finality counter on it would die, exile it instead.)',
      ARRAY['B']::text[],
      'rare',
      'blb',
      '103',
      'https://cards.scryfall.io/normal/front/7/d/7d8238dd-858f-466c-96de-986bd66861d7.jpg?1721426463',
      'https://cards.scryfall.io/small/front/7/d/7d8238dd-858f-466c-96de-986bd66861d7.jpg?1721426463'
    ),
    (
      '3ff83ff7-e428-4ccc-8341-f223dab76bd1',
      'Otterball Antics',
      '{1}{U}',
      2,
      'Sorcery',
      'Create a 1/1 blue and red Otter creature token with prowess. If this spell was cast from anywhere other than your hand, put a +1/+1 counter on that creature. (Whenever you cast a noncreature spell, a creature with prowess gets +1/+1 until end of turn.)
Flashback {3}{U} (You may cast this card from your graveyard for its flashback cost. Then exile it.)',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '63',
      'https://cards.scryfall.io/normal/front/3/f/3ff83ff7-e428-4ccc-8341-f223dab76bd1.jpg?1721426185',
      'https://cards.scryfall.io/small/front/3/f/3ff83ff7-e428-4ccc-8341-f223dab76bd1.jpg?1721426185'
    ),
    (
      '079e979f-b618-4625-989c-e0ea5b61ed8a',
      'Overprotect',
      '{1}{G}',
      2,
      'Instant',
      'Target creature you control gets +3/+3 and gains trample, hexproof, and indestructible until end of turn.',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '185',
      'https://cards.scryfall.io/normal/front/0/7/079e979f-b618-4625-989c-e0ea5b61ed8a.jpg?1721426880',
      'https://cards.scryfall.io/small/front/0/7/079e979f-b618-4625-989c-e0ea5b61ed8a.jpg?1721426880'
    ),
    (
      '1086e826-94b8-4398-8a38-d8eacca56a43',
      'Parting Gust',
      '{W}{W}',
      2,
      'Instant',
      'Gift a tapped Fish (You may promise an opponent a gift as you cast this spell. If you do, they create a tapped 1/1 blue Fish creature token before its other effects.)
Exile target nontoken creature. If the gift wasn''t promised, return that card to the battlefield under its owner''s control with a +1/+1 counter on it at the beginning of the next end step.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '24',
      'https://cards.scryfall.io/normal/front/1/0/1086e826-94b8-4398-8a38-d8eacca56a43.jpg?1721425901',
      'https://cards.scryfall.io/small/front/1/0/1086e826-94b8-4398-8a38-d8eacca56a43.jpg?1721425901'
    ),
    (
      'a8a982c8-bc08-44ba-b3ed-9e4b124615d6',
      'Patchwork Banner',
      '{3}',
      3,
      'Artifact',
      'As this artifact enters, choose a creature type.
Creatures you control of the chosen type get +1/+1.
{T}: Add one mana of any color.',
      ARRAY[]::text[],
      'uncommon',
      'blb',
      '247',
      'https://cards.scryfall.io/normal/front/a/8/a8a982c8-bc08-44ba-b3ed-9e4b124615d6.jpg?1721427285',
      'https://cards.scryfall.io/small/front/a/8/a8a982c8-bc08-44ba-b3ed-9e4b124615d6.jpg?1721427285'
    ),
    (
      'b82c20ad-0f69-4822-ae76-770832cccdf7',
      'Pawpatch Formation',
      '{1}{G}',
      2,
      'Instant',
      'Choose one —
• Destroy target creature with flying.
• Destroy target enchantment.
• Draw a card. Create a Food token. (It''s an artifact with "{2}, {T}, Sacrifice this token: You gain 3 life.")',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '186',
      'https://cards.scryfall.io/normal/front/b/8/b82c20ad-0f69-4822-ae76-770832cccdf7.jpg?1721426886',
      'https://cards.scryfall.io/small/front/b/8/b82c20ad-0f69-4822-ae76-770832cccdf7.jpg?1721426886'
    ),
    (
      '7d4d88ba-0ee4-4f66-995b-2e50614f50ee',
      'Pawpatch Recruit',
      '{G}',
      1,
      'Creature — Rabbit Warrior',
      'Offspring {2} (You may pay an additional {2} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
Trample
Whenever a creature you control becomes the target of a spell or ability an opponent controls, put a +1/+1 counter on target creature you control other than that creature.',
      ARRAY['G']::text[],
      'rare',
      'blb',
      '187',
      'https://cards.scryfall.io/normal/front/7/d/7d4d88ba-0ee4-4f66-995b-2e50614f50ee.jpg?1721426891',
      'https://cards.scryfall.io/small/front/7/d/7d4d88ba-0ee4-4f66-995b-2e50614f50ee.jpg?1721426891'
    ),
    (
      '13cb9575-1138-4f99-8e90-0eaf00bdf4a1',
      'Pearl of Wisdom',
      '{2}{U}',
      3,
      'Sorcery',
      'This spell costs {1} less to cast if you control an Otter.
Draw two cards.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '64',
      'https://cards.scryfall.io/normal/front/1/3/13cb9575-1138-4f99-8e90-0eaf00bdf4a1.jpg?1721426185',
      'https://cards.scryfall.io/small/front/1/3/13cb9575-1138-4f99-8e90-0eaf00bdf4a1.jpg?1721426185'
    ),
    (
      '5f72466c-505b-4371-9366-0fde525a37e6',
      'Peerless Recycling',
      '{1}{G}',
      2,
      'Instant',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, they draw a card before its other effects.)
Return target permanent card from your graveyard to your hand. If the gift was promised, instead return two target permanent cards from your graveyard to your hand.',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '188',
      'https://cards.scryfall.io/normal/front/5/f/5f72466c-505b-4371-9366-0fde525a37e6.jpg?1721426897',
      'https://cards.scryfall.io/small/front/5/f/5f72466c-505b-4371-9366-0fde525a37e6.jpg?1721426897'
    ),
    (
      '8b900c71-713b-4b7e-b4be-ad9f4aa0c139',
      'Persistent Marshstalker',
      '{1}{B}',
      2,
      'Creature — Rat Berserker',
      'This creature gets +1/+0 for each other Rat you control.
Threshold — Whenever you attack with one or more Rats, if there are seven or more cards in your graveyard, you may pay {2}{B}. If you do, return this card from your graveyard to the battlefield tapped and attacking.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '104',
      'https://cards.scryfall.io/normal/front/8/b/8b900c71-713b-4b7e-b4be-ad9f4aa0c139.jpg?1721426469',
      'https://cards.scryfall.io/small/front/8/b/8b900c71-713b-4b7e-b4be-ad9f4aa0c139.jpg?1721426469'
    ),
    (
      'ae442cd6-c4df-4aad-9b1d-ccd936c5ec96',
      'Pileated Provisioner',
      '{4}{W}',
      5,
      'Creature — Bird Scout',
      'Flying
When this creature enters, put a +1/+1 counter on target creature you control without flying.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '25',
      'https://cards.scryfall.io/normal/front/a/e/ae442cd6-c4df-4aad-9b1d-ccd936c5ec96.jpg?1721425901',
      'https://cards.scryfall.io/small/front/a/e/ae442cd6-c4df-4aad-9b1d-ccd936c5ec96.jpg?1721425901'
    ),
    (
      '449d4122-ee9d-477c-976a-809ba8cb1443',
      'Plains',
      '',
      0,
      'Basic Land — Plains',
      '({T}: Add {W}.)',
      ARRAY[]::text[],
      'common',
      'blb',
      '369',
      'https://cards.scryfall.io/normal/front/4/4/449d4122-ee9d-477c-976a-809ba8cb1443.jpg?1721427984',
      'https://cards.scryfall.io/small/front/4/4/449d4122-ee9d-477c-976a-809ba8cb1443.jpg?1721427984'
    ),
    (
      '07956edf-34c1-4218-9784-ddbca13e380c',
      'Playful Shove',
      '{1}{R}',
      2,
      'Sorcery',
      'Playful Shove deals 1 damage to any target.
Draw a card.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '145',
      'https://cards.scryfall.io/normal/front/0/7/07956edf-34c1-4218-9784-ddbca13e380c.jpg?1721426672',
      'https://cards.scryfall.io/small/front/0/7/07956edf-34c1-4218-9784-ddbca13e380c.jpg?1721426672'
    ),
    (
      'f71320ed-2f30-49ce-bcb0-19aebba3f0e8',
      'Plumecreed Escort',
      '{1}{U}',
      2,
      'Creature — Bird Scout',
      'Flash
Flying
When this creature enters, target creature you control gains hexproof until end of turn.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '65',
      'https://cards.scryfall.io/normal/front/f/7/f71320ed-2f30-49ce-bcb0-19aebba3f0e8.jpg?1721426204',
      'https://cards.scryfall.io/small/front/f/7/f71320ed-2f30-49ce-bcb0-19aebba3f0e8.jpg?1721426204'
    ),
    (
      'b1aa988f-547e-449a-9f1a-296c01d68d96',
      'Plumecreed Mentor',
      '{1}{W}{U}',
      3,
      'Creature — Bird Scout',
      'Flying
Whenever this creature or another creature you control with flying enters, put a +1/+1 counter on target creature you control without flying.',
      ARRAY['U','W']::text[],
      'uncommon',
      'blb',
      '228',
      'https://cards.scryfall.io/normal/front/b/1/b1aa988f-547e-449a-9f1a-296c01d68d96.jpg?1721427166',
      'https://cards.scryfall.io/small/front/b/1/b1aa988f-547e-449a-9f1a-296c01d68d96.jpg?1721427166'
    ),
    (
      '6bc4963c-d90b-4588-bdb7-85956e42a623',
      'Polliwallop',
      '{3}{G}',
      4,
      'Instant',
      'Affinity for Frogs (This spell costs {1} less to cast for each Frog you control.)
Target creature you control deals damage equal to twice its power to target creature you don''t control.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '189',
      'https://cards.scryfall.io/normal/front/6/b/6bc4963c-d90b-4588-bdb7-85956e42a623.jpg?1721426903',
      'https://cards.scryfall.io/small/front/6/b/6bc4963c-d90b-4588-bdb7-85956e42a623.jpg?1721426903'
    ),
    (
      'fb959e74-61ea-453d-bb9f-ad0183c0e1b1',
      'Pond Prophet',
      '{G/U}{G/U}',
      2,
      'Creature — Frog Advisor',
      'When this creature enters, draw a card.',
      ARRAY['G','U']::text[],
      'common',
      'blb',
      '229',
      'https://cards.scryfall.io/normal/front/f/b/fb959e74-61ea-453d-bb9f-ad0183c0e1b1.jpg?1721427169',
      'https://cards.scryfall.io/small/front/f/b/fb959e74-61ea-453d-bb9f-ad0183c0e1b1.jpg?1721427169'
    ),
    (
      '8599e2dd-9164-4da3-814f-adccef3b9497',
      'Portent of Calamity',
      '{X}{U}',
      1,
      'Sorcery',
      'Reveal the top X cards of your library. For each card type, you may exile a card of that type from among them. Put the rest into your graveyard. You may cast a spell from among the exiled cards without paying its mana cost if you exiled four or more cards this way. Then put the rest of the exiled cards into your hand.',
      ARRAY['U']::text[],
      'rare',
      'blb',
      '66',
      'https://cards.scryfall.io/normal/front/8/5/8599e2dd-9164-4da3-814f-adccef3b9497.jpg?1721426215',
      'https://cards.scryfall.io/small/front/8/5/8599e2dd-9164-4da3-814f-adccef3b9497.jpg?1721426215'
    ),
    (
      'df900308-8432-4a0a-be21-17482026012b',
      'Psychic Whorl',
      '{2}{B}',
      3,
      'Sorcery',
      'Target opponent discards two cards. Then if you control a Rat, surveil 2. (Look at the top two cards of your library, then put any number of them into your graveyard and the rest on top of your library in any order.)',
      ARRAY['B']::text[],
      'common',
      'blb',
      '105',
      'https://cards.scryfall.io/normal/front/d/f/df900308-8432-4a0a-be21-17482026012b.jpg?1721426473',
      'https://cards.scryfall.io/small/front/d/f/df900308-8432-4a0a-be21-17482026012b.jpg?1721426473'
    ),
    (
      '2f2b7fd3-a139-49ea-8a89-b64261e868ef',
      'Quaketusk Boar',
      '{3}{R}{R}',
      5,
      'Creature — Elemental Boar',
      'Reach, trample, haste',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '146',
      'https://cards.scryfall.io/normal/front/2/f/2f2b7fd3-a139-49ea-8a89-b64261e868ef.jpg?1721426673',
      'https://cards.scryfall.io/small/front/2/f/2f2b7fd3-a139-49ea-8a89-b64261e868ef.jpg?1721426673'
    ),
    (
      'c4ded450-346d-4917-917a-b62bc0267509',
      'Rabbit Response',
      '{2}{W}{W}',
      4,
      'Instant',
      'Creatures you control get +2/+1 until end of turn. If you control a Rabbit, scry 2. (Look at the top two cards of your library, then put any number of them on the bottom and the rest on top in any order.)',
      ARRAY['W']::text[],
      'common',
      'blb',
      '26',
      'https://cards.scryfall.io/normal/front/c/4/c4ded450-346d-4917-917a-b62bc0267509.jpg?1721425917',
      'https://cards.scryfall.io/small/front/c/4/c4ded450-346d-4917-917a-b62bc0267509.jpg?1721425917'
    ),
    (
      '53a73200-b798-4bfd-a431-8b94e17b70be',
      'Rabid Bite',
      '{1}{G}',
      2,
      'Sorcery',
      'Target creature you control deals damage equal to its power to target creature you don''t control.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '394',
      'https://cards.scryfall.io/normal/front/5/3/53a73200-b798-4bfd-a431-8b94e17b70be.jpg?1721428112',
      'https://cards.scryfall.io/small/front/5/3/53a73200-b798-4bfd-a431-8b94e17b70be.jpg?1721428112'
    ),
    (
      '2f815bae-820a-49f6-8eed-46f658e7b6ff',
      'Rabid Gnaw',
      '{1}{R}',
      2,
      'Instant',
      'Target creature you control gets +1/+0 until end of turn. Then it deals damage equal to its power to target creature you don''t control.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '147',
      'https://cards.scryfall.io/normal/front/2/f/2f815bae-820a-49f6-8eed-46f658e7b6ff.jpg?1721426681',
      'https://cards.scryfall.io/small/front/2/f/2f815bae-820a-49f6-8eed-46f658e7b6ff.jpg?1721426681'
    ),
    (
      'b5b5180f-5a1c-4df8-9019-195e65a50ce3',
      'Raccoon Rallier',
      '{1}{R}',
      2,
      'Creature — Raccoon Bard',
      '{T}: Target creature you control gains haste until end of turn. Activate only as a sorcery.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '148',
      'https://cards.scryfall.io/normal/front/b/5/b5b5180f-5a1c-4df8-9019-195e65a50ce3.jpg?1721426682',
      'https://cards.scryfall.io/small/front/b/5/b5b5180f-5a1c-4df8-9019-195e65a50ce3.jpg?1721426682'
    ),
    (
      'acfde780-899a-4c5b-a39b-f4a3ff129103',
      'Ral, Crackling Wit',
      '{2}{U}{R}',
      4,
      'Legendary Planeswalker — Ral',
      'Whenever you cast a noncreature spell, put a loyalty counter on Ral.
+1: Create a 1/1 blue and red Otter creature token with prowess.
−3: Draw three cards, then discard two cards.
−10: Draw three cards. You get an emblem with "Instant and sorcery spells you cast have storm." (Whenever you cast an instant or sorcery spell, copy it for each spell cast before it this turn.)',
      ARRAY['R','U']::text[],
      'mythic',
      'blb',
      '230',
      'https://cards.scryfall.io/normal/front/a/c/acfde780-899a-4c5b-a39b-f4a3ff129103.jpg?1721427178',
      'https://cards.scryfall.io/small/front/a/c/acfde780-899a-4c5b-a39b-f4a3ff129103.jpg?1721427178'
    ),
    (
      '874510be-7ecd-4eff-abad-b9594eb4821a',
      'Ravine Raider',
      '{B}',
      1,
      'Creature — Lizard Rogue',
      'Menace (This creature can''t be blocked except by two or more creatures.)
{1}{B}: This creature gets +1/+1 until end of turn.',
      ARRAY['B']::text[],
      'common',
      'blb',
      '106',
      'https://cards.scryfall.io/normal/front/8/7/874510be-7ecd-4eff-abad-b9594eb4821a.jpg?1721426478',
      'https://cards.scryfall.io/small/front/8/7/874510be-7ecd-4eff-abad-b9594eb4821a.jpg?1721426478'
    ),
    (
      'd068192a-6270-4981-819d-4945fa4a2b83',
      'Repel Calamity',
      '{1}{W}',
      2,
      'Instant',
      'Destroy target creature with power or toughness 4 or greater.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '27',
      'https://cards.scryfall.io/normal/front/d/0/d068192a-6270-4981-819d-4945fa4a2b83.jpg?1721425920',
      'https://cards.scryfall.io/small/front/d/0/d068192a-6270-4981-819d-4945fa4a2b83.jpg?1721425920'
    ),
    (
      '81dec453-c9d7-42cb-980a-c82f82bede76',
      'Reptilian Recruiter',
      '{3}{R}{R}',
      5,
      'Creature — Lizard Warrior',
      'Trample
When this creature enters, choose target creature. If that creature''s power is 2 or less or if you control another Lizard, gain control of that creature until end of turn, untap it, and it gains haste until end of turn.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '149',
      'https://cards.scryfall.io/normal/front/8/1/81dec453-c9d7-42cb-980a-c82f82bede76.jpg?1721426690',
      'https://cards.scryfall.io/small/front/8/1/81dec453-c9d7-42cb-980a-c82f82bede76.jpg?1721426690'
    ),
    (
      '62799d24-39a6-4e66-8ac3-7cafa99e6e6d',
      'Rockface Village',
      '',
      0,
      'Land',
      '{T}: Add {C}.
{T}: Add {R}. Spend this mana only to cast a creature spell.
{R}, {T}: Target Lizard, Mouse, Otter, or Raccoon you control gets +1/+0 and gains haste until end of turn. Activate only as a sorcery.',
      ARRAY[]::text[],
      'uncommon',
      'blb',
      '259',
      'https://cards.scryfall.io/normal/front/6/2/62799d24-39a6-4e66-8ac3-7cafa99e6e6d.jpg?1721639562',
      'https://cards.scryfall.io/small/front/6/2/62799d24-39a6-4e66-8ac3-7cafa99e6e6d.jpg?1721639562'
    ),
    (
      '735e79b1-a3a9-4ddf-8bbc-f756c8a0452b',
      'Rottenmouth Viper',
      '{5}{B}',
      6,
      'Creature — Elemental Snake',
      'As an additional cost to cast this spell, you may sacrifice any number of nonland permanents. This spell costs {1} less to cast for each permanent sacrificed this way.
Whenever this creature enters or attacks, put a blight counter on it. Then for each blight counter on it, each opponent loses 4 life unless that player sacrifices a nonland permanent of their choice or discards a card.',
      ARRAY['B']::text[],
      'mythic',
      'blb',
      '107',
      'https://cards.scryfall.io/normal/front/7/3/735e79b1-a3a9-4ddf-8bbc-f756c8a0452b.jpg?1721426484',
      'https://cards.scryfall.io/small/front/7/3/735e79b1-a3a9-4ddf-8bbc-f756c8a0452b.jpg?1721426484'
    ),
    (
      '78cdcfb9-a247-4c2d-a098-5b57570f8cd5',
      'Roughshod Duo',
      '{2}{R}',
      3,
      'Creature — Mouse Raccoon',
      'Trample
Whenever you expend 4, target creature you control gets +1/+1 and gains trample until end of turn. (You expend 4 as you spend your fourth total mana to cast spells during a turn.)',
      ARRAY['R']::text[],
      'common',
      'blb',
      '150',
      'https://cards.scryfall.io/normal/front/7/8/78cdcfb9-a247-4c2d-a098-5b57570f8cd5.jpg?1721426692',
      'https://cards.scryfall.io/small/front/7/8/78cdcfb9-a247-4c2d-a098-5b57570f8cd5.jpg?1721426692'
    ),
    (
      '7cb7ec70-a5a4-4188-ba1a-e88b81bdbad0',
      'Run Away Together',
      '{1}{U}',
      2,
      'Instant',
      'Choose two target creatures controlled by different players. Return those creatures to their owners'' hands.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '67',
      'https://cards.scryfall.io/normal/front/7/c/7cb7ec70-a5a4-4188-ba1a-e88b81bdbad0.jpg?1721426215',
      'https://cards.scryfall.io/small/front/7/c/7cb7ec70-a5a4-4188-ba1a-e88b81bdbad0.jpg?1721426215'
    ),
    (
      'c96b01f5-83de-4237-a68d-f946c53e31a6',
      'Rust-Shield Rampager',
      '{3}{G}',
      4,
      'Creature — Raccoon Warrior',
      'Offspring {2} (You may pay an additional {2} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
This creature can''t be blocked by creatures with power 2 or less.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '190',
      'https://cards.scryfall.io/normal/front/c/9/c96b01f5-83de-4237-a68d-f946c53e31a6.jpg?1721426907',
      'https://cards.scryfall.io/small/front/c/9/c96b01f5-83de-4237-a68d-f946c53e31a6.jpg?1721426907'
    ),
    (
      'c7f4360c-8d68-4058-b9ec-da9948cb060d',
      'Ruthless Negotiation',
      '{B}',
      1,
      'Sorcery',
      'Target opponent exiles a card from their hand. If this spell was cast from a graveyard, draw a card.
Flashback {4}{B} (You may cast this card from your graveyard for its flashback cost. Then exile it.)',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '108',
      'https://cards.scryfall.io/normal/front/c/7/c7f4360c-8d68-4058-b9ec-da9948cb060d.jpg?1721426488',
      'https://cards.scryfall.io/small/front/c/7/c7f4360c-8d68-4058-b9ec-da9948cb060d.jpg?1721426488'
    ),
    (
      'b2656160-d319-4530-a6e5-c418596c3f12',
      'Salvation Swan',
      '{3}{W}',
      4,
      'Creature — Bird Cleric',
      'Flash
Flying
Whenever this creature or another Bird you control enters, exile up to one target creature you control without flying. Return it to the battlefield under its owner''s control with a flying counter on it at the beginning of the next end step.',
      ARRAY['W']::text[],
      'rare',
      'blb',
      '28',
      'https://cards.scryfall.io/normal/front/b/2/b2656160-d319-4530-a6e5-c418596c3f12.jpg?1721425931',
      'https://cards.scryfall.io/small/front/b/2/b2656160-d319-4530-a6e5-c418596c3f12.jpg?1721425931'
    ),
    (
      '1397f689-dca1-4d35-864b-92c5606afb9a',
      'Savor',
      '{1}{B}',
      2,
      'Instant',
      'Target creature gets -2/-2 until end of turn. Create a Food token. (It''s an artifact with "{2}, {T}, Sacrifice this token: You gain 3 life.")',
      ARRAY['B']::text[],
      'common',
      'blb',
      '109',
      'https://cards.scryfall.io/normal/front/1/3/1397f689-dca1-4d35-864b-92c5606afb9a.jpg?1721426493',
      'https://cards.scryfall.io/small/front/1/3/1397f689-dca1-4d35-864b-92c5606afb9a.jpg?1721426493'
    ),
    (
      '6d963080-b3ec-467d-82f7-39db6ecd6bbc',
      'Sazacap''s Brew',
      '{1}{R}',
      2,
      'Instant',
      'Gift a tapped Fish (You may promise an opponent a gift as you cast this spell. If you do, they create a tapped 1/1 blue Fish creature token before its other effects.)
As an additional cost to cast this spell, discard a card.
Target player draws two cards. If the gift was promised, target creature you control gets +2/+0 until end of turn.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '151',
      'https://cards.scryfall.io/normal/front/6/d/6d963080-b3ec-467d-82f7-39db6ecd6bbc.jpg?1721426699',
      'https://cards.scryfall.io/small/front/6/d/6d963080-b3ec-467d-82f7-39db6ecd6bbc.jpg?1721426699'
    ),
    (
      '9ae14276-dbbd-4257-80e9-accd6c19f5b2',
      'Scales of Shale',
      '{2}{B}',
      3,
      'Instant',
      'Affinity for Lizards (This spell costs {1} less to cast for each Lizard you control.)
Target creature gets +2/+0 and gains lifelink and indestructible until end of turn.',
      ARRAY['B']::text[],
      'common',
      'blb',
      '110',
      'https://cards.scryfall.io/normal/front/9/a/9ae14276-dbbd-4257-80e9-accd6c19f5b2.jpg?1721426499',
      'https://cards.scryfall.io/small/front/9/a/9ae14276-dbbd-4257-80e9-accd6c19f5b2.jpg?1721426499'
    ),
    (
      '9a52b7fe-87ae-425b-85fd-b24e6e0395f1',
      'Scavenger''s Talent',
      '{B}',
      1,
      'Enchantment — Class',
      '(Gain the next level as a sorcery to add its ability.)
Whenever one or more creatures you control die, create a Food token. This ability triggers only once each turn.
{1}{B}: Level 2
Whenever you sacrifice a permanent, target player mills two cards.
{2}{B}: Level 3
At the beginning of your end step, you may sacrifice three other nonland permanents. If you do, return a creature card from your graveyard to the battlefield with a finality counter on it.',
      ARRAY['B']::text[],
      'rare',
      'blb',
      '111',
      'https://cards.scryfall.io/normal/front/9/a/9a52b7fe-87ae-425b-85fd-b24e6e0395f1.jpg?1721814345',
      'https://cards.scryfall.io/small/front/9/a/9a52b7fe-87ae-425b-85fd-b24e6e0395f1.jpg?1721814345'
    ),
    (
      'c42ab407-e72d-4c48-9a9e-2055b5e71c69',
      'Scrapshooter',
      '{1}{G}{G}',
      3,
      'Creature — Raccoon Archer',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, when it enters, they draw a card.)
Reach
When this creature enters, if the gift was promised, destroy target artifact or enchantment an opponent controls.',
      ARRAY['G']::text[],
      'rare',
      'blb',
      '191',
      'https://cards.scryfall.io/normal/front/c/4/c42ab407-e72d-4c48-9a9e-2055b5e71c69.jpg?1721426916',
      'https://cards.scryfall.io/small/front/c/4/c42ab407-e72d-4c48-9a9e-2055b5e71c69.jpg?1721426916'
    ),
    (
      '90873995-876f-4e89-8bc7-41a74f4d931f',
      'Seasoned Warrenguard',
      '{W}',
      1,
      'Creature — Rabbit Warrior',
      'Whenever this creature attacks while you control a token, this creature gets +2/+0 until end of turn.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '30',
      'https://cards.scryfall.io/normal/front/9/0/90873995-876f-4e89-8bc7-41a74f4d931f.jpg?1721425942',
      'https://cards.scryfall.io/small/front/9/0/90873995-876f-4e89-8bc7-41a74f4d931f.jpg?1721425942'
    ),
    (
      '71dd3c27-e0d5-434e-a0f3-4a95245e21c2',
      'Season of Gathering',
      '{4}{G}{G}',
      6,
      'Sorcery',
      'Choose up to five {P} worth of modes. You may choose the same mode more than once.
{P} — Put a +1/+1 counter on a creature you control. It gains vigilance and trample until end of turn.
{P}{P} — Choose artifact or enchantment. Destroy all permanents of the chosen type.
{P}{P}{P} — Draw cards equal to the greatest power among creatures you control.',
      ARRAY['G']::text[],
      'mythic',
      'blb',
      '192',
      'https://cards.scryfall.io/normal/front/7/1/71dd3c27-e0d5-434e-a0f3-4a95245e21c2.jpg?1721426924',
      'https://cards.scryfall.io/small/front/7/1/71dd3c27-e0d5-434e-a0f3-4a95245e21c2.jpg?1721426924'
    ),
    (
      'cc540652-916b-45c5-ae5a-0a0bc557cee1',
      'Season of Loss',
      '{3}{B}{B}',
      5,
      'Sorcery',
      'Choose up to five {P} worth of modes. You may choose the same mode more than once.
{P} — Each player sacrifices a creature of their choice.
{P}{P} — Draw a card for each creature that died under your control this turn.
{P}{P}{P} — Each opponent loses X life, where X is the number of creature cards in your graveyard.',
      ARRAY['B']::text[],
      'mythic',
      'blb',
      '112',
      'https://cards.scryfall.io/normal/front/c/c/cc540652-916b-45c5-ae5a-0a0bc557cee1.jpg?1721426509',
      'https://cards.scryfall.io/small/front/c/c/cc540652-916b-45c5-ae5a-0a0bc557cee1.jpg?1721426509'
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