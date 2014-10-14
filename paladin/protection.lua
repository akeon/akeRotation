 -- ProbablyEngine Rotation Packager
PossiblyEngine.rotation.register_custom(66, "akeProtectionPaladin", {
-- Author: AkeRotations
-- Version: 1.3 14/10/14 Overhaul for 6.0.2. - Remove 
-- Version: 1.0 Added AE. Release
-- Version: 0.9 Beta testing TBC
-- Version: 0.2 Add self heal options.
-- Version: 0.1 Initial port

-- Notes: --Move Holy Wrath above Avengers shield if you took the Sanctified Wrath talent.
-- Pause: Left Alt
-- Lights Hammer: Left Control

-- COMBAT
	
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
	{ "#5512", { "player.health < 30" } }, -- Healthstone
	
	-- OFF GCD
	{ "Shield of the Righteous", { "target.spell(Crusader Strike).range", "player.holypower > 4" } },
	{ "Shield of the Righteous", { "target.spell(Crusader Strike).range", "player.buff(Divine Purpose)" } },
  
	-- Seals
	{ "Seal of Insight", "player.seal != 3" },

	-- Interrupts
	{ "Avenger's Shield", "modifier.interrupts" }, 
	{ "Rebuke", "modifier.interrupt" },
	
	--Cooldowns
	{ "Holy Avenger", { "modifier.cooldowns", "player.holypower < 3" } },
		
 	-- Survivability
	{ "Hand of Freedom", { "toggle.raidheal", "!player.buff", "player.state.root" }, "player" },
	{ "Cleanse", { "!modifier.last(Cleanse)", "player.dispellable(Cleanse)" }, "player" },
	
    -- Raid Protection
	{ "Flash of Light", { "toggle.raidheal", "lowest.health < 25", "player.buff(Selfless Healer).count > 2" }, "lowest" },		
	{ "Lay on Hands", { "toggle.raidheal", "lowest.health < 15", "lowest" } },
	{ "Hand of Protection", { "toggle.raidheal", "lowest.exists", "lowest.alive", "lowest.friend", "lowest.isPlayer", "!lowest.role(tank)", "!lowest.immune.melee", "lowest.health <= 20" }, "lowest" },

	-- Mouseovers
	{ "Light's Hammer", { "modifier.lcontrol" }, "ground" },
	
	-- Out of Melee
	{ "Judgment", "!target.spell(Crusader Strike).range" },
	{ "Avenger's Shield", "!target.spell(Crusader Strike).range" },
    { "Hammer of Wrath", "!target.spell(Crusader Strike).range" },
	{ "Execution Sentence", "!target.spell(Crusader Strike).range" },

	-- AE DPS Rotation
	{ "Avenger's Shield", { "modifier.multitarget", "player.buff(Grand Crusader)" } },
	{ "Hammer of the Righteous", { "target.spell(Crusader Strike).range", "modifier.multitarget" } },
	{ "Judgment", "modifier.multitarget" },
	{ "Avenger's Shield", "modifier.multitarget" },
	{ "Consecration", { "modifier.multitarget", "target.spell(Crusader Strike).range", "!player.moving" } },
	{ "Holy Wrath", { "modifier.multitarget", "target.spell(Crusader Strike).range" } }, --Move above AS if you took sanctified wrath.
	{ "Hammer of Wrath" },
	
	-- Single Target DPS Rotation
	{ "Crusader Strike", "target.spell(Crusader Strike).range" },
	{ "Judgment" },
	{ "Avenger's Shield" },
	{ "Execution Sentence" },
	{ "Hammer of Wrath" },	
	{ "Consecration", { "target.spell(Crusader Strike).range", "!player.moving" } },
	{ "Holy Wrath", "target.spell(Crusader Strike).range" }, --Move above AS if you took sanctified wrath.
},{
-- OUT OF COMBAT ROTATION

	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Blessings
	{ "Blessing of Might", "!player.buff(Blessing of Might).any" },
	{ "Blessing of Kings", { "!player.buff(Blessing of Kings).any", "!player.buff(Blessing of Might)" } },


	-- Stance
	{ "Righteous Fury", "!player.buff(Righteous Fury)" },
  
},
function()
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('raidheal', 'Interface\\Icons\\spell_holy_sealofprotection', 'Raid Protection', 'Toggles usage of Hand spells and Flash of Light procs on the raid.')
	PossiblyEngine.toggle.create('selfheal', 'Interface\\Icons\\spell_nature_riptide', 'Self heal', 'Toggles usage of self healing such as flash of light and Word of Glory.')
end
)
