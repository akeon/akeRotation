ProbablyEngine.rotation.register_custom(262, "akeElementalShaman", {
-- Author: AkeRotations
-- Version: 1.6 16/10/14 Remove death timer condition
    -- Add support for Ancestral swiftness
    -- Optimize logic for earthshock or flameshock.
    -- Reprioritise Elemental Blast
-- Version: 1.5 15/10/14 Modified so will only use unleash flame if talent unleashed fury exists.
-- Version: 1.4 14/10/14 Added survival toggle (cleanse / auto windwalk totem)
-- Version: 1.3 14/10/14 Overhaul for 6.0.2. Add Unleash elements. Add Anscestral Swiftness. Revamp movement rotation in light of lightning bolt change.
-- Version: 1.2 21/09/14 (MOP)
-- Version: 1.0 Review and adapted from BlackBurn (Credits to him for the platform to work off).

-- Notes: Manually cast Thunderstorm, Earth Elemental, damage reductions, Earthbind and other utility totems for optimal use.
-- Pause: Left Alt
-- Earthquake: Left Control

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lalt" },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- Interrupt
	{ "Wind Shear", "modifier.interrupt" },

	-- Self Heals
	{ "Healing Surge", { "toggle.selfheal", "player.health < 20" } },
	{ "Healing Stream Totem", { "toggle.selfheal", "!player.totem(Healing Stream Totem)", "player.health < 30" } },
 
 	--Survival Abilities
 	{ "Windwalk Totem", { "toggle.survival", "!player.buff", "player.state.root" }, "player" }, 
	{ "Windwalk Totem", { "toggle.survival", "!player.buff", "player.state.snare" }, "player" }, 
	{ "Cleanse Spirit", { "toggle.survival", "!modifier.last(Cleanse Spirit)", "player.dispellable(Cleanse Spirit)" }, "player" }, 
 
	-- Control Toggles
	{ "Flame Shock", { "!modifier.multitarget", "mouseover.enemy", "mouseover.alive", "mouseover.debuff(Flame Shock).duration <= 3", "toggle.mouseovers" }, "mouseover" },
	{ "Earthquake", { "modifier.lcontrol" }, "ground" },

	-- Cooldowns
	{ "Fire Elemental Totem", "modifier.cooldowns" },
	{ "Elemental Mastery", "modifier.cooldowns" },
	{ "Berserking", "modifier.cooldowns" },
	{ "Ascendance", { "modifier.cooldowns", "!player.buff(Ascendance)" } },
	{ "Spiritwalker's Grace", { "player.moving", "modifier.cooldowns", "player.buff(Ascendance)" } },
	{ "Ancestral Swiftness" },

	-- Movement Rotation
	{ "Flame Shock", { "player.moving", "target.debuff(Flame Shock).duration <= 3", "!player.buff(Spiritwalker's Grace)" } },
	{ "Lava Burst", { "player.moving", "player.buff(Lava Surge)", "!player.buff(Spiritwalker's Grace)" } },
	{ "Earth Shock", { "player.moving", "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count >= 15", "!player.buff(Spiritwalker's Grace)" } },
	{ "Chain Lightning", { "player.moving", "toggle.cleavemode", "player.buff(Ancestral Swiftness)", "!player.buff(Spiritwalker's Grace)" } },
	{ "Chain Lightning", { "player.moving", "modifier.multitarget", "!player.buff(Ascendance)", "player.buff(Ancestral Swiftness)", "!player.buff(Spiritwalker's Grace)" } },	
	{ "Elemental Blast", { "player.moving", "player.buff(Ancestral Swiftness)", "!player.buff(Spiritwalker's Grace)" } },
	{ "Lightning Bolt", { "player.moving", "player.buff(Ancestral Swiftness)", "!player.buff(Spiritwalker's Grace)" } },
	{ "Earth Shock", { "player.moving", "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count >= 15", "!player.buff(Spiritwalker's Grace)", "!target.debuff(Flame Shock).duration <= 3" } },	
	-- AE
--	{ "Earthquake", "ground" },  -- Turn on if you want auto Earthquake at mouse location.
	{ "Lava Beam", { "modifier.multitarget", "player.buff(Ascendance)" } },
	{ "Earth Shock", { "modifier.multitarget", "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count >= 15" } },
	{ "Searing Totem", { "modifier.multitarget", "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } },
	{ "Chain Lightning", { "modifier.multitarget", "!player.buff(Ascendance)" } },
	
	-- Main Rotation
	{ "Unleash Flame", "talent(6, 1)" },
	{ "Flame Shock", "target.debuff(Flame Shock).duration <= 3" },
	{ "Lava Burst" },
	{ "Earth Shock", { "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count >= 15" } },
	{ "Elemental Blast" },
	{ "Chain Lightning", { (function() return UnitsAroundUnit('target', 10) >= 2 end), "!toggle.cleavemode" } },
	{ "Searing Totem", { "!modifier.multitarget", "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } },
	{ "Lightning Bolt" },
		
}, {
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lalt" },
	
	-- Buffs
	{ "Lightning Shield", "!player.buff(Lightning Shield)" },

},
function()
	ProbablyEngine.toggle.create('cleavemode', 'Interface\\Icons\\spell_nature_chainlightning', 'Disable Cleaves', 'Disables automatic casting of chain lightning when 2 or more enemies exist.')
	ProbablyEngine.toggle.create('survival', 'Interface\\Icons\\spell_frost_frostshock', 'Snare and Curse Removal', 'Enables automatic removal of roots, snares and curses.')
	ProbablyEngine.toggle.create('selfheal', 'Interface\\Icons\\spell_nature_riptide', 'Enable Healing', 'Enable self healing logic')
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Enable Mouseovers', 'Enable multi-target flameshock logic.')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Enable auto target nearest enemy logic.')
end
)
