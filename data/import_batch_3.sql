INSERT INTO cards (
    id, name, mana_cost, cmc, type_line, oracle_text,
    colors, rarity, set_code, collector_number, image_uri, image_uri_small
  )
  VALUES
    (
      '7839ce48-0175-494a-ab89-9bdfb7a50cb1',
      'Heirloom Epic',
      '{1}',
      1,
      'Artifact',
      '{4}, {T}: Draw a card. For each mana in this ability''s activation cost, you may tap an untapped creature you control rather than pay that mana. Activate only as a sorcery.',
      ARRAY[]::text[],
      'uncommon',
      'blb',
      '246',
      'https://cards.scryfall.io/normal/front/7/8/7839ce48-0175-494a-ab89-9bdfb7a50cb1.jpg?1721427279',
      'https://cards.scryfall.io/small/front/7/8/7839ce48-0175-494a-ab89-9bdfb7a50cb1.jpg?1721427279'
    ),
    (
      '40339715-22d0-4f99-822b-a00d9824f27a',
      'Helga, Skittish Seer',
      '{G}{W}{U}',
      3,
      'Legendary Creature — Frog Druid',
      'Whenever you cast a creature spell with mana value 4 or greater, you draw a card, gain 1 life, and put a +1/+1 counter on Helga.
{T}: Add X mana of any one color, where X is Helga''s power. Spend this mana only to cast creature spells with mana value 4 or greater or creature spells with {X} in their mana costs.',
      ARRAY['G','U','W']::text[],
      'mythic',
      'blb',
      '217',
      'https://cards.scryfall.io/normal/front/4/0/40339715-22d0-4f99-822b-a00d9824f27a.jpg?1721427078',
      'https://cards.scryfall.io/small/front/4/0/40339715-22d0-4f99-822b-a00d9824f27a.jpg?1721427078'
    ),
    (
      '4ba8f2e7-8357-4862-97dc-1942d066023a',
      'Hidden Grotto',
      '',
      0,
      'Land',
      'When this land enters, surveil 1. (Look at the top card of your library. You may put it into your graveyard.)
{T}: Add {C}.
{1}, {T}: Add one mana of any color.',
      ARRAY[]::text[],
      'common',
      'blb',
      '254',
      'https://cards.scryfall.io/normal/front/4/b/4ba8f2e7-8357-4862-97dc-1942d066023a.jpg?1721427326',
      'https://cards.scryfall.io/small/front/4/b/4ba8f2e7-8357-4862-97dc-1942d066023a.jpg?1721427326'
    ),
    (
      '09c8cf4b-8e65-4a1c-b458-28b5ab56b390',
      'High Stride',
      '{G}',
      1,
      'Instant',
      'Target creature gets +1/+3 and gains reach until end of turn. Untap it.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '176',
      'https://cards.scryfall.io/normal/front/0/9/09c8cf4b-8e65-4a1c-b458-28b5ab56b390.jpg?1721426829',
      'https://cards.scryfall.io/small/front/0/9/09c8cf4b-8e65-4a1c-b458-28b5ab56b390.jpg?1721426829'
    ),
    (
      '1ae41080-0d67-4719-adb2-49bf2a268b6c',
      'Hired Claw',
      '{R}',
      1,
      'Creature — Lizard Mercenary',
      'Whenever you attack with one or more Lizards, this creature deals 1 damage to target opponent.
{1}{R}: Put a +1/+1 counter on this creature. Activate only if an opponent lost life this turn and only once each turn.',
      ARRAY['R']::text[],
      'rare',
      'blb',
      '140',
      'https://cards.scryfall.io/normal/front/1/a/1ae41080-0d67-4719-adb2-49bf2a268b6c.jpg?1721426641',
      'https://cards.scryfall.io/small/front/1/a/1ae41080-0d67-4719-adb2-49bf2a268b6c.jpg?1721426641'
    ),
    (
      '821970a3-a291-4fe9-bb13-dfc54f9c3caf',
      'Hivespine Wolverine',
      '{3}{G}{G}',
      5,
      'Creature — Elemental Wolverine',
      'When this creature enters, choose one —
• Put a +1/+1 counter on target creature you control.
• This creature fights target creature token.
• Destroy target artifact or enchantment.',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '177',
      'https://cards.scryfall.io/normal/front/8/2/821970a3-a291-4fe9-bb13-dfc54f9c3caf.jpg?1721426835',
      'https://cards.scryfall.io/small/front/8/2/821970a3-a291-4fe9-bb13-dfc54f9c3caf.jpg?1721426835'
    ),
    (
      'c2ed5079-07b4-4575-a2c8-5f0cbff888c3',
      'Hoarder''s Overflow',
      '{1}{R}',
      2,
      'Enchantment',
      'When this enchantment enters and whenever you expend 4, put a stash counter on it. (You expend 4 as you spend your fourth total mana to cast spells during a turn.)
{1}{R}, Sacrifice this enchantment: Discard your hand, then draw cards equal to the number of stash counters on this enchantment.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '141',
      'https://cards.scryfall.io/normal/front/c/2/c2ed5079-07b4-4575-a2c8-5f0cbff888c3.jpg?1721426652',
      'https://cards.scryfall.io/small/front/c/2/c2ed5079-07b4-4575-a2c8-5f0cbff888c3.jpg?1721426652'
    ),
    (
      'bc5ee537-52e1-474a-9326-dfacc2a758ab',
      'Honored Dreyleader',
      '{2}{G}',
      3,
      'Creature — Squirrel Warrior',
      'Trample
When this creature enters, put a +1/+1 counter on it for each other Squirrel and/or Food you control.
Whenever another Squirrel or Food you control enters, put a +1/+1 counter on this creature.',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '178',
      'https://cards.scryfall.io/normal/front/b/c/bc5ee537-52e1-474a-9326-dfacc2a758ab.jpg?1721426839',
      'https://cards.scryfall.io/small/front/b/c/bc5ee537-52e1-474a-9326-dfacc2a758ab.jpg?1721426839'
    ),
    (
      'ee7207f8-5daa-42af-aeea-7a489047110b',
      'Hop to It',
      '{2}{W}',
      3,
      'Sorcery',
      'Create three 1/1 white Rabbit creature tokens.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '16',
      'https://cards.scryfall.io/normal/front/e/e/ee7207f8-5daa-42af-aeea-7a489047110b.jpg?1721425854',
      'https://cards.scryfall.io/small/front/e/e/ee7207f8-5daa-42af-aeea-7a489047110b.jpg?1721425854'
    ),
    (
      'f09d7f4a-c947-4389-befa-1d547d0d1237',
      'Hugs, Grisly Guardian',
      '{X}{R}{R}{G}{G}',
      4,
      'Legendary Creature — Badger Warrior',
      'Trample
When Hugs enters, exile the top X cards of your library. Until the end of your next turn, you may play those cards.
You may play an additional land on each of your turns.',
      ARRAY['G','R']::text[],
      'mythic',
      'blb',
      '218',
      'https://cards.scryfall.io/normal/front/f/0/f09d7f4a-c947-4389-befa-1d547d0d1237.jpg?1721427081',
      'https://cards.scryfall.io/small/front/f/0/f09d7f4a-c947-4389-befa-1d547d0d1237.jpg?1721427081'
    ),
    (
      'e9a31863-9649-4a4f-99e4-c93729938bd7',
      'Hunter''s Talent',
      '{1}{G}',
      2,
      'Enchantment — Class',
      '(Gain the next level as a sorcery to add its ability.)
When this Class enters, target creature you control deals damage equal to its power to target creature you don''t control.
{1}{G}: Level 2
Whenever you attack, target attacking creature gets +1/+0 and gains trample until end of turn.
{3}{G}: Level 3
At the beginning of your end step, if you control a creature with power 4 or greater, draw a card.',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '179',
      'https://cards.scryfall.io/normal/front/e/9/e9a31863-9649-4a4f-99e4-c93729938bd7.jpg?1739659559',
      'https://cards.scryfall.io/small/front/e/9/e9a31863-9649-4a4f-99e4-c93729938bd7.jpg?1739659559'
    ),
    (
      'ed2f61d7-4eb0-41c5-8a34-a0793c2abc51',
      'Huskburster Swarm',
      '{7}{B}',
      8,
      'Creature — Elemental Insect',
      'This spell costs {1} less to cast for each creature card you own in exile and in your graveyard.
Menace, deathtouch',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '98',
      'https://cards.scryfall.io/normal/front/e/d/ed2f61d7-4eb0-41c5-8a34-a0793c2abc51.jpg?1721426437',
      'https://cards.scryfall.io/small/front/e/d/ed2f61d7-4eb0-41c5-8a34-a0793c2abc51.jpg?1721426437'
    ),
    (
      '941b0afc-0e8f-45f2-ae7f-07595e164611',
      'Innkeeper''s Talent',
      '{1}{G}',
      2,
      'Enchantment — Class',
      '(Gain the next level as a sorcery to add its ability.)
At the beginning of combat on your turn, put a +1/+1 counter on target creature you control.
{G}: Level 2
Permanents you control with counters on them have ward {1}.
{3}{G}: Level 3
If you would put one or more counters on a permanent or player, put twice that many of each of those kinds of counters on that permanent or player instead.',
      ARRAY['G']::text[],
      'rare',
      'blb',
      '180',
      'https://cards.scryfall.io/normal/front/9/4/941b0afc-0e8f-45f2-ae7f-07595e164611.jpg?1721814343',
      'https://cards.scryfall.io/small/front/9/4/941b0afc-0e8f-45f2-ae7f-07595e164611.jpg?1721814343'
    ),
    (
      '50b9575a-53d9-4df7-b86c-cda021107d3f',
      'Into the Flood Maw',
      '{U}',
      1,
      'Instant',
      'Gift a tapped Fish (You may promise an opponent a gift as you cast this spell. If you do, they create a tapped 1/1 blue Fish creature token before its other effects.)
Return target creature an opponent controls to its owner''s hand. If the gift was promised, instead return target nonland permanent an opponent controls to its owner''s hand.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '52',
      'https://cards.scryfall.io/normal/front/5/0/50b9575a-53d9-4df7-b86c-cda021107d3f.jpg?1721426097',
      'https://cards.scryfall.io/small/front/5/0/50b9575a-53d9-4df7-b86c-cda021107d3f.jpg?1721426097'
    ),
    (
      '4d70b99d-c8bf-4a56-8957-cf587fe60b81',
      'Intrepid Rabbit',
      '{2}{W}',
      3,
      'Creature — Rabbit Soldier',
      'Offspring {1} (You may pay an additional {1} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
When this creature enters, target creature you control gets +1/+1 until end of turn.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '17',
      'https://cards.scryfall.io/normal/front/4/d/4d70b99d-c8bf-4a56-8957-cf587fe60b81.jpg?1721425856',
      'https://cards.scryfall.io/small/front/4/d/4d70b99d-c8bf-4a56-8957-cf587fe60b81.jpg?1721425856'
    ),
    (
      'b2bc854c-4e72-48e0-a098-e3451d6e511d',
      'Iridescent Vinelasher',
      '{B}',
      1,
      'Creature — Lizard Assassin',
      'Offspring {2} (You may pay an additional {2} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
Landfall — Whenever a land you control enters, this creature deals 1 damage to target opponent.',
      ARRAY['B']::text[],
      'rare',
      'blb',
      '99',
      'https://cards.scryfall.io/normal/front/b/2/b2bc854c-4e72-48e0-a098-e3451d6e511d.jpg?1721426442',
      'https://cards.scryfall.io/small/front/b/2/b2bc854c-4e72-48e0-a098-e3451d6e511d.jpg?1721426442'
    ),
    (
      '46848fc2-ba58-4738-b4ce-0399d9053f48',
      'Island',
      '',
      0,
      'Basic Land — Island',
      '({T}: Add {U}.)',
      ARRAY[]::text[],
      'common',
      'blb',
      '371',
      'https://cards.scryfall.io/normal/front/4/6/46848fc2-ba58-4738-b4ce-0399d9053f48.jpg?1721427993',
      'https://cards.scryfall.io/small/front/4/6/46848fc2-ba58-4738-b4ce-0399d9053f48.jpg?1721427993'
    ),
    (
      '121af600-6143-450a-9f87-12ce4833f1ec',
      'Jackdaw Savior',
      '{2}{W}',
      3,
      'Creature — Bird Cleric',
      'Flying
Whenever this creature or another creature you control with flying dies, return another target creature card with lesser mana value from your graveyard to the battlefield.',
      ARRAY['W']::text[],
      'rare',
      'blb',
      '18',
      'https://cards.scryfall.io/normal/front/1/2/121af600-6143-450a-9f87-12ce4833f1ec.jpg?1721425865',
      'https://cards.scryfall.io/small/front/1/2/121af600-6143-450a-9f87-12ce4833f1ec.jpg?1721425865'
    ),
    (
      '0eab51d6-ba17-4a8c-8834-25db363f2b6b',
      'Jolly Gerbils',
      '{1}{W}',
      2,
      'Creature — Hamster Citizen',
      'Whenever you give a gift, draw a card.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '19',
      'https://cards.scryfall.io/normal/front/0/e/0eab51d6-ba17-4a8c-8834-25db363f2b6b.jpg?1721425868',
      'https://cards.scryfall.io/small/front/0/e/0eab51d6-ba17-4a8c-8834-25db363f2b6b.jpg?1721425868'
    ),
    (
      '918fd89b-5ab7-4ae2-920c-faca5e9da7b9',
      'Junkblade Bruiser',
      '{3}{R/G}{R/G}',
      5,
      'Creature — Raccoon Berserker',
      'Trample
Whenever you expend 4, this creature gets +2/+1 until end of turn. (You expend 4 as you spend your fourth total mana to cast spells during a turn.)',
      ARRAY['G','R']::text[],
      'common',
      'blb',
      '220',
      'https://cards.scryfall.io/normal/front/9/1/918fd89b-5ab7-4ae2-920c-faca5e9da7b9.jpg?1721427100',
      'https://cards.scryfall.io/small/front/9/1/918fd89b-5ab7-4ae2-920c-faca5e9da7b9.jpg?1721427100'
    ),
    (
      'ebf68793-22a2-4a59-9d37-6791584edca1',
      'Kastral, the Windcrested',
      '{3}{W}{U}',
      5,
      'Legendary Creature — Bird Scout',
      'Flying
Whenever one or more Birds you control deal combat damage to a player, choose one —
• You may put a Bird creature card from your hand or graveyard onto the battlefield with a finality counter on it.
• Put a +1/+1 counter on each Bird you control.
• Draw a card.',
      ARRAY['U','W']::text[],
      'rare',
      'blb',
      '221',
      'https://cards.scryfall.io/normal/front/e/b/ebf68793-22a2-4a59-9d37-6791584edca1.jpg?1721427101',
      'https://cards.scryfall.io/small/front/e/b/ebf68793-22a2-4a59-9d37-6791584edca1.jpg?1721427101'
    ),
    (
      '8cf33d80-0704-4dc4-8e8d-1dcbcbc35add',
      'Keen-Eyed Curator',
      '{G}{G}',
      2,
      'Creature — Raccoon Scout',
      'As long as there are four or more card types among cards exiled with this creature, it gets +4/+4 and has trample.
{1}: Exile target card from a graveyard.',
      ARRAY['G']::text[],
      'rare',
      'blb',
      '181',
      'https://cards.scryfall.io/normal/front/8/c/8cf33d80-0704-4dc4-8e8d-1dcbcbc35add.jpg?1721426856',
      'https://cards.scryfall.io/small/front/8/c/8cf33d80-0704-4dc4-8e8d-1dcbcbc35add.jpg?1721426856'
    ),
    (
      'a839fba3-1b66-4dd1-bf43-9b015b44fc81',
      'Kindlespark Duo',
      '{2}{R}',
      3,
      'Creature — Lizard Otter',
      '{T}: This creature deals 1 damage to target opponent.
Whenever you cast a noncreature spell, untap this creature.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '142',
      'https://cards.scryfall.io/normal/front/a/8/a839fba3-1b66-4dd1-bf43-9b015b44fc81.jpg?1721426652',
      'https://cards.scryfall.io/small/front/a/8/a839fba3-1b66-4dd1-bf43-9b015b44fc81.jpg?1721426652'
    ),
    (
      '085be5d1-fd85-46d1-ad39-a8aa75a06a96',
      'Kitnap',
      '{2}{U}{U}',
      4,
      'Enchantment — Aura',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, when it enters, they draw a card.)
Enchant creature
When this Aura enters, tap enchanted creature. If the gift wasn''t promised, put three stun counters on it.
You control enchanted creature.',
      ARRAY['U']::text[],
      'rare',
      'blb',
      '53',
      'https://cards.scryfall.io/normal/front/0/8/085be5d1-fd85-46d1-ad39-a8aa75a06a96.jpg?1721426110',
      'https://cards.scryfall.io/small/front/0/8/085be5d1-fd85-46d1-ad39-a8aa75a06a96.jpg?1721426110'
    ),
    (
      'c8ff751a-ec64-41d5-b22c-2a483ad9a9b2',
      'Kitsa, Otterball Elite',
      '{1}{U}',
      2,
      'Legendary Creature — Otter Wizard',
      'Vigilance
Prowess (Whenever you cast a noncreature spell, this creature gets +1/+1 until end of turn.)
{T}: Draw a card, then discard a card.
{2}, {T}: Copy target instant or sorcery spell you control. You may choose new targets for the copy. Activate only if Kitsa''s power is 3 or greater.',
      ARRAY['U']::text[],
      'mythic',
      'blb',
      '54',
      'https://cards.scryfall.io/normal/front/c/8/c8ff751a-ec64-41d5-b22c-2a483ad9a9b2.jpg?1721426117',
      'https://cards.scryfall.io/small/front/c/8/c8ff751a-ec64-41d5-b22c-2a483ad9a9b2.jpg?1721426117'
    ),
    (
      'c7fb7f4f-2153-4527-8f11-adbf508d3533',
      'Knightfisher',
      '{3}{U}{U}',
      5,
      'Creature — Bird Knight',
      'Flying
Whenever another nontoken Bird you control enters, create a 1/1 blue Fish creature token.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '55',
      'https://cards.scryfall.io/normal/front/c/7/c7fb7f4f-2153-4527-8f11-adbf508d3533.jpg?1721426127',
      'https://cards.scryfall.io/small/front/c/7/c7fb7f4f-2153-4527-8f11-adbf508d3533.jpg?1721426127'
    ),
    (
      'ca543405-5e12-48a0-9a77-082ac9bcb2f2',
      'Lifecreed Duo',
      '{1}{W}',
      2,
      'Creature — Bat Bird',
      'Flying
Whenever another creature you control enters, you gain 1 life.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '20',
      'https://cards.scryfall.io/normal/front/c/a/ca543405-5e12-48a0-9a77-082ac9bcb2f2.jpg?1721425877',
      'https://cards.scryfall.io/small/front/c/a/ca543405-5e12-48a0-9a77-082ac9bcb2f2.jpg?1721425877'
    ),
    (
      '2f00c834-b4a9-45b8-bb3f-22c2a42314a0',
      'Lightshell Duo',
      '{3}{U}',
      4,
      'Creature — Rat Otter',
      'Prowess (Whenever you cast a noncreature spell, this creature gets +1/+1 until end of turn.)
When this creature enters, surveil 2. (Look at the top two cards of your library, then put any number of them into your graveyard and the rest on top of your library in any order.)',
      ARRAY['U']::text[],
      'common',
      'blb',
      '56',
      'https://cards.scryfall.io/normal/front/2/f/2f00c834-b4a9-45b8-bb3f-22c2a42314a0.jpg?1721426129',
      'https://cards.scryfall.io/small/front/2/f/2f00c834-b4a9-45b8-bb3f-22c2a42314a0.jpg?1721426129'
    ),
    (
      '7e95a7cc-ed77-4ca4-80db-61c0fc68bf50',
      'Lilypad Village',
      '',
      0,
      'Land',
      '{T}: Add {C}.
{T}: Add {U}. Spend this mana only to cast a creature spell.
{U}, {T}: Surveil 2. Activate only if a Bird, Frog, Otter, or Rat entered the battlefield under your control this turn.',
      ARRAY[]::text[],
      'uncommon',
      'blb',
      '255',
      'https://cards.scryfall.io/normal/front/7/e/7e95a7cc-ed77-4ca4-80db-61c0fc68bf50.jpg?1721639529',
      'https://cards.scryfall.io/small/front/7/e/7e95a7cc-ed77-4ca4-80db-61c0fc68bf50.jpg?1721639529'
    ),
    (
      '64de7b1f-a03e-4407-91f1-e108a2f26735',
      'Lilysplash Mentor',
      '{2}{G}{U}',
      4,
      'Creature — Frog Druid',
      'Reach
{1}{G}{U}: Exile another target creature you control, then return it to the battlefield under its owner''s control with a +1/+1 counter on it. Activate only as a sorcery.',
      ARRAY['G','U']::text[],
      'uncommon',
      'blb',
      '222',
      'https://cards.scryfall.io/normal/front/6/4/64de7b1f-a03e-4407-91f1-e108a2f26735.jpg?1721427132',
      'https://cards.scryfall.io/small/front/6/4/64de7b1f-a03e-4407-91f1-e108a2f26735.jpg?1721427132'
    ),
    (
      '7c267719-cd03-4003-b281-e732d5e42a1e',
      'Long River Lurker',
      '{2}{U}',
      3,
      'Creature — Frog Scout',
      'Ward {1}
Other Frogs you control have ward {1}.
When this creature enters, target creature you control can''t be blocked this turn. Whenever that creature deals combat damage this turn, you may exile it. If you do, return it to the battlefield under its owner''s control.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '57',
      'https://cards.scryfall.io/normal/front/7/c/7c267719-cd03-4003-b281-e732d5e42a1e.jpg?1721426137',
      'https://cards.scryfall.io/small/front/7/c/7c267719-cd03-4003-b281-e732d5e42a1e.jpg?1721426137'
    ),
    (
      '1c81d0fa-81a1-4f9b-a5fd-5a648fd01dea',
      'Long River''s Pull',
      '{U}{U}',
      2,
      'Instant',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, they draw a card before its other effects.)
Counter target creature spell. If the gift was promised, instead counter target spell.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '58',
      'https://cards.scryfall.io/normal/front/1/c/1c81d0fa-81a1-4f9b-a5fd-5a648fd01dea.jpg?1721426147',
      'https://cards.scryfall.io/small/front/1/c/1c81d0fa-81a1-4f9b-a5fd-5a648fd01dea.jpg?1721426147'
    ),
    (
      'c7ef748c-b5e5-4e7d-bf2e-d3e6c08edb42',
      'Longstalk Brawl',
      '{G}',
      1,
      'Sorcery',
      'Gift a tapped Fish (You may promise an opponent a gift as you cast this spell. If you do, they create a tapped 1/1 blue Fish creature token before its other effects.)
Choose target creature you control and target creature you don''t control. Put a +1/+1 counter on the creature you control if the gift was promised. Then those creatures fight each other.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '182',
      'https://cards.scryfall.io/normal/front/c/7/c7ef748c-b5e5-4e7d-bf2e-d3e6c08edb42.jpg?1721426861',
      'https://cards.scryfall.io/small/front/c/7/c7ef748c-b5e5-4e7d-bf2e-d3e6c08edb42.jpg?1721426861'
    ),
    (
      'ae4f3aaf-3960-48cd-b34b-32e4ae5ae088',
      'Lumra, Bellow of the Woods',
      '{4}{G}{G}',
      6,
      'Legendary Creature — Elemental Bear',
      'Vigilance, reach
Lumra''s power and toughness are each equal to the number of lands you control.
When Lumra enters, mill four cards. Then return all land cards from your graveyard to the battlefield tapped.',
      ARRAY['G']::text[],
      'mythic',
      'blb',
      '183',
      'https://cards.scryfall.io/normal/front/a/e/ae4f3aaf-3960-48cd-b34b-32e4ae5ae088.jpg?1721426865',
      'https://cards.scryfall.io/small/front/a/e/ae4f3aaf-3960-48cd-b34b-32e4ae5ae088.jpg?1721426865'
    ),
    (
      'a9ee50d4-c878-457b-964d-29c039ce9852',
      'Lunar Convocation',
      '{W}{B}',
      2,
      'Enchantment',
      'At the beginning of your end step, if you gained life this turn, each opponent loses 1 life.
At the beginning of your end step, if you gained and lost life this turn, create a 1/1 black Bat creature token with flying.
{1}{B}, Pay 2 life: Draw a card.',
      ARRAY['B','W']::text[],
      'rare',
      'blb',
      '223',
      'https://cards.scryfall.io/normal/front/a/9/a9ee50d4-c878-457b-964d-29c039ce9852.jpg?1721427132',
      'https://cards.scryfall.io/small/front/a/9/a9ee50d4-c878-457b-964d-29c039ce9852.jpg?1721427132'
    ),
    (
      '8ab9d56f-9178-4ec9-a5f6-b934f50d8d9d',
      'Lupinflower Village',
      '',
      0,
      'Land',
      '{T}: Add {C}.
{T}: Add {W}. Spend this mana only to cast a creature spell.
{1}{W}, {T}, Sacrifice this land: Look at the top six cards of your library. You may reveal a Bat, Bird, Mouse, or Rabbit card from among them and put it into your hand. Put the rest on the bottom of your library in a random order.',
      ARRAY[]::text[],
      'uncommon',
      'blb',
      '256',
      'https://cards.scryfall.io/normal/front/8/a/8ab9d56f-9178-4ec9-a5f6-b934f50d8d9d.jpg?1721639625',
      'https://cards.scryfall.io/small/front/8/a/8ab9d56f-9178-4ec9-a5f6-b934f50d8d9d.jpg?1721639625'
    ),
    (
      'be6627fd-729d-44f2-b6bf-5299f49d1e3d',
      'Mabel, Heir to Cragflame',
      '{1}{R}{W}',
      3,
      'Legendary Creature — Mouse Soldier',
      'Other Mice you control get +1/+1.
When Mabel enters, create Cragflame, a legendary colorless Equipment artifact token with "Equipped creature gets +1/+1 and has vigilance, trample, and haste" and equip {2}.',
      ARRAY['R','W']::text[],
      'rare',
      'blb',
      '224',
      'https://cards.scryfall.io/normal/front/b/e/be6627fd-729d-44f2-b6bf-5299f49d1e3d.jpg?1721427144',
      'https://cards.scryfall.io/small/front/b/e/be6627fd-729d-44f2-b6bf-5299f49d1e3d.jpg?1721427144'
    ),
    (
      '5cfcf83f-089c-4e35-855e-b61b98bb1cd8',
      'Mabel''s Mettle',
      '{1}{W}',
      2,
      'Instant',
      'Target creature gets +2/+2 until end of turn. Up to one other target creature gets +1/+1 until end of turn.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '21',
      'https://cards.scryfall.io/normal/front/5/c/5cfcf83f-089c-4e35-855e-b61b98bb1cd8.jpg?1721425880',
      'https://cards.scryfall.io/small/front/5/c/5cfcf83f-089c-4e35-855e-b61b98bb1cd8.jpg?1721425880'
    ),
    (
      'cf3320ec-c4e8-405a-982d-e009c58c9e21',
      'Maha, Its Feathers Night',
      '{3}{B}{B}',
      5,
      'Legendary Creature — Elemental Bird',
      'Flying, trample
Ward—Discard a card.
Creatures your opponents control have base toughness 1.',
      ARRAY['B']::text[],
      'mythic',
      'blb',
      '100',
      'https://cards.scryfall.io/normal/front/c/f/cf3320ec-c4e8-405a-982d-e009c58c9e21.jpg?1721426449',
      'https://cards.scryfall.io/small/front/c/f/cf3320ec-c4e8-405a-982d-e009c58c9e21.jpg?1721426449'
    ),
    (
      'db3832b5-e83f-4569-bd49-fb7b86fa2d47',
      'Manifold Mouse',
      '{1}{R}',
      2,
      'Creature — Mouse Soldier',
      'Offspring {2} (You may pay an additional {2} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
At the beginning of combat on your turn, target Mouse you control gains your choice of double strike or trample until end of turn.',
      ARRAY['R']::text[],
      'rare',
      'blb',
      '143',
      'https://cards.scryfall.io/normal/front/d/b/db3832b5-e83f-4569-bd49-fb7b86fa2d47.jpg?1721426663',
      'https://cards.scryfall.io/small/front/d/b/db3832b5-e83f-4569-bd49-fb7b86fa2d47.jpg?1721426663'
    ),
    (
      '509bf254-8a2b-4dfa-9ae5-386321b35e8b',
      'Might of the Meek',
      '{R}',
      1,
      'Instant',
      'Target creature gains trample until end of turn. It also gets +1/+0 until end of turn if you control a Mouse.
Draw a card.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '144',
      'https://cards.scryfall.io/normal/front/5/0/509bf254-8a2b-4dfa-9ae5-386321b35e8b.jpg?1721426663',
      'https://cards.scryfall.io/small/front/5/0/509bf254-8a2b-4dfa-9ae5-386321b35e8b.jpg?1721426663'
    ),
    (
      '507ba708-ca9b-453e-b4c2-23b6650eb5a8',
      'Mind Drill Assailant',
      '{2}{U/B}{U/B}',
      4,
      'Creature — Rat Warlock',
      'Threshold — As long as there are seven or more cards in your graveyard, this creature gets +3/+0.
{2}{U/B}: Surveil 1. (Look at the top card of your library. You may put it into your graveyard.)',
      ARRAY['B','U']::text[],
      'common',
      'blb',
      '225',
      'https://cards.scryfall.io/normal/front/5/0/507ba708-ca9b-453e-b4c2-23b6650eb5a8.jpg?1721427150',
      'https://cards.scryfall.io/small/front/5/0/507ba708-ca9b-453e-b4c2-23b6650eb5a8.jpg?1721427150'
    ),
    (
      '7e24fe6a-607b-49b8-9fca-cecb1e40de7f',
      'Mind Spiral',
      '{4}{U}',
      5,
      'Sorcery',
      'Gift a tapped Fish (You may promise an opponent a gift as you cast this spell. If you do, they create a tapped 1/1 blue Fish creature token before its other effects.)
Target player draws three cards. If the gift was promised, tap target creature an opponent controls and put a stun counter on it. (If a permanent with a stun counter would become untapped, remove one from it instead.)',
      ARRAY['U']::text[],
      'common',
      'blb',
      '59',
      'https://cards.scryfall.io/normal/front/7/e/7e24fe6a-607b-49b8-9fca-cecb1e40de7f.jpg?1721426147',
      'https://cards.scryfall.io/small/front/7/e/7e24fe6a-607b-49b8-9fca-cecb1e40de7f.jpg?1721426147'
    ),
    (
      'e7e7d174-eb7c-41ad-a241-cfbfdc71e3a7',
      'Mind Spring',
      '{X}{U}{U}',
      2,
      'Sorcery',
      'Draw X cards.',
      ARRAY['U']::text[],
      'rare',
      'blb',
      '389',
      'https://cards.scryfall.io/normal/front/e/7/e7e7d174-eb7c-41ad-a241-cfbfdc71e3a7.jpg?1721428086',
      'https://cards.scryfall.io/small/front/e/7/e7e7d174-eb7c-41ad-a241-cfbfdc71e3a7.jpg?1721428086'
    ),
    (
      'aaa10f34-5bfd-4d87-8f07-58de3b0f5663',
      'Mindwhisker',
      '{2}{U}',
      3,
      'Creature — Rat Wizard',
      'At the beginning of your upkeep, surveil 1. (Look at the top card of your library. You may put it into your graveyard.)
Threshold — As long as there are seven or more cards in your graveyard, creatures your opponents control get -1/-0.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '60',
      'https://cards.scryfall.io/normal/front/a/a/aaa10f34-5bfd-4d87-8f07-58de3b0f5663.jpg?1721426158',
      'https://cards.scryfall.io/small/front/a/a/aaa10f34-5bfd-4d87-8f07-58de3b0f5663.jpg?1721426158'
    ),
    (
      'e5246540-5a84-41d8-9e30-8e7a6c0e84e1',
      'Mistbreath Elder',
      '{G}',
      1,
      'Creature — Frog Warrior',
      'At the beginning of your upkeep, return another creature you control to its owner''s hand. If you do, put a +1/+1 counter on this creature. Otherwise, you may return this creature to its owner''s hand.',
      ARRAY['G']::text[],
      'rare',
      'blb',
      '184',
      'https://cards.scryfall.io/normal/front/e/5/e5246540-5a84-41d8-9e30-8e7a6c0e84e1.jpg?1721426876',
      'https://cards.scryfall.io/small/front/e/5/e5246540-5a84-41d8-9e30-8e7a6c0e84e1.jpg?1721426876'
    ),
    (
      'ade32396-8841-4ba4-8852-d11146607f21',
      'Mockingbird',
      '{X}{U}',
      1,
      'Creature — Bird Bard',
      'Flying
You may have this creature enter as a copy of any creature on the battlefield with mana value less than or equal to the amount of mana spent to cast this creature, except it''s a Bird in addition to its other types and it has flying.',
      ARRAY['U']::text[],
      'rare',
      'blb',
      '61',
      'https://cards.scryfall.io/normal/front/a/d/ade32396-8841-4ba4-8852-d11146607f21.jpg?1722388218',
      'https://cards.scryfall.io/small/front/a/d/ade32396-8841-4ba4-8852-d11146607f21.jpg?1722388218'
    ),
    (
      '35f2a71f-31e8-4b51-9dd4-51a5336b3b86',
      'Moonrise Cleric',
      '{1}{W/B}{W/B}',
      3,
      'Creature — Bat Cleric',
      'Flying
Whenever this creature attacks, you gain 1 life.',
      ARRAY['B','W']::text[],
      'common',
      'blb',
      '226',
      'https://cards.scryfall.io/normal/front/3/5/35f2a71f-31e8-4b51-9dd4-51a5336b3b86.jpg?1721427155',
      'https://cards.scryfall.io/small/front/3/5/35f2a71f-31e8-4b51-9dd4-51a5336b3b86.jpg?1721427155'
    ),
    (
      '59e4aa8d-1d06-48db-b205-aa2f1392bbcb',
      'Moonstone Harbinger',
      '{2}{B}',
      3,
      'Creature — Bat Warrior',
      'Flying, deathtouch
Whenever you gain or lose life during your turn, Bats you control get +1/+0 and gain deathtouch until end of turn. This ability triggers only once each turn.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '101',
      'https://cards.scryfall.io/normal/front/5/9/59e4aa8d-1d06-48db-b205-aa2f1392bbcb.jpg?1721426452',
      'https://cards.scryfall.io/small/front/5/9/59e4aa8d-1d06-48db-b205-aa2f1392bbcb.jpg?1721426452'
    ),
    (
      '4b827c54-8bfe-4ef5-830e-e17b8690bbe7',
      'Mountain',
      '',
      0,
      'Basic Land — Mountain',
      '({T}: Add {R}.)',
      ARRAY[]::text[],
      'common',
      'blb',
      '375',
      'https://cards.scryfall.io/normal/front/4/b/4b827c54-8bfe-4ef5-830e-e17b8690bbe7.jpg?1721428012',
      'https://cards.scryfall.io/small/front/4/b/4b827c54-8bfe-4ef5-830e-e17b8690bbe7.jpg?1721428012'
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