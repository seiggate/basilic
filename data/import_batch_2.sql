INSERT INTO cards (
    id, name, mana_cost, cmc, type_line, oracle_text,
    colors, rarity, set_code, collector_number, image_uri, image_uri_small
  )
  VALUES
    (
      'cea2bb34-e328-44fb-918a-72208c9457e4',
      'Daggerfang Duo',
      '{2}{B}',
      3,
      'Creature — Rat Squirrel',
      'Deathtouch
When this creature enters, you may mill two cards. (You may put the top two cards of your library into your graveyard.)',
      ARRAY['B']::text[],
      'common',
      'blb',
      '89',
      'https://cards.scryfall.io/normal/front/c/e/cea2bb34-e328-44fb-918a-72208c9457e4.jpg?1721426379',
      'https://cards.scryfall.io/small/front/c/e/cea2bb34-e328-44fb-918a-72208c9457e4.jpg?1721426379'
    ),
    (
      '19422406-0c1a-497e-bed1-708bc556491a',
      'Daring Waverider',
      '{4}{U}{U}',
      6,
      'Creature — Otter Wizard',
      'When this creature enters, you may cast target instant or sorcery card with mana value 4 or less from your graveyard without paying its mana cost. If that spell would be put into your graveyard, exile it instead.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '44',
      'https://cards.scryfall.io/normal/front/1/9/19422406-0c1a-497e-bed1-708bc556491a.jpg?1721426039',
      'https://cards.scryfall.io/small/front/1/9/19422406-0c1a-497e-bed1-708bc556491a.jpg?1721426039'
    ),
    (
      '1c603751-1e2b-4c8e-a8d2-5c0876e7254f',
      'Darkstar Augur',
      '{2}{B}',
      3,
      'Creature — Bat Warlock',
      'Offspring {B} (You may pay an additional {B} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
Flying
At the beginning of your upkeep, reveal the top card of your library and put that card into your hand. You lose life equal to its mana value.',
      ARRAY['B']::text[],
      'rare',
      'blb',
      '90',
      'https://cards.scryfall.io/normal/front/1/c/1c603751-1e2b-4c8e-a8d2-5c0876e7254f.jpg?1721426387',
      'https://cards.scryfall.io/small/front/1/c/1c603751-1e2b-4c8e-a8d2-5c0876e7254f.jpg?1721426387'
    ),
    (
      '8f72bfa0-efef-48ce-aff8-d5818ed71ba6',
      'Dawn''s Truce',
      '{1}{W}',
      2,
      'Instant',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, they draw a card before its other effects.)
You and permanents you control gain hexproof until end of turn. If the gift was promised, permanents you control also gain indestructible until end of turn.',
      ARRAY['W']::text[],
      'rare',
      'blb',
      '9',
      'https://cards.scryfall.io/normal/front/8/f/8f72bfa0-efef-48ce-aff8-d5818ed71ba6.jpg?1721425804',
      'https://cards.scryfall.io/small/front/8/f/8f72bfa0-efef-48ce-aff8-d5818ed71ba6.jpg?1721425804'
    ),
    (
      '8739f1ac-2e57-4b52-a7ff-cc8df5936aad',
      'Dazzling Denial',
      '{1}{U}',
      2,
      'Instant',
      'Counter target spell unless its controller pays {2}. If you control a Bird, counter that spell unless its controller pays {4} instead.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '45',
      'https://cards.scryfall.io/normal/front/8/7/8739f1ac-2e57-4b52-a7ff-cc8df5936aad.jpg?1721426047',
      'https://cards.scryfall.io/small/front/8/7/8739f1ac-2e57-4b52-a7ff-cc8df5936aad.jpg?1721426047'
    ),
    (
      '666aefc2-44e0-4c27-88d5-7906f245a71f',
      'Dewdrop Cure',
      '{2}{W}',
      3,
      'Sorcery',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, they draw a card before its other effects.)
Return up to two target creature cards each with mana value 2 or less from your graveyard to the battlefield. If the gift was promised, instead return up to three target creature cards each with mana value 2 or less from your graveyard to the battlefield.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '10',
      'https://cards.scryfall.io/normal/front/6/6/666aefc2-44e0-4c27-88d5-7906f245a71f.jpg?1721425815',
      'https://cards.scryfall.io/small/front/6/6/666aefc2-44e0-4c27-88d5-7906f245a71f.jpg?1721425815'
    ),
    (
      'f1931f22-974c-43ad-911e-684bf3f9995d',
      'Dire Downdraft',
      '{3}{U}',
      4,
      'Instant',
      'This spell costs {1} less to cast if it targets an attacking or tapped creature.
Target creature''s owner puts it on their choice of the top or bottom of their library.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '46',
      'https://cards.scryfall.io/normal/front/f/1/f1931f22-974c-43ad-911e-684bf3f9995d.jpg?1721426060',
      'https://cards.scryfall.io/small/front/f/1/f1931f22-974c-43ad-911e-684bf3f9995d.jpg?1721426060'
    ),
    (
      'fada29c0-5293-40a4-b36d-d073ee99e650',
      'Diresight',
      '{2}{B}',
      3,
      'Sorcery',
      'Surveil 2, then draw two cards. You lose 2 life. (To surveil 2, look at the top two cards of your library, then put any number of them into your graveyard and the rest on top of your library in any order.)',
      ARRAY['B']::text[],
      'common',
      'blb',
      '91',
      'https://cards.scryfall.io/normal/front/f/a/fada29c0-5293-40a4-b36d-d073ee99e650.jpg?1721426397',
      'https://cards.scryfall.io/small/front/f/a/fada29c0-5293-40a4-b36d-d073ee99e650.jpg?1721426397'
    ),
    (
      '6402133e-eed1-4a46-9667-8b7a310362c1',
      'Dour Port-Mage',
      '{1}{U}',
      2,
      'Creature — Frog Wizard',
      'Whenever one or more other creatures you control leave the battlefield without dying, draw a card.
{1}{U}, {T}: Return another target creature you control to its owner''s hand.',
      ARRAY['U']::text[],
      'rare',
      'blb',
      '47',
      'https://cards.scryfall.io/normal/front/6/4/6402133e-eed1-4a46-9667-8b7a310362c1.jpg?1721426066',
      'https://cards.scryfall.io/small/front/6/4/6402133e-eed1-4a46-9667-8b7a310362c1.jpg?1721426066'
    ),
    (
      '55cfd628-933a-4d3d-b2e5-70bc86960d1c',
      'Downwind Ambusher',
      '{3}{B}',
      4,
      'Creature — Skunk Assassin',
      'Flash
When this creature enters, choose one —
• Target creature an opponent controls gets -1/-1 until end of turn.
• Destroy target creature an opponent controls that was dealt damage this turn.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '92',
      'https://cards.scryfall.io/normal/front/5/5/55cfd628-933a-4d3d-b2e5-70bc86960d1c.jpg?1721426398',
      'https://cards.scryfall.io/small/front/5/5/55cfd628-933a-4d3d-b2e5-70bc86960d1c.jpg?1721426398'
    ),
    (
      '8659789c-6a2c-439f-a348-b9b1b06c55b8',
      'Dragonhawk, Fate''s Tempest',
      '{3}{R}{R}',
      5,
      'Legendary Creature — Bird Dragon',
      'Flying
Whenever Dragonhawk enters or attacks, exile the top X cards of your library, where X is the number of creatures you control with power 4 or greater. You may play those cards until your next end step. At the beginning of your next end step, Dragonhawk deals 2 damage to each opponent for each of those cards that are still exiled.',
      ARRAY['R']::text[],
      'mythic',
      'blb',
      '132',
      'https://cards.scryfall.io/normal/front/8/6/8659789c-6a2c-439f-a348-b9b1b06c55b8.jpg?1721426605',
      'https://cards.scryfall.io/small/front/8/6/8659789c-6a2c-439f-a348-b9b1b06c55b8.jpg?1721426605'
    ),
    (
      '26bd6b0d-8606-4a37-8be3-a852f1a8e99c',
      'Dreamdew Entrancer',
      '{2}{G}{U}',
      4,
      'Creature — Frog Wizard',
      'Reach
When this creature enters, tap up to one target creature and put three stun counters on it. If you control that creature, draw two cards.',
      ARRAY['G','U']::text[],
      'rare',
      'blb',
      '211',
      'https://cards.scryfall.io/normal/front/2/6/26bd6b0d-8606-4a37-8be3-a852f1a8e99c.jpg?1721427040',
      'https://cards.scryfall.io/small/front/2/6/26bd6b0d-8606-4a37-8be3-a852f1a8e99c.jpg?1721427040'
    ),
    (
      'd7ab2de3-3aea-461a-a74f-fb742cf8a198',
      'Driftgloom Coyote',
      '{3}{W}{W}',
      5,
      'Creature — Elemental Coyote',
      'When this creature enters, exile target creature an opponent controls until this creature leaves the battlefield. If that creature had power 2 or less, put a +1/+1 counter on this creature.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '11',
      'https://cards.scryfall.io/normal/front/d/7/d7ab2de3-3aea-461a-a74f-fb742cf8a198.jpg?1721425819',
      'https://cards.scryfall.io/small/front/d/7/d7ab2de3-3aea-461a-a74f-fb742cf8a198.jpg?1721425819'
    ),
    (
      '6b485cf7-bad0-4824-9ba7-cb112ce4769f',
      'Druid of the Spade',
      '{2}{G}',
      3,
      'Creature — Rabbit Druid',
      'As long as you control a token, this creature gets +2/+0 and has trample.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '170',
      'https://cards.scryfall.io/normal/front/6/b/6b485cf7-bad0-4824-9ba7-cb112ce4769f.jpg?1721426796',
      'https://cards.scryfall.io/small/front/6/b/6b485cf7-bad0-4824-9ba7-cb112ce4769f.jpg?1721426796'
    ),
    (
      '5030e6ac-211d-4145-8c87-998a8351a467',
      'Early Winter',
      '{4}{B}',
      5,
      'Instant',
      'Choose one —
• Exile target creature.
• Target opponent exiles an enchantment they control.',
      ARRAY['B']::text[],
      'common',
      'blb',
      '93',
      'https://cards.scryfall.io/normal/front/5/0/5030e6ac-211d-4145-8c87-998a8351a467.jpg?1721426407',
      'https://cards.scryfall.io/small/front/5/0/5030e6ac-211d-4145-8c87-998a8351a467.jpg?1721426407'
    ),
    (
      'e6d45abe-4962-47d9-a54e-7e623ea8647c',
      'Eddymurk Crab',
      '{5}{U}{U}',
      7,
      'Creature — Elemental Crab',
      'Flash
This spell costs {1} less to cast for each instant and sorcery card in your graveyard.
This creature enters tapped if it''s not your turn.
When this creature enters, tap up to two target creatures.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '48',
      'https://cards.scryfall.io/normal/front/e/6/e6d45abe-4962-47d9-a54e-7e623ea8647c.jpg?1721426076',
      'https://cards.scryfall.io/small/front/e/6/e6d45abe-4962-47d9-a54e-7e623ea8647c.jpg?1721426076'
    ),
    (
      '1f2bf6ba-cd1a-4382-9572-6dfbcf6ed0c6',
      'Eluge, the Shoreless Sea',
      '{1}{U}{U}{U}',
      4,
      'Legendary Creature — Elemental Fish',
      'Eluge''s power and toughness are each equal to the number of Islands you control.
Whenever Eluge enters or attacks, put a flood counter on target land. It''s an Island in addition to its other types for as long as it has a flood counter on it.
The first instant or sorcery spell you cast each turn costs {U} (or {1}) less to cast for each land you control with a flood counter on it.',
      ARRAY['U']::text[],
      'mythic',
      'blb',
      '49',
      'https://cards.scryfall.io/normal/front/1/f/1f2bf6ba-cd1a-4382-9572-6dfbcf6ed0c6.jpg?1721426077',
      'https://cards.scryfall.io/small/front/1/f/1f2bf6ba-cd1a-4382-9572-6dfbcf6ed0c6.jpg?1721426077'
    ),
    (
      '0035082e-bb86-4f95-be48-ffc87fe5286d',
      'Emberheart Challenger',
      '{1}{R}',
      2,
      'Creature — Mouse Warrior',
      'Haste
Prowess (Whenever you cast a noncreature spell, this creature gets +1/+1 until end of turn.)
Valiant — Whenever this creature becomes the target of a spell or ability you control for the first time each turn, exile the top card of your library. Until end of turn, you may play that card.',
      ARRAY['R']::text[],
      'rare',
      'blb',
      '133',
      'https://cards.scryfall.io/normal/front/0/0/0035082e-bb86-4f95-be48-ffc87fe5286d.jpg?1721426609',
      'https://cards.scryfall.io/small/front/0/0/0035082e-bb86-4f95-be48-ffc87fe5286d.jpg?1721426609'
    ),
    (
      '5aaf7e4c-4d5d-4acc-a834-e6c4a7629408',
      'Essence Channeler',
      '{1}{W}',
      2,
      'Creature — Bat Cleric',
      'As long as you''ve lost life this turn, this creature has flying and vigilance.
Whenever you gain life, put a +1/+1 counter on this creature.
When this creature dies, put its counters on target creature you control.',
      ARRAY['W']::text[],
      'rare',
      'blb',
      '12',
      'https://cards.scryfall.io/normal/front/5/a/5aaf7e4c-4d5d-4acc-a834-e6c4a7629408.jpg?1724003311',
      'https://cards.scryfall.io/small/front/5/a/5aaf7e4c-4d5d-4acc-a834-e6c4a7629408.jpg?1724003311'
    ),
    (
      '8809830f-d8e1-4603-9652-0ad8b00234e9',
      'Fabled Passage',
      '',
      0,
      'Land',
      '{T}, Sacrifice this land: Search your library for a basic land card, put it onto the battlefield tapped, then shuffle. Then if you control four or more lands, untap that land.',
      ARRAY[]::text[],
      'rare',
      'blb',
      '252',
      'https://cards.scryfall.io/normal/front/8/8/8809830f-d8e1-4603-9652-0ad8b00234e9.jpg?1721427315',
      'https://cards.scryfall.io/small/front/8/8/8809830f-d8e1-4603-9652-0ad8b00234e9.jpg?1721427315'
    ),
    (
      '9fb41503-8632-4bf1-9bfe-6d9b9993c337',
      'Feather of Flight',
      '{1}{W}',
      2,
      'Enchantment — Aura',
      'Flash
Enchant creature
When this Aura enters, draw a card.
Enchanted creature gets +1/+0 and has flying.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '13',
      'https://cards.scryfall.io/normal/front/9/f/9fb41503-8632-4bf1-9bfe-6d9b9993c337.jpg?1721425833',
      'https://cards.scryfall.io/small/front/9/f/9fb41503-8632-4bf1-9bfe-6d9b9993c337.jpg?1721425833'
    ),
    (
      '80b3e815-0e2e-4325-b1d5-5531b7b92da6',
      'Fecund Greenshell',
      '{3}{G}{G}',
      5,
      'Creature — Elemental Turtle',
      'Reach
As long as you control ten or more lands, creatures you control get +2/+2.
Whenever this creature or another creature you control with toughness greater than its power enters, look at the top card of your library. If it''s a land card, you may put it onto the battlefield tapped. Otherwise, put it into your hand.',
      ARRAY['G']::text[],
      'rare',
      'blb',
      '171',
      'https://cards.scryfall.io/normal/front/8/0/80b3e815-0e2e-4325-b1d5-5531b7b92da6.jpg?1721426804',
      'https://cards.scryfall.io/small/front/8/0/80b3e815-0e2e-4325-b1d5-5531b7b92da6.jpg?1721426804'
    ),
    (
      '7e017ff8-2936-4a1b-bece-00004cfbad06',
      'Feed the Cycle',
      '{1}{B}',
      2,
      'Instant',
      'As an additional cost to cast this spell, forage or pay {B}. (To forage, exile three cards from your graveyard or sacrifice a Food.)
Destroy target creature or planeswalker.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '94',
      'https://cards.scryfall.io/normal/front/7/e/7e017ff8-2936-4a1b-bece-00004cfbad06.jpg?1721426413',
      'https://cards.scryfall.io/small/front/7/e/7e017ff8-2936-4a1b-bece-00004cfbad06.jpg?1721426413'
    ),
    (
      'c96ac326-de44-470b-a592-a4c2a052c091',
      'Fell',
      '{1}{B}',
      2,
      'Sorcery',
      'Destroy target creature.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '95',
      'https://cards.scryfall.io/normal/front/c/9/c96ac326-de44-470b-a592-a4c2a052c091.jpg?1721426418',
      'https://cards.scryfall.io/small/front/c/9/c96ac326-de44-470b-a592-a4c2a052c091.jpg?1721426418'
    ),
    (
      '4433ee12-2013-4fdc-979f-ae065f63a527',
      'Festival of Embers',
      '{4}{R}',
      5,
      'Enchantment',
      'During your turn, you may cast instant and sorcery spells from your graveyard by paying 1 life in addition to their other costs.
If a card or token would be put into your graveyard from anywhere, exile it instead.
{1}{R}: Sacrifice this enchantment.',
      ARRAY['R']::text[],
      'rare',
      'blb',
      '134',
      'https://cards.scryfall.io/normal/front/4/4/4433ee12-2013-4fdc-979f-ae065f63a527.jpg?1721426613',
      'https://cards.scryfall.io/small/front/4/4/4433ee12-2013-4fdc-979f-ae065f63a527.jpg?1721426613'
    ),
    (
      '1c671eab-d1ef-4d79-94eb-8b85f0d18699',
      'Finch Formation',
      '{2}{U}',
      3,
      'Creature — Bird Scout',
      'Offspring {3} (You may pay an additional {3} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
Flying
When this creature enters, target creature you control gains flying until end of turn.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '50',
      'https://cards.scryfall.io/normal/front/1/c/1c671eab-d1ef-4d79-94eb-8b85f0d18699.jpg?1721426087',
      'https://cards.scryfall.io/small/front/1/c/1c671eab-d1ef-4d79-94eb-8b85f0d18699.jpg?1721426087'
    ),
    (
      '0dee197d-c313-4364-b52c-f83d5f579bc3',
      'Finneas, Ace Archer',
      '{G}{W}',
      2,
      'Legendary Creature — Rabbit Archer',
      'Vigilance, reach
Whenever Finneas attacks, put a +1/+1 counter on each other creature you control that''s a token or a Rabbit. Then if creatures you control have total power 10 or greater, draw a card.',
      ARRAY['G','W']::text[],
      'rare',
      'blb',
      '212',
      'https://cards.scryfall.io/normal/front/0/d/0dee197d-c313-4364-b52c-f83d5f579bc3.jpg?1721427047',
      'https://cards.scryfall.io/small/front/0/d/0dee197d-c313-4364-b52c-f83d5f579bc3.jpg?1721427047'
    ),
    (
      'b78fbaa3-c580-4290-9c28-b74169aab2fc',
      'Fireglass Mentor',
      '{B}{R}',
      2,
      'Creature — Lizard Warlock',
      'At the beginning of your second main phase, if an opponent lost life this turn, exile the top two cards of your library. Choose one of them. Until end of turn, you may play that card.',
      ARRAY['B','R']::text[],
      'uncommon',
      'blb',
      '213',
      'https://cards.scryfall.io/normal/front/b/7/b78fbaa3-c580-4290-9c28-b74169aab2fc.jpg?1721427057',
      'https://cards.scryfall.io/small/front/b/7/b78fbaa3-c580-4290-9c28-b74169aab2fc.jpg?1721427057'
    ),
    (
      'fb8e7c97-8393-41b8-bb0b-3983dcc5e7f4',
      'Flamecache Gecko',
      '{1}{R}',
      2,
      'Creature — Lizard Warlock',
      'When this creature enters, if an opponent lost life this turn, add {B}{R}.
{1}{R}, Discard a card: Draw a card.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '135',
      'https://cards.scryfall.io/normal/front/f/b/fb8e7c97-8393-41b8-bb0b-3983dcc5e7f4.jpg?1721426619',
      'https://cards.scryfall.io/small/front/f/b/fb8e7c97-8393-41b8-bb0b-3983dcc5e7f4.jpg?1721426619'
    ),
    (
      'c6440439-7178-4a97-9e18-7fdef4b02678',
      'Flame Lash',
      '{3}{R}',
      4,
      'Instant',
      'Flame Lash deals 4 damage to any target.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '391',
      'https://cards.scryfall.io/normal/front/c/6/c6440439-7178-4a97-9e18-7fdef4b02678.jpg?1721428094',
      'https://cards.scryfall.io/small/front/c/6/c6440439-7178-4a97-9e18-7fdef4b02678.jpg?1721428094'
    ),
    (
      '97ff118f-9c3c-43a2-8085-980c7fe7d227',
      'Flowerfoot Swordmaster',
      '{W}',
      1,
      'Creature — Mouse Soldier',
      'Offspring {2} (You may pay an additional {2} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
Valiant — Whenever this creature becomes the target of a spell or ability you control for the first time each turn, Mice you control get +1/+0 until end of turn.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '14',
      'https://cards.scryfall.io/normal/front/9/7/97ff118f-9c3c-43a2-8085-980c7fe7d227.jpg?1721425843',
      'https://cards.scryfall.io/small/front/9/7/97ff118f-9c3c-43a2-8085-980c7fe7d227.jpg?1721425843'
    ),
    (
      '43b3be4a-973d-4aeb-a94e-37e2710ac178',
      'Forest',
      '',
      0,
      'Basic Land — Forest',
      '({T}: Add {G}.)',
      ARRAY[]::text[],
      'common',
      'blb',
      '377',
      'https://cards.scryfall.io/normal/front/4/3/43b3be4a-973d-4aeb-a94e-37e2710ac178.jpg?1721428022',
      'https://cards.scryfall.io/small/front/4/3/43b3be4a-973d-4aeb-a94e-37e2710ac178.jpg?1721428022'
    ),
    (
      '3ec72a27-b622-47d7-bdf3-970ccaef0d2a',
      'For the Common Good',
      '{X}{X}{G}',
      1,
      'Sorcery',
      'Create X tokens that are copies of target token you control. Then tokens you control gain indestructible until your next turn. You gain 1 life for each token you control.',
      ARRAY['G']::text[],
      'rare',
      'blb',
      '172',
      'https://cards.scryfall.io/normal/front/3/e/3ec72a27-b622-47d7-bdf3-970ccaef0d2a.jpg?1721426807',
      'https://cards.scryfall.io/small/front/3/e/3ec72a27-b622-47d7-bdf3-970ccaef0d2a.jpg?1721426807'
    ),
    (
      '658cfcb7-81b7-48c6-9dd2-1663d06108cf',
      'Fountainport',
      '',
      0,
      'Land',
      '{T}: Add {C}.
{2}, {T}, Sacrifice a token: Draw a card.
{3}, {T}, Pay 1 life: Create a 1/1 blue Fish creature token.
{4}, {T}: Create a Treasure token.',
      ARRAY[]::text[],
      'rare',
      'blb',
      '253',
      'https://cards.scryfall.io/normal/front/6/5/658cfcb7-81b7-48c6-9dd2-1663d06108cf.jpg?1721427323',
      'https://cards.scryfall.io/small/front/6/5/658cfcb7-81b7-48c6-9dd2-1663d06108cf.jpg?1721427323'
    ),
    (
      'a5c94bc0-a49d-451b-8e8d-64d46b8b8603',
      'Fountainport Bell',
      '{1}',
      1,
      'Artifact',
      'When this artifact enters, you may search your library for a basic land card, reveal it, then shuffle and put that card on top.
{1}, Sacrifice this artifact: Draw a card.',
      ARRAY[]::text[],
      'common',
      'blb',
      '245',
      'https://cards.scryfall.io/normal/front/a/5/a5c94bc0-a49d-451b-8e8d-64d46b8b8603.jpg?1721427270',
      'https://cards.scryfall.io/small/front/a/5/a5c94bc0-a49d-451b-8e8d-64d46b8b8603.jpg?1721427270'
    ),
    (
      '674bbd6d-e329-42cf-963d-88d1ce8fe51e',
      'Frilled Sparkshooter',
      '{3}{R}',
      4,
      'Creature — Lizard Archer',
      'Menace, reach
This creature enters with a +1/+1 counter on it if an opponent lost life this turn.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '136',
      'https://cards.scryfall.io/normal/front/6/7/674bbd6d-e329-42cf-963d-88d1ce8fe51e.jpg?1721426623',
      'https://cards.scryfall.io/small/front/6/7/674bbd6d-e329-42cf-963d-88d1ce8fe51e.jpg?1721426623'
    ),
    (
      '58706bd8-558a-43b9-9f1e-c1ff0044203b',
      'Galewind Moose',
      '{4}{G}{G}',
      6,
      'Creature — Elemental Elk',
      'Flash
Vigilance, reach, trample',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '173',
      'https://cards.scryfall.io/normal/front/5/8/58706bd8-558a-43b9-9f1e-c1ff0044203b.jpg?1721426814',
      'https://cards.scryfall.io/small/front/5/8/58706bd8-558a-43b9-9f1e-c1ff0044203b.jpg?1721426814'
    ),
    (
      '131ea976-289e-4f32-896d-27bbfd423ba9',
      'Gev, Scaled Scorch',
      '{B}{R}',
      2,
      'Legendary Creature — Lizard Mercenary',
      'Ward—Pay 2 life.
Other creatures you control enter with an additional +1/+1 counter on them for each opponent who lost life this turn.
Whenever you cast a Lizard spell, Gev deals 1 damage to target opponent.',
      ARRAY['B','R']::text[],
      'rare',
      'blb',
      '214',
      'https://cards.scryfall.io/normal/front/1/3/131ea976-289e-4f32-896d-27bbfd423ba9.jpg?1721427059',
      'https://cards.scryfall.io/small/front/1/3/131ea976-289e-4f32-896d-27bbfd423ba9.jpg?1721427059'
    ),
    (
      'e70722d6-b4d5-45c2-9488-9a5eb0bdb9bd',
      'Giant Growth',
      '{G}',
      1,
      'Instant',
      'Target creature gets +3/+3 until end of turn.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '393',
      'https://cards.scryfall.io/normal/front/e/7/e70722d6-b4d5-45c2-9488-9a5eb0bdb9bd.jpg?1721428103',
      'https://cards.scryfall.io/small/front/e/7/e70722d6-b4d5-45c2-9488-9a5eb0bdb9bd.jpg?1721428103'
    ),
    (
      'ffc70b2d-5a3a-49ea-97db-175a62248302',
      'Glarb, Calamity''s Augur',
      '{B}{G}{U}',
      3,
      'Legendary Creature — Frog Wizard Noble',
      'Deathtouch
You may look at the top card of your library any time.
You may play lands and cast spells with mana value 4 or greater from the top of your library.
{T}: Surveil 2.',
      ARRAY['B','G','U']::text[],
      'mythic',
      'blb',
      '215',
      'https://cards.scryfall.io/normal/front/f/f/ffc70b2d-5a3a-49ea-97db-175a62248302.jpg?1721427068',
      'https://cards.scryfall.io/small/front/f/f/ffc70b2d-5a3a-49ea-97db-175a62248302.jpg?1721427068'
    ),
    (
      '4831e7ae-54e3-4bd9-b5af-52dc29f81715',
      'Glidedive Duo',
      '{4}{B}',
      5,
      'Creature — Bat Lizard',
      'Flying
When this creature enters, each opponent loses 2 life and you gain 2 life.',
      ARRAY['B']::text[],
      'common',
      'blb',
      '96',
      'https://cards.scryfall.io/normal/front/4/8/4831e7ae-54e3-4bd9-b5af-52dc29f81715.jpg?1721426425',
      'https://cards.scryfall.io/small/front/4/8/4831e7ae-54e3-4bd9-b5af-52dc29f81715.jpg?1721426425'
    ),
    (
      'b299889a-03d6-4659-b0e1-f0830842e40f',
      'Gossip''s Talent',
      '{1}{U}',
      2,
      'Enchantment — Class',
      '(Gain the next level as a sorcery to add its ability.)
Whenever a creature you control enters, surveil 1.
{1}{U}: Level 2
Whenever you attack, target attacking creature with power 3 or less can''t be blocked this turn.
{3}{U}: Level 3
Whenever a creature you control deals combat damage to a player, you may exile it, then return it to the battlefield under its owner''s control.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '51',
      'https://cards.scryfall.io/normal/front/b/2/b299889a-03d6-4659-b0e1-f0830842e40f.jpg?1721426095',
      'https://cards.scryfall.io/small/front/b/2/b299889a-03d6-4659-b0e1-f0830842e40f.jpg?1721426095'
    ),
    (
      'b56beeb6-88ca-475e-8654-1d4e8b4aa3c0',
      'Harnesser of Storms',
      '{2}{R}',
      3,
      'Creature — Otter Wizard',
      'Whenever you cast a noncreature or Otter spell, you may exile the top card of your library. Until end of turn, you may play that card. This ability triggers only once each turn.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '137',
      'https://cards.scryfall.io/normal/front/b/5/b56beeb6-88ca-475e-8654-1d4e8b4aa3c0.jpg?1721426630',
      'https://cards.scryfall.io/small/front/b/5/b56beeb6-88ca-475e-8654-1d4e8b4aa3c0.jpg?1721426630'
    ),
    (
      '41762689-0c13-4d45-9d81-ba2afad980f8',
      'Harvestrite Host',
      '{2}{W}',
      3,
      'Creature — Rabbit Citizen',
      'Whenever this creature or another Rabbit you control enters, target creature you control gets +1/+0 until end of turn. Then draw a card if this is the second time this ability has resolved this turn.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '15',
      'https://cards.scryfall.io/normal/front/4/1/41762689-0c13-4d45-9d81-ba2afad980f8.jpg?1721425845',
      'https://cards.scryfall.io/small/front/4/1/41762689-0c13-4d45-9d81-ba2afad980f8.jpg?1721425845'
    ),
    (
      'e2882982-b3a3-4762-a550-6b82db1038e8',
      'Hazardroot Herbalist',
      '{2}{G}',
      3,
      'Creature — Rabbit Druid',
      'Whenever you attack, target creature you control gets +1/+0 until end of turn. If that creature is a token, it also gains deathtouch until end of turn.',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '174',
      'https://cards.scryfall.io/normal/front/e/2/e2882982-b3a3-4762-a550-6b82db1038e8.jpg?1721426818',
      'https://cards.scryfall.io/small/front/e/2/e2882982-b3a3-4762-a550-6b82db1038e8.jpg?1721426818'
    ),
    (
      '239363df-4de8-4b64-80fc-a1f4b5c36027',
      'Hazel''s Nocturne',
      '{3}{B}',
      4,
      'Instant',
      'Return up to two target creature cards from your graveyard to your hand. Each opponent loses 2 life and you gain 2 life.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '97',
      'https://cards.scryfall.io/normal/front/2/3/239363df-4de8-4b64-80fc-a1f4b5c36027.jpg?1721426431',
      'https://cards.scryfall.io/small/front/2/3/239363df-4de8-4b64-80fc-a1f4b5c36027.jpg?1721426431'
    ),
    (
      '2fc20157-edd3-484d-8864-925c071c0551',
      'Head of the Homestead',
      '{3}{G/W}{G/W}',
      5,
      'Creature — Rabbit Citizen',
      'When this creature enters, create two 1/1 white Rabbit creature tokens.',
      ARRAY['G','W']::text[],
      'common',
      'blb',
      '216',
      'https://cards.scryfall.io/normal/front/2/f/2fc20157-edd3-484d-8864-925c071c0551.jpg?1721427071',
      'https://cards.scryfall.io/small/front/2/f/2fc20157-edd3-484d-8864-925c071c0551.jpg?1721427071'
    ),
    (
      '3b5349db-0e0a-4b15-886e-0db403ef49cb',
      'Heaped Harvest',
      '{2}{G}',
      3,
      'Artifact — Food',
      'When this artifact enters and when you sacrifice it, you may search your library for a basic land card, put it onto the battlefield tapped, then shuffle.
{2}, {T}, Sacrifice this artifact: You gain 3 life.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '175',
      'https://cards.scryfall.io/normal/front/3/b/3b5349db-0e0a-4b15-886e-0db403ef49cb.jpg?1721426825',
      'https://cards.scryfall.io/small/front/3/b/3b5349db-0e0a-4b15-886e-0db403ef49cb.jpg?1721426825'
    ),
    (
      '48ace959-66b2-40c8-9bff-fd7ed9c99a82',
      'Heartfire Hero',
      '{R}',
      1,
      'Creature — Mouse Soldier',
      'Valiant — Whenever this creature becomes the target of a spell or ability you control for the first time each turn, put a +1/+1 counter on it.
When this creature dies, it deals damage equal to its power to each opponent.',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '138',
      'https://cards.scryfall.io/normal/front/4/8/48ace959-66b2-40c8-9bff-fd7ed9c99a82.jpg?1762883283',
      'https://cards.scryfall.io/small/front/4/8/48ace959-66b2-40c8-9bff-fd7ed9c99a82.jpg?1762883283'
    ),
    (
      'bef1cf5c-9738-4062-8cb1-87a372d36687',
      'Hearthborn Battler',
      '{2}{R}',
      3,
      'Creature — Lizard Warlock',
      'Haste
Whenever a player casts their second spell each turn, this creature deals 2 damage to target opponent.',
      ARRAY['R']::text[],
      'rare',
      'blb',
      '139',
      'https://cards.scryfall.io/normal/front/b/e/bef1cf5c-9738-4062-8cb1-87a372d36687.jpg?1721426641',
      'https://cards.scryfall.io/small/front/b/e/bef1cf5c-9738-4062-8cb1-87a372d36687.jpg?1721426641'
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