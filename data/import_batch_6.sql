INSERT INTO cards (
    id, name, mana_cost, cmc, type_line, oracle_text,
    colors, rarity, set_code, collector_number, image_uri, image_uri_small
  )
  VALUES
    (
      'ea2ca1b3-4c1a-4be5-b321-f57db5ff0528',
      'Three Tree Scribe',
      '{1}{G}',
      2,
      'Creature — Frog Druid',
      'Whenever this creature or another creature you control leaves the battlefield without dying, put a +1/+1 counter on target creature you control.',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '199',
      'https://cards.scryfall.io/normal/front/e/a/ea2ca1b3-4c1a-4be5-b321-f57db5ff0528.jpg?1721426968',
      'https://cards.scryfall.io/small/front/e/a/ea2ca1b3-4c1a-4be5-b321-f57db5ff0528.jpg?1721426968'
    ),
    (
      '9cf3af94-b7c8-415c-a5a1-d89967fd0bba',
      'Thundertrap Trainer',
      '{1}{U}',
      2,
      'Creature — Otter Wizard',
      'Offspring {4} (You may pay an additional {4} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
When this creature enters, look at the top four cards of your library. You may reveal a noncreature, nonland card from among them and put it into your hand. Put the rest on the bottom of your library in a random order.',
      ARRAY['U']::text[],
      'rare',
      'blb',
      '78',
      'https://cards.scryfall.io/normal/front/9/c/9cf3af94-b7c8-415c-a5a1-d89967fd0bba.jpg?1721426312',
      'https://cards.scryfall.io/small/front/9/c/9cf3af94-b7c8-415c-a5a1-d89967fd0bba.jpg?1721426312'
    ),
    (
      'fa10ffac-7cc2-41ef-b8a0-9431923c0542',
      'Tidecaller Mentor',
      '{1}{U}{B}',
      3,
      'Creature — Rat Wizard',
      'Menace
Threshold — When this creature enters, if there are seven or more cards in your graveyard, return up to one target nonland permanent to its owner''s hand.',
      ARRAY['B','U']::text[],
      'uncommon',
      'blb',
      '236',
      'https://cards.scryfall.io/normal/front/f/a/fa10ffac-7cc2-41ef-b8a0-9431923c0542.jpg?1721427215',
      'https://cards.scryfall.io/small/front/f/a/fa10ffac-7cc2-41ef-b8a0-9431923c0542.jpg?1721427215'
    ),
    (
      '89c8456e-c971-42b7-abf3-ff5ae1320abe',
      'Treeguard Duo',
      '{3}{G}',
      4,
      'Creature — Frog Rabbit',
      'When this creature enters, until end of turn, target creature you control gains vigilance and gets +X/+X, where X is the number of creatures you control.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '200',
      'https://cards.scryfall.io/normal/front/8/9/89c8456e-c971-42b7-abf3-ff5ae1320abe.jpg?1721426977',
      'https://cards.scryfall.io/small/front/8/9/89c8456e-c971-42b7-abf3-ff5ae1320abe.jpg?1721426977'
    ),
    (
      'e16d4d6e-1fe5-4ff6-9877-8c849a24f5e0',
      'Treetop Sentries',
      '{3}{G}',
      4,
      'Creature — Squirrel Archer',
      'Reach
When this creature enters, you may forage. If you do, draw a card. (To forage, exile three cards from your graveyard or sacrifice a Food.)',
      ARRAY['G']::text[],
      'common',
      'blb',
      '201',
      'https://cards.scryfall.io/normal/front/e/1/e16d4d6e-1fe5-4ff6-9877-8c849a24f5e0.jpg?1721426978',
      'https://cards.scryfall.io/small/front/e/1/e16d4d6e-1fe5-4ff6-9877-8c849a24f5e0.jpg?1721426978'
    ),
    (
      '68b90f54-d629-4126-82cc-13b51d6c1c3e',
      'Uncharted Haven',
      '',
      0,
      'Land',
      'This land enters tapped. As it enters, choose a color.
{T}: Add one mana of the chosen color.',
      ARRAY[]::text[],
      'common',
      'blb',
      '261',
      'https://cards.scryfall.io/normal/front/6/8/68b90f54-d629-4126-82cc-13b51d6c1c3e.jpg?1722073883',
      'https://cards.scryfall.io/small/front/6/8/68b90f54-d629-4126-82cc-13b51d6c1c3e.jpg?1722073883'
    ),
    (
      'a0812db4-b7d1-4cf7-aaa5-9c0e784079a1',
      'Valley Flamecaller',
      '{2}{R}',
      3,
      'Creature — Lizard Warlock',
      'If a Lizard, Mouse, Otter, or Raccoon you control would deal damage to a permanent or player, it deals that much damage plus 1 instead.',
      ARRAY['R']::text[],
      'rare',
      'blb',
      '158',
      'https://cards.scryfall.io/normal/front/a/0/a0812db4-b7d1-4cf7-aaa5-9c0e784079a1.jpg?1721639385',
      'https://cards.scryfall.io/small/front/a/0/a0812db4-b7d1-4cf7-aaa5-9c0e784079a1.jpg?1721639385'
    ),
    (
      '90b12da0-f666-471d-95f5-15d8c9b31c92',
      'Valley Floodcaller',
      '{2}{U}',
      3,
      'Creature — Otter Wizard',
      'Flash
You may cast noncreature spells as though they had flash.
Whenever you cast a noncreature spell, Birds, Frogs, Otters, and Rats you control get +1/+1 until end of turn. Untap them.',
      ARRAY['U']::text[],
      'rare',
      'blb',
      '79',
      'https://cards.scryfall.io/normal/front/9/0/90b12da0-f666-471d-95f5-15d8c9b31c92.jpg?1721639406',
      'https://cards.scryfall.io/small/front/9/0/90b12da0-f666-471d-95f5-15d8c9b31c92.jpg?1721639406'
    ),
    (
      '7256451f-0122-452a-88e8-0fb0f6bea3f3',
      'Valley Mightcaller',
      '{G}',
      1,
      'Creature — Frog Warrior',
      'Trample
Whenever another Frog, Rabbit, Raccoon, or Squirrel you control enters, put a +1/+1 counter on this creature.',
      ARRAY['G']::text[],
      'rare',
      'blb',
      '202',
      'https://cards.scryfall.io/normal/front/7/2/7256451f-0122-452a-88e8-0fb0f6bea3f3.jpg?1721639437',
      'https://cards.scryfall.io/small/front/7/2/7256451f-0122-452a-88e8-0fb0f6bea3f3.jpg?1721639437'
    ),
    (
      'ba629ca8-a368-4282-8a61-9bf6a5c217f0',
      'Valley Questcaller',
      '{1}{W}',
      2,
      'Creature — Rabbit Warrior',
      'Whenever one or more other Rabbits, Bats, Birds, and/or Mice you control enter, scry 1.
Other Rabbits, Bats, Birds, and Mice you control get +1/+1.',
      ARRAY['W']::text[],
      'rare',
      'blb',
      '36',
      'https://cards.scryfall.io/normal/front/b/a/ba629ca8-a368-4282-8a61-9bf6a5c217f0.jpg?1721639461',
      'https://cards.scryfall.io/small/front/b/a/ba629ca8-a368-4282-8a61-9bf6a5c217f0.jpg?1721639461'
    ),
    (
      'b6178258-1ad6-4122-a56f-6eb7d0611e84',
      'Valley Rally',
      '{2}{R}',
      3,
      'Instant',
      'Gift a Food (You may promise an opponent a gift as you cast this spell. If you do, they create a Food token before its other effects. It''s an artifact with "{2}, {T}, Sacrifice this token: You gain 3 life.")
Creatures you control get +2/+0 until end of turn. If the gift was promised, target creature you control gains first strike until end of turn.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '159',
      'https://cards.scryfall.io/normal/front/b/6/b6178258-1ad6-4122-a56f-6eb7d0611e84.jpg?1721426740',
      'https://cards.scryfall.io/small/front/b/6/b6178258-1ad6-4122-a56f-6eb7d0611e84.jpg?1721426740'
    ),
    (
      '4da80a9a-b1d5-4fc5-92f7-36946195d0c7',
      'Valley Rotcaller',
      '{1}{B}',
      2,
      'Creature — Squirrel Warlock',
      'Menace
Whenever this creature attacks, each opponent loses X life and you gain X life, where X is the number of other Squirrels, Bats, Lizards, and Rats you control.',
      ARRAY['B']::text[],
      'rare',
      'blb',
      '119',
      'https://cards.scryfall.io/normal/front/4/d/4da80a9a-b1d5-4fc5-92f7-36946195d0c7.jpg?1721639479',
      'https://cards.scryfall.io/small/front/4/d/4da80a9a-b1d5-4fc5-92f7-36946195d0c7.jpg?1721639479'
    ),
    (
      '3db43c46-b616-4ef8-80ed-0fab345ab3d0',
      'Veteran Guardmouse',
      '{3}{R/W}',
      4,
      'Creature — Mouse Soldier',
      'Valiant — Whenever this creature becomes the target of a spell or ability you control for the first time each turn, it gets +1/+0 and gains first strike until end of turn. Scry 1. (Look at the top card of your library. You may put that card on the bottom.)',
      ARRAY['R','W']::text[],
      'common',
      'blb',
      '237',
      'https://cards.scryfall.io/normal/front/3/d/3db43c46-b616-4ef8-80ed-0fab345ab3d0.jpg?1721427216',
      'https://cards.scryfall.io/small/front/3/d/3db43c46-b616-4ef8-80ed-0fab345ab3d0.jpg?1721427216'
    ),
    (
      '29b615ba-45c4-42a1-8525-1535f0b55300',
      'Vinereap Mentor',
      '{B}{G}',
      2,
      'Creature — Squirrel Druid',
      'When this creature enters or dies, create a Food token. (It''s an artifact with "{2}, {T}, Sacrifice this token: You gain 3 life.")',
      ARRAY['B','G']::text[],
      'uncommon',
      'blb',
      '238',
      'https://cards.scryfall.io/normal/front/2/9/29b615ba-45c4-42a1-8525-1535f0b55300.jpg?1721427225',
      'https://cards.scryfall.io/small/front/2/9/29b615ba-45c4-42a1-8525-1535f0b55300.jpg?1721427225'
    ),
    (
      '6506277d-f031-4db5-9d16-bf2389094785',
      'Vren, the Relentless',
      '{2}{U}{B}',
      4,
      'Legendary Creature — Rat Rogue',
      'Ward {2}
If a creature an opponent controls would die, exile it instead.
At the beginning of each end step, create X 1/1 black Rat creature tokens with "This token gets +1/+1 for each other Rat you control," where X is the number of creatures that were exiled under your opponents'' control this turn.',
      ARRAY['B','U']::text[],
      'rare',
      'blb',
      '239',
      'https://cards.scryfall.io/normal/front/6/5/6506277d-f031-4db5-9d16-bf2389094785.jpg?1721427225',
      'https://cards.scryfall.io/small/front/6/5/6506277d-f031-4db5-9d16-bf2389094785.jpg?1721427225'
    ),
    (
      '8c399a55-d02e-41ed-b827-8784b738c118',
      'Wandertale Mentor',
      '{R}{G}',
      2,
      'Creature — Raccoon Bard',
      'Whenever you expend 4, put a +1/+1 counter on this creature. (You expend 4 as you spend your fourth total mana to cast spells during a turn.)
{T}: Add {R} or {G}.',
      ARRAY['G','R']::text[],
      'uncommon',
      'blb',
      '240',
      'https://cards.scryfall.io/normal/front/8/c/8c399a55-d02e-41ed-b827-8784b738c118.jpg?1721427242',
      'https://cards.scryfall.io/small/front/8/c/8c399a55-d02e-41ed-b827-8784b738c118.jpg?1721427242'
    ),
    (
      '4bf20069-5a20-4f95-976b-6af2b69f3ad0',
      'Warren Elder',
      '{1}{W}',
      2,
      'Creature — Rabbit Cleric',
      '{3}{W}: Creatures you control get +1/+1 until end of turn.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '37',
      'https://cards.scryfall.io/normal/front/4/b/4bf20069-5a20-4f95-976b-6af2b69f3ad0.jpg?1721425988',
      'https://cards.scryfall.io/small/front/4/b/4bf20069-5a20-4f95-976b-6af2b69f3ad0.jpg?1721425988'
    ),
    (
      'eb5237a0-5ac3-4ded-9f92-5f782a7bbbd7',
      'Warren Warleader',
      '{2}{W}{W}',
      4,
      'Creature — Rabbit Knight',
      'Offspring {2} (You may pay an additional {2} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
Whenever you attack, choose one —
• Create a 1/1 white Rabbit creature token that''s tapped and attacking.
• Attacking creatures you control get +1/+1 until end of turn.',
      ARRAY['W']::text[],
      'mythic',
      'blb',
      '38',
      'https://cards.scryfall.io/normal/front/e/b/eb5237a0-5ac3-4ded-9f92-5f782a7bbbd7.jpg?1721425996',
      'https://cards.scryfall.io/small/front/e/b/eb5237a0-5ac3-4ded-9f92-5f782a7bbbd7.jpg?1721425996'
    ),
    (
      '105964a7-88b7-4340-aa66-e908189a3638',
      'War Squeak',
      '{R}',
      1,
      'Enchantment — Aura',
      'Enchant creature
When this Aura enters, target creature an opponent controls can''t block this turn.
Enchanted creature gets +1/+1 and has haste.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '160',
      'https://cards.scryfall.io/normal/front/1/0/105964a7-88b7-4340-aa66-e908189a3638.jpg?1721426742',
      'https://cards.scryfall.io/small/front/1/0/105964a7-88b7-4340-aa66-e908189a3638.jpg?1721426742'
    ),
    (
      '35898b39-98e2-405b-8f18-0e054bd2c29e',
      'Waterspout Warden',
      '{2}{U}',
      3,
      'Creature — Frog Soldier',
      'Whenever this creature attacks, if another creature entered the battlefield under your control this turn, this creature gains flying until end of turn.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '80',
      'https://cards.scryfall.io/normal/front/3/5/35898b39-98e2-405b-8f18-0e054bd2c29e.jpg?1722207696',
      'https://cards.scryfall.io/small/front/3/5/35898b39-98e2-405b-8f18-0e054bd2c29e.jpg?1722207696'
    ),
    (
      'd90ea719-5320-46c6-a347-161853a14776',
      'Wax-Wane Witness',
      '{3}{W}',
      4,
      'Creature — Bat Cleric',
      'Flying, vigilance
Whenever you gain or lose life during your turn, this creature gets +1/+0 until end of turn.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '39',
      'https://cards.scryfall.io/normal/front/d/9/d90ea719-5320-46c6-a347-161853a14776.jpg?1721426005',
      'https://cards.scryfall.io/small/front/d/9/d90ea719-5320-46c6-a347-161853a14776.jpg?1721426005'
    ),
    (
      'fded2b83-3b7d-4c8c-83c4-0624a1069628',
      'Wear Down',
      '{1}{G}',
      2,
      'Sorcery',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, they draw a card before its other effects.)
Destroy target artifact or enchantment. If the gift was promised, instead destroy two target artifacts and/or enchantments.',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '203',
      'https://cards.scryfall.io/normal/front/f/d/fded2b83-3b7d-4c8c-83c4-0624a1069628.jpg?1721426996',
      'https://cards.scryfall.io/small/front/f/d/fded2b83-3b7d-4c8c-83c4-0624a1069628.jpg?1721426996'
    ),
    (
      'da653996-9bd4-40bd-afb4-48c7e070a269',
      'Whiskerquill Scribe',
      '{1}{R}',
      2,
      'Creature — Mouse Citizen',
      'Valiant — Whenever this creature becomes the target of a spell or ability you control for the first time each turn, you may discard a card. If you do, draw a card.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '161',
      'https://cards.scryfall.io/normal/front/d/a/da653996-9bd4-40bd-afb4-48c7e070a269.jpg?1721431429',
      'https://cards.scryfall.io/small/front/d/a/da653996-9bd4-40bd-afb4-48c7e070a269.jpg?1721431429'
    ),
    (
      '60a78d59-af31-4af9-95aa-2573fe553925',
      'Whiskervale Forerunner',
      '{3}{W}',
      4,
      'Creature — Mouse Bard',
      'Valiant — Whenever this creature becomes the target of a spell or ability you control for the first time each turn, look at the top five cards of your library. You may reveal a creature card with mana value 3 or less from among them. You may put it onto the battlefield if it''s your turn. If you don''t put it onto the battlefield, put it into your hand. Put the rest on the bottom of your library in a random order.',
      ARRAY['W']::text[],
      'rare',
      'blb',
      '40',
      'https://cards.scryfall.io/normal/front/6/0/60a78d59-af31-4af9-95aa-2573fe553925.jpg?1721426007',
      'https://cards.scryfall.io/small/front/6/0/60a78d59-af31-4af9-95aa-2573fe553925.jpg?1721426007'
    ),
    (
      '5fa0c53d-fe7b-4b8b-ad81-7967ca318ff7',
      'Wick''s Patrol',
      '{4}{B}{B}',
      6,
      'Creature — Rat Warlock',
      'When this creature enters, mill three cards. When you do, target creature an opponent controls gets -X/-X until end of turn, where X is the greatest mana value among cards in your graveyard.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '121',
      'https://cards.scryfall.io/normal/front/5/f/5fa0c53d-fe7b-4b8b-ad81-7967ca318ff7.jpg?1721426557',
      'https://cards.scryfall.io/small/front/5/f/5fa0c53d-fe7b-4b8b-ad81-7967ca318ff7.jpg?1721426557'
    ),
    (
      '29089810-d7fb-4abe-b729-bfabed6aed2b',
      'Wick, the Whorled Mind',
      '{3}{B}',
      4,
      'Legendary Creature — Rat Warlock',
      'Whenever Wick or another Rat you control enters, create a 1/1 black Snail creature token if you don''t control a Snail. Otherwise, put a +1/+1 counter on a Snail you control.
{U}{B}{R}, Sacrifice a Snail: Wick deals damage equal to the sacrificed creature''s power to each opponent. Then draw cards equal to the sacrificed creature''s power.',
      ARRAY['B']::text[],
      'rare',
      'blb',
      '120',
      'https://cards.scryfall.io/normal/front/2/9/29089810-d7fb-4abe-b729-bfabed6aed2b.jpg?1721426554',
      'https://cards.scryfall.io/small/front/2/9/29089810-d7fb-4abe-b729-bfabed6aed2b.jpg?1721426554'
    ),
    (
      '7392d397-9836-4df2-944d-c930c9566811',
      'Wildfire Howl',
      '{1}{R}{R}',
      3,
      'Sorcery',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, they draw a card before its other effects.)
Wildfire Howl deals 2 damage to each creature. If the gift was promised, instead Wildfire Howl deals 1 damage to any target and 2 damage to each creature.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '162',
      'https://cards.scryfall.io/normal/front/7/3/7392d397-9836-4df2-944d-c930c9566811.jpg?1721426754',
      'https://cards.scryfall.io/small/front/7/3/7392d397-9836-4df2-944d-c930c9566811.jpg?1721426754'
    ),
    (
      'edeb20aa-b253-49b8-9947-c397a3a4002a',
      'Wishing Well',
      '{3}{U}',
      4,
      'Artifact',
      '{T}: Put a coin counter on this artifact. When you do, you may cast target instant or sorcery card with mana value equal to the number of coin counters on this artifact from your graveyard without paying its mana cost. If that spell would be put into your graveyard, exile it instead. Activate only as a sorcery.',
      ARRAY['U']::text[],
      'rare',
      'blb',
      '81',
      'https://cards.scryfall.io/normal/front/e/d/edeb20aa-b253-49b8-9947-c397a3a4002a.jpg?1721426330',
      'https://cards.scryfall.io/small/front/e/d/edeb20aa-b253-49b8-9947-c397a3a4002a.jpg?1721426330'
    ),
    (
      'b9ac7673-eae8-4c4b-889e-5025213a6151',
      'Ygra, Eater of All',
      '{3}{B}{G}',
      5,
      'Legendary Creature — Elemental Cat',
      'Ward—Sacrifice a Food.
Other creatures are Food artifacts in addition to their other types and have "{2}, {T}, Sacrifice this permanent: You gain 3 life."
Whenever a Food is put into a graveyard from the battlefield, put two +1/+1 counters on Ygra.',
      ARRAY['B','G']::text[],
      'mythic',
      'blb',
      '241',
      'https://cards.scryfall.io/normal/front/b/9/b9ac7673-eae8-4c4b-889e-5025213a6151.jpg?1721427242',
      'https://cards.scryfall.io/small/front/b/9/b9ac7673-eae8-4c4b-889e-5025213a6151.jpg?1721427242'
    ),
    (
      'b7f99fd5-5298-4b27-923d-9d31203c931a',
      'Zoraline, Cosmos Caller',
      '{1}{W}{B}',
      3,
      'Legendary Creature — Bat Cleric',
      'Flying, vigilance
Whenever a Bat you control attacks, you gain 1 life.
Whenever Zoraline enters or attacks, you may pay {W}{B} and 2 life. When you do, return target nonland permanent card with mana value 3 or less from your graveyard to the battlefield with a finality counter on it.',
      ARRAY['B','W']::text[],
      'rare',
      'blb',
      '242',
      'https://cards.scryfall.io/normal/front/b/7/b7f99fd5-5298-4b27-923d-9d31203c931a.jpg?1721427252',
      'https://cards.scryfall.io/small/front/b/7/b7f99fd5-5298-4b27-923d-9d31203c931a.jpg?1721427252'
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