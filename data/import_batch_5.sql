INSERT INTO cards (
    id, name, mana_cost, cmc, type_line, oracle_text,
    colors, rarity, set_code, collector_number, image_uri, image_uri_small
  )
  VALUES
    (
      '84352565-558b-4f9b-a411-532147806a78',
      'Season of the Bold',
      '{3}{R}{R}',
      5,
      'Sorcery',
      'Choose up to five {P} worth of modes. You may choose the same mode more than once.
{P} — Create a tapped Treasure token.
{P}{P} — Exile the top two cards of your library. Until the end of your next turn, you may play them.
{P}{P}{P} — Until the end of your next turn, whenever you cast a spell, Season of the Bold deals 2 damage to up to one target creature.',
      ARRAY['R']::text[],
      'mythic',
      'blb',
      '152',
      'https://cards.scryfall.io/normal/front/8/4/84352565-558b-4f9b-a411-532147806a78.jpg?1721426701',
      'https://cards.scryfall.io/small/front/8/4/84352565-558b-4f9b-a411-532147806a78.jpg?1721426701'
    ),
    (
      '33bf9c60-4e58-48a4-8e53-abef7ab3b671',
      'Season of the Burrow',
      '{3}{W}{W}',
      5,
      'Sorcery',
      'Choose up to five {P} worth of modes. You may choose the same mode more than once.
{P} — Create a 1/1 white Rabbit creature token.
{P}{P} — Exile target nonland permanent. Its controller draws a card.
{P}{P}{P} — Return target permanent card with mana value 3 or less from your graveyard to the battlefield with an indestructible counter on it.',
      ARRAY['W']::text[],
      'mythic',
      'blb',
      '29',
      'https://cards.scryfall.io/normal/front/3/3/33bf9c60-4e58-48a4-8e53-abef7ab3b671.jpg?1721425932',
      'https://cards.scryfall.io/small/front/3/3/33bf9c60-4e58-48a4-8e53-abef7ab3b671.jpg?1721425932'
    ),
    (
      'f5713bb4-bdd9-4253-b6b9-e590532ed773',
      'Season of Weaving',
      '{4}{U}{U}',
      6,
      'Sorcery',
      'Choose up to five {P} worth of modes. You may choose the same mode more than once.
{P} — Draw a card.
{P}{P} — Choose an artifact or creature you control. Create a token that''s a copy of it.
{P}{P}{P} — Return each nonland, nontoken permanent to its owner''s hand.',
      ARRAY['U']::text[],
      'mythic',
      'blb',
      '68',
      'https://cards.scryfall.io/normal/front/f/5/f5713bb4-bdd9-4253-b6b9-e590532ed773.jpg?1721426229',
      'https://cards.scryfall.io/small/front/f/5/f5713bb4-bdd9-4253-b6b9-e590532ed773.jpg?1721426229'
    ),
    (
      'd21c3e41-0636-49a3-8c9c-384c5e5c9c3e',
      'Seedglaive Mentor',
      '{1}{R}{W}',
      3,
      'Creature — Mouse Soldier',
      'Vigilance, haste
Valiant — Whenever this creature becomes the target of a spell or ability you control for the first time each turn, put a +1/+1 counter on it.',
      ARRAY['R','W']::text[],
      'uncommon',
      'blb',
      '231',
      'https://cards.scryfall.io/normal/front/d/2/d21c3e41-0636-49a3-8c9c-384c5e5c9c3e.jpg?1721427185',
      'https://cards.scryfall.io/small/front/d/2/d21c3e41-0636-49a3-8c9c-384c5e5c9c3e.jpg?1721427185'
    ),
    (
      'f3684577-51ce-490e-9b59-b19c733be466',
      'Seedpod Squire',
      '{3}{W/U}',
      4,
      'Creature — Bird Scout',
      'Flying
Whenever this creature attacks, target creature you control without flying gets +1/+1 until end of turn.',
      ARRAY['U','W']::text[],
      'common',
      'blb',
      '232',
      'https://cards.scryfall.io/normal/front/f/3/f3684577-51ce-490e-9b59-b19c733be466.jpg?1721427187',
      'https://cards.scryfall.io/small/front/f/3/f3684577-51ce-490e-9b59-b19c733be466.jpg?1721427187'
    ),
    (
      '230b9aef-bd9c-4332-ace4-b5b065bac6d8',
      'Serra Redeemer',
      '{3}{W}{W}',
      5,
      'Creature — Angel Soldier',
      'Flying
Whenever another creature you control with power 2 or less enters, put two +1/+1 counters on that creature.',
      ARRAY['W']::text[],
      'rare',
      'blb',
      '387',
      'https://cards.scryfall.io/normal/front/2/3/230b9aef-bd9c-4332-ace4-b5b065bac6d8.jpg?1721428078',
      'https://cards.scryfall.io/small/front/2/3/230b9aef-bd9c-4332-ace4-b5b065bac6d8.jpg?1721428078'
    ),
    (
      'd5bf8cf0-419a-4dc9-9342-aad55c1af05a',
      'Shoreline Looter',
      '{1}{U}',
      2,
      'Creature — Rat Rogue',
      'This creature can''t be blocked.
Threshold — Whenever this creature deals combat damage to a player, draw a card. Then discard a card unless there are seven or more cards in your graveyard.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '70',
      'https://cards.scryfall.io/normal/front/d/5/d5bf8cf0-419a-4dc9-9342-aad55c1af05a.jpg?1721426251',
      'https://cards.scryfall.io/small/front/d/5/d5bf8cf0-419a-4dc9-9342-aad55c1af05a.jpg?1721426251'
    ),
    (
      '4dc3b49e-3674-494c-bdea-4374cefd10f4',
      'Shore Up',
      '{U}',
      1,
      'Instant',
      'Target creature you control gets +1/+1 and gains hexproof until end of turn. Untap it. (It can''t be the target of spells or abilities your opponents control.)',
      ARRAY['U']::text[],
      'common',
      'blb',
      '69',
      'https://cards.scryfall.io/normal/front/4/d/4dc3b49e-3674-494c-bdea-4374cefd10f4.jpg?1721426233',
      'https://cards.scryfall.io/small/front/4/d/4dc3b49e-3674-494c-bdea-4374cefd10f4.jpg?1721426233'
    ),
    (
      '51d8b72b-fa8f-48d3-bddc-d3ce9b8ba2ea',
      'Short Bow',
      '{2}',
      2,
      'Artifact — Equipment',
      'Equipped creature gets +1/+1 and has vigilance and reach.
Equip {1} ({1}: Attach to target creature you control. Equip only as a sorcery.)',
      ARRAY[]::text[],
      'uncommon',
      'blb',
      '248',
      'https://cards.scryfall.io/normal/front/5/1/51d8b72b-fa8f-48d3-bddc-d3ce9b8ba2ea.jpg?1721427294',
      'https://cards.scryfall.io/small/front/5/1/51d8b72b-fa8f-48d3-bddc-d3ce9b8ba2ea.jpg?1721427294'
    ),
    (
      '306fec2c-d8b7-4f4b-8f58-10e3b9f3158f',
      'Shrike Force',
      '{2}{W}',
      3,
      'Creature — Bird Knight',
      'Flying, double strike, vigilance',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '31',
      'https://cards.scryfall.io/normal/front/3/0/306fec2c-d8b7-4f4b-8f58-10e3b9f3158f.jpg?1721425946',
      'https://cards.scryfall.io/small/front/3/0/306fec2c-d8b7-4f4b-8f58-10e3b9f3158f.jpg?1721425946'
    ),
    (
      '2a15e06c-2608-4e7a-a16c-d35417669d86',
      'Sinister Monolith',
      '{3}{B}',
      4,
      'Artifact',
      'At the beginning of combat on your turn, each opponent loses 1 life and you gain 1 life.
{T}, Pay 2 life, Sacrifice this artifact: Draw two cards. Activate only as a sorcery.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '113',
      'https://cards.scryfall.io/normal/front/2/a/2a15e06c-2608-4e7a-a16c-d35417669d86.jpg?1721426512',
      'https://cards.scryfall.io/small/front/2/a/2a15e06c-2608-4e7a-a16c-d35417669d86.jpg?1721426512'
    ),
    (
      'd6844bad-ffbe-4c6e-b438-08562eccea52',
      'Skyskipper Duo',
      '{4}{U}',
      5,
      'Creature — Bird Frog',
      'Flying
When this creature enters, exile up to one other target creature you control. Return it to the battlefield under its owner''s control at the beginning of the next end step.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '71',
      'https://cards.scryfall.io/normal/front/d/6/d6844bad-ffbe-4c6e-b438-08562eccea52.jpg?1721426259',
      'https://cards.scryfall.io/small/front/d/6/d6844bad-ffbe-4c6e-b438-08562eccea52.jpg?1721426259'
    ),
    (
      'a50da179-751f-47a8-a547-8c4a291ed381',
      'Sonar Strike',
      '{1}{W}',
      2,
      'Instant',
      'Sonar Strike deals 4 damage to target attacking, blocking, or tapped creature. You gain 3 life if you control a Bat.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '32',
      'https://cards.scryfall.io/normal/front/a/5/a50da179-751f-47a8-a547-8c4a291ed381.jpg?1721425953',
      'https://cards.scryfall.io/small/front/a/5/a50da179-751f-47a8-a547-8c4a291ed381.jpg?1721425953'
    ),
    (
      'f6f6620a-1d40-429d-9a0c-aaeb62adaa71',
      'Spellgyre',
      '{2}{U}{U}',
      4,
      'Instant',
      'Choose one —
• Counter target spell.
• Surveil 2, then draw two cards. (To surveil 2, look at the top two cards of your library, then put any number of them into your graveyard and the rest on top of your library in any order.)',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '72',
      'https://cards.scryfall.io/normal/front/f/6/f6f6620a-1d40-429d-9a0c-aaeb62adaa71.jpg?1721426266',
      'https://cards.scryfall.io/small/front/f/6/f6f6620a-1d40-429d-9a0c-aaeb62adaa71.jpg?1721426266'
    ),
    (
      '362ee125-35a0-46cd-a201-e6797d12d33a',
      'Splash Lasher',
      '{3}{U}',
      4,
      'Creature — Frog Wizard',
      'Offspring {1}{U} (You may pay an additional {1}{U} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
When this creature enters, tap up to one target creature and put a stun counter on it. (If a permanent with a stun counter would become untapped, remove one from it instead.)',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '73',
      'https://cards.scryfall.io/normal/front/3/6/362ee125-35a0-46cd-a201-e6797d12d33a.jpg?1721426269',
      'https://cards.scryfall.io/small/front/3/6/362ee125-35a0-46cd-a201-e6797d12d33a.jpg?1721426269'
    ),
    (
      'adbaa356-28ba-487f-930a-a957d9960ab0',
      'Splash Portal',
      '{U}',
      1,
      'Sorcery',
      'Exile target creature you control, then return it to the battlefield under its owner''s control. If that creature is a Bird, Frog, Otter, or Rat, draw a card.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '74',
      'https://cards.scryfall.io/normal/front/a/d/adbaa356-28ba-487f-930a-a957d9960ab0.jpg?1721426280',
      'https://cards.scryfall.io/small/front/a/d/adbaa356-28ba-487f-930a-a957d9960ab0.jpg?1721426280'
    ),
    (
      '0e209237-00f7-4bf0-8287-ccde02ce8e8d',
      'Star Charter',
      '{3}{W}',
      4,
      'Creature — Bat Cleric',
      'Flying
At the beginning of your end step, if you gained or lost life this turn, look at the top four cards of your library. You may reveal a creature card with power 3 or less from among them and put it into your hand. Put the rest on the bottom of your library in a random order.',
      ARRAY['W']::text[],
      'uncommon',
      'blb',
      '33',
      'https://cards.scryfall.io/normal/front/0/e/0e209237-00f7-4bf0-8287-ccde02ce8e8d.jpg?1721425964',
      'https://cards.scryfall.io/small/front/0/e/0e209237-00f7-4bf0-8287-ccde02ce8e8d.jpg?1721425964'
    ),
    (
      '2aea38e6-ec58-4091-b27c-2761bdd12b13',
      'Starfall Invocation',
      '{3}{W}{W}',
      5,
      'Sorcery',
      'Gift a card (You may promise an opponent a gift as you cast this spell. If you do, they draw a card before its other effects.)
Destroy all creatures. If the gift was promised, return a creature card put into your graveyard this way to the battlefield under your control.',
      ARRAY['W']::text[],
      'rare',
      'blb',
      '34',
      'https://cards.scryfall.io/normal/front/2/a/2aea38e6-ec58-4091-b27c-2761bdd12b13.jpg?1721425972',
      'https://cards.scryfall.io/small/front/2/a/2aea38e6-ec58-4091-b27c-2761bdd12b13.jpg?1721425972'
    ),
    (
      'c23d8e96-b972-4c6c-b0c4-b6627621f048',
      'Starforged Sword',
      '{4}',
      4,
      'Artifact — Equipment',
      'Gift a tapped Fish (You may promise an opponent a gift as you cast this spell. If you do, when it enters, they create a tapped 1/1 blue Fish creature token.)
When this Equipment enters, if the gift was promised, attach this Equipment to target creature you control.
Equipped creature gets +3/+3 and loses flying.
Equip {3}',
      ARRAY[]::text[],
      'uncommon',
      'blb',
      '249',
      'https://cards.scryfall.io/normal/front/c/2/c23d8e96-b972-4c6c-b0c4-b6627621f048.jpg?1721427296',
      'https://cards.scryfall.io/small/front/c/2/c23d8e96-b972-4c6c-b0c4-b6627621f048.jpg?1721427296'
    ),
    (
      '777fc599-8de7-44d2-8fdd-9bddf5948a0c',
      'Stargaze',
      '{X}{B}{B}',
      2,
      'Sorcery',
      'Look at twice X cards from the top of your library. Put X cards from among them into your hand and the rest into your graveyard. You lose X life.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '114',
      'https://cards.scryfall.io/normal/front/7/7/777fc599-8de7-44d2-8fdd-9bddf5948a0c.jpg?1721426524',
      'https://cards.scryfall.io/small/front/7/7/777fc599-8de7-44d2-8fdd-9bddf5948a0c.jpg?1721426524'
    ),
    (
      '184c1eca-2991-438f-b5d2-cd2529b9c9b4',
      'Starlit Soothsayer',
      '{2}{B}',
      3,
      'Creature — Bat Cleric',
      'Flying
At the beginning of your end step, if you gained or lost life this turn, surveil 1. (Look at the top card of your library. You may put it into your graveyard.)',
      ARRAY['B']::text[],
      'common',
      'blb',
      '115',
      'https://cards.scryfall.io/normal/front/1/8/184c1eca-2991-438f-b5d2-cd2529b9c9b4.jpg?1721426524',
      'https://cards.scryfall.io/small/front/1/8/184c1eca-2991-438f-b5d2-cd2529b9c9b4.jpg?1721426524'
    ),
    (
      '53a938a7-0154-4350-87cb-00da24ec3824',
      'Starscape Cleric',
      '{1}{B}',
      2,
      'Creature — Bat Cleric',
      'Offspring {2}{B} (You may pay an additional {2}{B} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
Flying
This creature can''t block.
Whenever you gain life, each opponent loses 1 life.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '116',
      'https://cards.scryfall.io/normal/front/5/3/53a938a7-0154-4350-87cb-00da24ec3824.jpg?1721426535',
      'https://cards.scryfall.io/small/front/5/3/53a938a7-0154-4350-87cb-00da24ec3824.jpg?1721426535'
    ),
    (
      '6b2f6dc5-9fe8-49c1-b24c-1d99ce1da619',
      'Starseer Mentor',
      '{3}{W}{B}',
      5,
      'Creature — Bat Warlock',
      'Flying, vigilance
At the beginning of your end step, if you gained or lost life this turn, target opponent loses 3 life unless they sacrifice a nonland permanent of their choice or discard a card.',
      ARRAY['B','W']::text[],
      'uncommon',
      'blb',
      '233',
      'https://cards.scryfall.io/normal/front/6/b/6b2f6dc5-9fe8-49c1-b24c-1d99ce1da619.jpg?1721427196',
      'https://cards.scryfall.io/small/front/6/b/6b2f6dc5-9fe8-49c1-b24c-1d99ce1da619.jpg?1721427196'
    ),
    (
      '03bf1296-e347-4070-8c6f-5c362c2f9364',
      'Steampath Charger',
      '{1}{R}',
      2,
      'Creature — Lizard Warlock',
      'Offspring {2} (You may pay an additional {2} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
When this creature dies, it deals 1 damage to target player.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '153',
      'https://cards.scryfall.io/normal/front/0/3/03bf1296-e347-4070-8c6f-5c362c2f9364.jpg?1721426709',
      'https://cards.scryfall.io/small/front/0/3/03bf1296-e347-4070-8c6f-5c362c2f9364.jpg?1721426709'
    ),
    (
      'b5fa9651-b217-4f93-9c46-9bdb11feedcb',
      'Stickytongue Sentinel',
      '{2}{G}',
      3,
      'Creature — Frog Warrior',
      'Reach
When this creature enters, return up to one other target permanent you control to its owner''s hand.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '193',
      'https://cards.scryfall.io/normal/front/b/5/b5fa9651-b217-4f93-9c46-9bdb11feedcb.jpg?1721426926',
      'https://cards.scryfall.io/small/front/b/5/b5fa9651-b217-4f93-9c46-9bdb11feedcb.jpg?1721426926'
    ),
    (
      '50e95c7b-f0b2-4276-8c5e-4191b7ba35d1',
      'Stocking the Pantry',
      '{G}',
      1,
      'Enchantment',
      'Whenever you put one or more +1/+1 counters on a creature you control, put a supply counter on this enchantment.
{2}, Remove a supply counter from this enchantment: Draw a card.',
      ARRAY['G']::text[],
      'uncommon',
      'blb',
      '194',
      'https://cards.scryfall.io/normal/front/5/0/50e95c7b-f0b2-4276-8c5e-4191b7ba35d1.jpg?1727185660',
      'https://cards.scryfall.io/small/front/5/0/50e95c7b-f0b2-4276-8c5e-4191b7ba35d1.jpg?1727185660'
    ),
    (
      '99754055-6d67-4fde-aff3-41f6af6ea764',
      'Stormcatch Mentor',
      '{U}{R}',
      2,
      'Creature — Otter Wizard',
      'Haste
Prowess (Whenever you cast a noncreature spell, this creature gets +1/+1 until end of turn.)
Instant and sorcery spells you cast cost {1} less to cast.',
      ARRAY['R','U']::text[],
      'uncommon',
      'blb',
      '234',
      'https://cards.scryfall.io/normal/front/9/9/99754055-6d67-4fde-aff3-41f6af6ea764.jpg?1721427197',
      'https://cards.scryfall.io/small/front/9/9/99754055-6d67-4fde-aff3-41f6af6ea764.jpg?1721427197'
    ),
    (
      'a36e682d-b43d-4e08-bf5b-70d7e924dbe5',
      'Stormchaser''s Talent',
      '{U}',
      1,
      'Enchantment — Class',
      '(Gain the next level as a sorcery to add its ability.)
When this Class enters, create a 1/1 blue and red Otter creature token with prowess.
{3}{U}: Level 2
When this Class becomes level 2, return target instant or sorcery card from your graveyard to your hand.
{5}{U}: Level 3
Whenever you cast an instant or sorcery spell, create a 1/1 blue and red Otter creature token with prowess.',
      ARRAY['U']::text[],
      'rare',
      'blb',
      '75',
      'https://cards.scryfall.io/normal/front/a/3/a36e682d-b43d-4e08-bf5b-70d7e924dbe5.jpg?1739650074',
      'https://cards.scryfall.io/small/front/a/3/a36e682d-b43d-4e08-bf5b-70d7e924dbe5.jpg?1739650074'
    ),
    (
      '56f214d3-6b93-40db-a693-55e491c8a283',
      'Stormsplitter',
      '{3}{R}',
      4,
      'Creature — Otter Wizard',
      'Haste
Whenever you cast an instant or sorcery spell, create a token that''s a copy of this creature. Exile that token at the beginning of the next end step.',
      ARRAY['R']::text[],
      'mythic',
      'blb',
      '154',
      'https://cards.scryfall.io/normal/front/5/6/56f214d3-6b93-40db-a693-55e491c8a283.jpg?1721426711',
      'https://cards.scryfall.io/small/front/5/6/56f214d3-6b93-40db-a693-55e491c8a283.jpg?1721426711'
    ),
    (
      'fcacbe71-efb0-49e1-b2d0-3ee65ec6cf8b',
      'Sugar Coat',
      '{2}{U}',
      3,
      'Enchantment — Aura',
      'Flash
Enchant creature or Food
Enchanted permanent is a colorless Food artifact with "{2}, {T}, Sacrifice this artifact: You gain 3 life" and loses all other card types and abilities.',
      ARRAY['U']::text[],
      'uncommon',
      'blb',
      '76',
      'https://cards.scryfall.io/normal/front/f/c/fcacbe71-efb0-49e1-b2d0-3ee65ec6cf8b.jpg?1721426291',
      'https://cards.scryfall.io/small/front/f/c/fcacbe71-efb0-49e1-b2d0-3ee65ec6cf8b.jpg?1721426291'
    ),
    (
      '7740abc5-54e1-478d-966e-0fa64e727995',
      'Sunshower Druid',
      '{G}',
      1,
      'Creature — Frog Druid',
      'When this creature enters, put a +1/+1 counter on target creature and you gain 1 life.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '195',
      'https://cards.scryfall.io/normal/front/7/7/7740abc5-54e1-478d-966e-0fa64e727995.jpg?1721426936',
      'https://cards.scryfall.io/small/front/7/7/7740abc5-54e1-478d-966e-0fa64e727995.jpg?1721426936'
    ),
    (
      '8995ceaf-b7e0-423c-8f3e-25212d522502',
      'Sunspine Lynx',
      '{2}{R}{R}',
      4,
      'Creature — Elemental Cat',
      'Players can''t gain life.
Damage can''t be prevented.
When this creature enters, it deals damage to each player equal to the number of nonbasic lands that player controls.',
      ARRAY['R']::text[],
      'rare',
      'blb',
      '155',
      'https://cards.scryfall.io/normal/front/8/9/8995ceaf-b7e0-423c-8f3e-25212d522502.jpg?1721426719',
      'https://cards.scryfall.io/small/front/8/9/8995ceaf-b7e0-423c-8f3e-25212d522502.jpg?1721426719'
    ),
    (
      '6125ffe3-4e48-4e0f-8390-7462446fc8bf',
      'Swamp',
      '',
      0,
      'Basic Land — Swamp',
      '({T}: Add {B}.)',
      ARRAY[]::text[],
      'common',
      'blb',
      '373',
      'https://cards.scryfall.io/normal/front/6/1/6125ffe3-4e48-4e0f-8390-7462446fc8bf.jpg?1721428002',
      'https://cards.scryfall.io/small/front/6/1/6125ffe3-4e48-4e0f-8390-7462446fc8bf.jpg?1721428002'
    ),
    (
      '89e43510-c444-4b2e-b2a0-528dcc09c899',
      'Swiftwater Cliffs',
      '',
      0,
      'Land',
      'This land enters tapped.
When this land enters, you gain 1 life.
{T}: Add {U} or {R}.',
      ARRAY[]::text[],
      'common',
      'blb',
      '397',
      'https://cards.scryfall.io/normal/front/8/9/89e43510-c444-4b2e-b2a0-528dcc09c899.jpg?1721428123',
      'https://cards.scryfall.io/small/front/8/9/89e43510-c444-4b2e-b2a0-528dcc09c899.jpg?1721428123'
    ),
    (
      'f21b5fc1-7611-44ac-ad8d-1f0c6d4fc9a3',
      'Sword of Vengeance',
      '{3}',
      3,
      'Artifact — Equipment',
      'Equipped creature gets +2/+0 and has first strike, vigilance, trample, and haste.
Equip {3}',
      ARRAY[]::text[],
      'rare',
      'blb',
      '395',
      'https://cards.scryfall.io/normal/front/f/2/f21b5fc1-7611-44ac-ad8d-1f0c6d4fc9a3.jpg?1721428115',
      'https://cards.scryfall.io/small/front/f/2/f21b5fc1-7611-44ac-ad8d-1f0c6d4fc9a3.jpg?1721428115'
    ),
    (
      '7a1c6f00-af4c-4d35-b682-6c0e759df9a5',
      'Take Out the Trash',
      '{1}{R}',
      2,
      'Instant',
      'Take Out the Trash deals 3 damage to target creature or planeswalker. If you control a Raccoon, you may discard a card. If you do, draw a card.',
      ARRAY['R']::text[],
      'common',
      'blb',
      '156',
      'https://cards.scryfall.io/normal/front/7/a/7a1c6f00-af4c-4d35-b682-6c0e759df9a5.jpg?1721426722',
      'https://cards.scryfall.io/small/front/7/a/7a1c6f00-af4c-4d35-b682-6c0e759df9a5.jpg?1721426722'
    ),
    (
      '258ef349-5042-4992-bae9-9f8f54b55db0',
      'Tangle Tumbler',
      '{3}',
      3,
      'Artifact — Vehicle',
      'Vigilance
{3}, {T}: Put a +1/+1 counter on target creature.
Tap two untapped tokens you control: This Vehicle becomes an artifact creature until end of turn.',
      ARRAY[]::text[],
      'uncommon',
      'blb',
      '250',
      'https://cards.scryfall.io/normal/front/2/5/258ef349-5042-4992-bae9-9f8f54b55db0.jpg?1721427304',
      'https://cards.scryfall.io/small/front/2/5/258ef349-5042-4992-bae9-9f8f54b55db0.jpg?1721427304'
    ),
    (
      '30506844-349f-4b68-8cc1-d028c1611cc7',
      'Teapot Slinger',
      '{3}{R}',
      4,
      'Creature — Raccoon Warrior',
      'Menace
Whenever you expend 4, this creature deals 2 damage to each opponent. (You expend 4 as you spend your fourth total mana to cast spells during a turn.)',
      ARRAY['R']::text[],
      'uncommon',
      'blb',
      '157',
      'https://cards.scryfall.io/normal/front/3/0/30506844-349f-4b68-8cc1-d028c1611cc7.jpg?1721431263',
      'https://cards.scryfall.io/small/front/3/0/30506844-349f-4b68-8cc1-d028c1611cc7.jpg?1721431263'
    ),
    (
      '850daae4-f0b7-4604-95e7-ad044ec165c3',
      'Tempest Angler',
      '{1}{U/R}{U/R}',
      3,
      'Creature — Otter Wizard',
      'Whenever you cast a noncreature spell, put a +1/+1 counter on this creature.',
      ARRAY['R','U']::text[],
      'common',
      'blb',
      '235',
      'https://cards.scryfall.io/normal/front/8/5/850daae4-f0b7-4604-95e7-ad044ec165c3.jpg?1721427207',
      'https://cards.scryfall.io/small/front/8/5/850daae4-f0b7-4604-95e7-ad044ec165c3.jpg?1721427207'
    ),
    (
      '6b8bfa91-adb0-4596-8c16-d8bb64fdb26d',
      'Tender Wildguide',
      '{1}{G}',
      2,
      'Creature — Possum Druid',
      'Offspring {2} (You may pay an additional {2} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
{T}: Add one mana of any color.
{T}: Put a +1/+1 counter on this creature.',
      ARRAY['G']::text[],
      'rare',
      'blb',
      '196',
      'https://cards.scryfall.io/normal/front/6/b/6b8bfa91-adb0-4596-8c16-d8bb64fdb26d.jpg?1721426949',
      'https://cards.scryfall.io/small/front/6/b/6b8bfa91-adb0-4596-8c16-d8bb64fdb26d.jpg?1721426949'
    ),
    (
      'dc6c9196-6d28-4cc2-9748-60e9632a502b',
      'The Infamous Cruelclaw',
      '{1}{B}{R}',
      3,
      'Legendary Creature — Weasel Mercenary',
      'Menace
Whenever The Infamous Cruelclaw deals combat damage to a player, exile cards from the top of your library until you exile a nonland card. You may cast that card by discarding a card rather than paying its mana cost.',
      ARRAY['B','R']::text[],
      'mythic',
      'blb',
      '219',
      'https://cards.scryfall.io/normal/front/d/c/dc6c9196-6d28-4cc2-9748-60e9632a502b.jpg?1721427092',
      'https://cards.scryfall.io/small/front/d/c/dc6c9196-6d28-4cc2-9748-60e9632a502b.jpg?1721427092'
    ),
    (
      '52a258be-39e3-4689-b2d0-7c353ce7d574',
      'Thieving Otter',
      '{2}{U}',
      3,
      'Creature — Otter',
      'Whenever this creature deals damage to an opponent, draw a card.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '390',
      'https://cards.scryfall.io/normal/front/5/2/52a258be-39e3-4689-b2d0-7c353ce7d574.jpg?1721428090',
      'https://cards.scryfall.io/small/front/5/2/52a258be-39e3-4689-b2d0-7c353ce7d574.jpg?1721428090'
    ),
    (
      'afa8d83f-8586-4127-8b55-9715e9547488',
      'Thistledown Players',
      '{2}{W}',
      3,
      'Creature — Mouse Bard',
      'Whenever this creature attacks, untap target nonland permanent.',
      ARRAY['W']::text[],
      'common',
      'blb',
      '35',
      'https://cards.scryfall.io/normal/front/a/f/afa8d83f-8586-4127-8b55-9715e9547488.jpg?1721425974',
      'https://cards.scryfall.io/small/front/a/f/afa8d83f-8586-4127-8b55-9715e9547488.jpg?1721425974'
    ),
    (
      '42f66c4a-feaa-4ba6-aa56-955b43329a9e',
      'Thornplate Intimidator',
      '{3}{B}',
      4,
      'Creature — Rat Rogue',
      'Offspring {3} (You may pay an additional {3} as you cast this spell. If you do, when this creature enters, create a 1/1 token copy of it.)
When this creature enters, target opponent loses 3 life unless they sacrifice a nonland permanent of their choice or discard a card.',
      ARRAY['B']::text[],
      'common',
      'blb',
      '117',
      'https://cards.scryfall.io/normal/front/4/2/42f66c4a-feaa-4ba6-aa56-955b43329a9e.jpg?1721426537',
      'https://cards.scryfall.io/small/front/4/2/42f66c4a-feaa-4ba6-aa56-955b43329a9e.jpg?1721426537'
    ),
    (
      '8c2d6b02-a453-40f9-992a-5c5542987cfb',
      'Thornvault Forager',
      '{1}{G}',
      2,
      'Creature — Squirrel Ranger',
      '{T}: Add {G}.
{T}, Forage: Add two mana in any combination of colors. (To forage, exile three cards from your graveyard or sacrifice a Food.)
{3}{G}, {T}: Search your library for a Squirrel card, reveal it, put it into your hand, then shuffle.',
      ARRAY['G']::text[],
      'rare',
      'blb',
      '197',
      'https://cards.scryfall.io/normal/front/8/c/8c2d6b02-a453-40f9-992a-5c5542987cfb.jpg?1721933896',
      'https://cards.scryfall.io/small/front/8/c/8c2d6b02-a453-40f9-992a-5c5542987cfb.jpg?1721933896'
    ),
    (
      '44b0d83b-cc41-4f82-892c-ef6d3293228a',
      'Thought Shucker',
      '{1}{U}',
      2,
      'Creature — Rat Rogue',
      'Threshold — {1}{U}: Put a +1/+1 counter on this creature and draw a card. Activate only if there are seven or more cards in your graveyard and only once.',
      ARRAY['U']::text[],
      'common',
      'blb',
      '77',
      'https://cards.scryfall.io/normal/front/4/4/44b0d83b-cc41-4f82-892c-ef6d3293228a.jpg?1721426302',
      'https://cards.scryfall.io/small/front/4/4/44b0d83b-cc41-4f82-892c-ef6d3293228a.jpg?1721426302'
    ),
    (
      '42e80284-d489-493b-ae92-95b742d07cb3',
      'Thought-Stalker Warlock',
      '{2}{B}',
      3,
      'Creature — Lizard Warlock',
      'Menace (This creature can''t be blocked except by two or more creatures.)
When this creature enters, choose target opponent. If they lost life this turn, they reveal their hand, you choose a nonland card from it, and they discard that card. Otherwise, they discard a card.',
      ARRAY['B']::text[],
      'uncommon',
      'blb',
      '118',
      'https://cards.scryfall.io/normal/front/4/2/42e80284-d489-493b-ae92-95b742d07cb3.jpg?1721426544',
      'https://cards.scryfall.io/small/front/4/2/42e80284-d489-493b-ae92-95b742d07cb3.jpg?1721426544'
    ),
    (
      '56f88a48-cced-4a9d-8c19-e4f105f0d8a2',
      'Three Tree City',
      '',
      0,
      'Legendary Land',
      'As Three Tree City enters, choose a creature type.
{T}: Add {C}.
{2}, {T}: Choose a color. Add an amount of mana of that color equal to the number of creatures you control of the chosen type.',
      ARRAY[]::text[],
      'rare',
      'blb',
      '260',
      'https://cards.scryfall.io/normal/front/5/6/56f88a48-cced-4a9d-8c19-e4f105f0d8a2.jpg?1721427358',
      'https://cards.scryfall.io/small/front/5/6/56f88a48-cced-4a9d-8c19-e4f105f0d8a2.jpg?1721427358'
    ),
    (
      'aaced75b-6e07-457c-8ea2-f74d99710d15',
      'Three Tree Mascot',
      '{2}',
      2,
      'Artifact Creature — Shapeshifter',
      'Changeling (This card is every creature type.)
{1}: Add one mana of any color. Activate only once each turn.',
      ARRAY[]::text[],
      'common',
      'blb',
      '251',
      'https://cards.scryfall.io/normal/front/a/a/aaced75b-6e07-457c-8ea2-f74d99710d15.jpg?1721427313',
      'https://cards.scryfall.io/small/front/a/a/aaced75b-6e07-457c-8ea2-f74d99710d15.jpg?1721427313'
    ),
    (
      'd1ab6e14-26e0-4174-b5c6-bc0f5c26b177',
      'Three Tree Rootweaver',
      '{1}{G}',
      2,
      'Creature — Mole Druid',
      '{T}: Add one mana of any color.',
      ARRAY['G']::text[],
      'common',
      'blb',
      '198',
      'https://cards.scryfall.io/normal/front/d/1/d1ab6e14-26e0-4174-b5c6-bc0f5c26b177.jpg?1721426963',
      'https://cards.scryfall.io/small/front/d/1/d1ab6e14-26e0-4174-b5c6-bc0f5c26b177.jpg?1721426963'
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