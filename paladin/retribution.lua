-- ProbablyEngine Rotation Packager
ProbablyEngine.rotation.register_custom(70, "akeRetributionPaladin", {
-- Author: AkeRotations

-- Version 1.3 14/10/14 Overhaul for 6.0.2
-- Version 1.2 21/09/14 (MOP)
-- Version: 1.2 Add self heal toggle and update code.
-- Version: 1.1 Add AE rotation.
-- Version: 1.0 Finalised rotation for release.

-- Notes: Santified wrath as dps gain. Raid survivability is untested.
-- Pause: Left Alt
-- Lights Hammer: Left Control

	-- Rotation Utilities
	{ "pause", "modifier.lalt" },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- Self Heals
	{ "Flash of Light", { "player.health < 40", "player.buff(Selfless Healer).count > 2", "toggle.selfheal" } },
	{ "Word of Glory", { "player.health < 25", "player.holypower > 3", "toggle.selfheal" } },
	{ "Lay on Hands", { "player.health < 15", "toggle.selfheal" } },
	{ "Eternal Flame", { "player.buff(Eternal Flame).duration < 3", "toggle.selfheal" } },
	{ "Sacred Shield", { "player.buff(Sacred Shield).duration < 3", "toggle.selfheal" } },

	-- Seals
	{ "Seal of Truth", "player.seal != 1" },
	
	-- Interrupts
	{ "Rebuke", "modifier.interrupt" },
	
 	-- Survivability
	{ "Hand of Freedom", { "toggle.raidprotection", "!player.buff", "player.state.root" }, "player" },
	{ "#5512", { "modifier.cooldowns", "player.health < 30" } }, -- Healthstone (5512)
	{ "Cleanse", { "!modifier.last(Cleanse)", "player.dispellable(Cleanse)" }, "player" }, -- Cleanse Poison or Disease
	
	 -- Raid Protection
	{ "Flash of Light", { "toggle.raidprotection", "lowest.health < 25", "player.buff(Selfless Healer).count > 2" }, "lowest" },		
	{ "Lay on Hands", { "toggle.raidprotection", "lowest.health < 15", "lowest" } },
	{ "Hand of Protection", { "toggle.raidprotection", "lowest.exists", "lowest.alive", "lowest.friend", "lowest.isPlayer", "!lowest.role(tank)", "!lowest.immune.melee", "lowest.health <= 20" }, "lowest" },
	
	--Cooldowns
	{ "Avenging Wrath", "modifier.cooldowns" },   
	{ "Holy Avenger", { "modifier.cooldowns", "player.holypower < 3" } },

 	-- Mouseovers
	{ "Light's Hammer", { "modifier.lcontrol" }, "ground" },
	
	-- AE
	{ "Divine Storm", { "target.spell(Crusader Strike).range", "player.holypower > 4", "modifier.multitarget" } },
	{ "Hammer of Wrath", "modifier.multitarget" },
	{ "Divine Storm", { "target.spell(Crusader Strike).range", "player.buff(Divine Crusader)", "modifier.multitarget" } }, --T16 4Piece
	{ "Hammer of the Righteous", { "target.spell(Crusader Strike).range", "modifier.multitarget" } },
	{ "Judgment", "modifier.multitarget" },
	{ "Exorcism", "modifier.multitarget" },	
	{ "Divine Storm", { "target.spell(Crusader Strike).range", "player.holypower > 2", "modifier.multitarget" } },
	
	-- ST Rotation
	{ "Templar's Verdict", "target.spell(Crusader Strike).range", "player.holypower > 4" },
	{ "Execution Sentence" },
	{ "Divine Storm", { "target.spell(Crusader Strike).range", "player.holypower > 4", "player.buff(Divine Crusader)" } }, --T16 4Piece
	{ "Hammer of Wrath" },
	{ "Crusader Strike", "target.spell(Crusader Strike).range" },
	{ "Judgment" },
	{ "Divine Storm", { "target.spell(Crusader Strike).range", "player.buff(Divine Crusader)" } }, --T16 4Piece
	{ "Exorcism" },	
	{ "Templar's Verdict", { "target.spell(Crusader Strike).range", "player.holypower > 2" } },
	

},{
-- OoC ROTATION

	-- Pause
	{ "pause", "modifier.lcontrol" },
	{ "Seal of Truth", "player.seal != 1" },

	-- Blessings
	{ "Blessing of Might", "!player.buff(Blessing of Might).any" },
	{ "Blessing of Kings", { "!player.buff(Blessing of Kings).any", "!player.buff(Blessing of Might)" } },
		
 },
function()
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	ProbablyEngine.toggle.create('raidheal', 'Interface\\Icons\\spell_holy_sealofprotection', 'Raid Protection', 'Toggles usage of Hand spells and Flash of Light procs on the raid.')
	ProbablyEngine.toggle.create('selfheal', 'Interface\\Icons\\spell_nature_riptide', 'Self heal', 'Toggles usage of self healing such as flash of light and Word of Glory.')
end
)

