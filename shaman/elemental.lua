-- ProbablyEngine Rotation Packager
PossiblyEngine.rotation.register_custom(262, "akeElementalShaman", {
-- Author: AkeRotations
-- Version: 1.2 21/09/14 (MOP)
-- Changelog: 1.2 Added earthquake.
-- Changelog: 1.1 Further cast while moving optimisations.
-- Changelog: 1.0 Review and adapted from BlackBurn (Credits to him for the platform to work off).

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
	{ "Healing Surge", { "toggle.selfheal", "player.health < 40" } },
	{ "Healing Stream Totem", { "toggle.selfheal", "!player.totem(Healing Stream Totem)", "player.health < 50" } },
 
	-- Mouseovers
	{ "Flame Shock", { "!modifier.multitarget", "mouseover.enemy", "mouseover.alive", "mouseover.deathin > 25", "mouseover.debuff(Flame Shock).duration <= 3", "toggle.mouseovers" }, "mouseover" },
	{ "Earthquake", { "modifier.lcontrol" }, "ground" },
	
	-- Core Rotation
	{ "Searing Totem", { "!modifier.multitarget", "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } },
	{ "Flame Shock", { "!modifier.multitarget", "target.debuff(Flame Shock).duration <= 3", "!player.buff(Spiritwalker's Grace)" } },
	
	-- Cooldowns
	{ "Stormlash Totem", { "modifier.cooldowns", "toggle.lash", "!totem(Stormlash Totem)" } },
	{ "Fire Elemental Totem", "modifier.cooldowns" },
	{ "Berserking", "modifier.cooldowns" },
	{ "Elemental Mastery", "modifier.cooldowns" },
	{ "Ascendance", { "modifier.cooldowns", "!player.buff(Ascendance)" } },
	{ "Spiritwalker's Grace", { "modifier.cooldowns", "player.buff(Ascendance)" } },

	-- Movement Rotation
	{ "Flame Shock", { "player.moving", "target.debuff(Flame Shock).duration <= 3", "!player.buff(Spiritwalker's Grace)" } },
	{ "Lava Burst", { "player.moving", "player.buff(Lava Surge)", "!player.buff(Spiritwalker's Grace)" } },
	{ "Earth Shock", { "player.moving", "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count >= 6", "!player.buff(Spiritwalker's Grace)" } },
	{ "Lightning Bolt", { "player.moving", "!player.buff(Spiritwalker's Grace)" } },
	
	-- AE
	{ "Chain Lightning", { "modifier.multitarget", "!player.buff(Ascendance)" } },
	{ "Lava Beam", { "modifier.multitarget", "player.buff(Ascendance)" } },

	-- Main Rotation
	{ "Flame Shock", "target.debuff(Flame Shock).duration <= 3" },
	{ "Lava Burst" },
	{ "Elemental Blast" },
	{ "Earth Shock", { "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count >= 6" } },
	{ "Chain Lightning", "toggle.cleavemode" },
	{ "Lightning Bolt" },
		
}, {
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lalt" },
	
	-- Buffs
	{ "Flametongue Weapon", "!player.enchant.mainhand" },
	{ "Lightning Shield", "!player.buff(Lightning Shield)" },

},
function()
	PossiblyEngine.toggle.create('cleavemode', 'Interface\\Icons\\spell_nature_chainlightning', 'Cleave Mode', 'Enables cleave mode - Lower priority than multi-target.')
	PossiblyEngine.toggle.create('lash', 'Interface\\Icons\\spell_frost_frostshock', 'Enable Stormlash', 'Beware if you have multiple shamans in the group.')
	PossiblyEngine.toggle.create('selfheal', 'Interface\\Icons\\spell_nature_riptide', 'Enable Healing', 'Enable self healing logic')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Enable Mouseovers', 'Enable multi-target flameshock logic.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Enable auto target nearest enemy logic.')
end
)
