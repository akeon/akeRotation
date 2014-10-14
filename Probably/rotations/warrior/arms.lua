-- SPEC ID 71
ProbablyEngine.rotation.register(71, {

  --------------------
  -- Start Rotation --
  --------------------
  
  -- Buffs
  { "Berserker Rage" },

  -- Survival
  { "Rallying Cry", { "player.health <= 35" }},
  { "Shield Wall", { "player.health <= 55" }},
  { "Die by the Sword", { "player.health <= 65" }},
  
  { "Hamstring", { 
    "!target.debuff(Hamstring)", 
    "modifier.player",
  }},
  
  { "Impending Victory", "player.health <= 85" },
  { "Victory Rush", "player.health <= 85" },

  -- Interrupts
  { "Pummel", "modifier.interrupts" },
  { "Disrupting Shout", "modifier.interrupts" },

  -- Cooldowns
  { "Bloodbath", "modifier.cooldowns"  },
  { "Avatar", "modifier.cooldowns"  },
  { "Recklessness", "modifier.cooldowns"  },
  { "Skull Banner", "modifier.cooldowns"  },
  { "Bladestorm", "modifier.cooldowns"  },

  -- AoE
  { "Sweeping Strikes", "modifier.multitarget", "target.range <= 5" },
  { "Thunder Clap", "modifier.multitarget", "target.range <= 5" },
  { "Whirlwind", "modifier.multitarget", "target.range <= 5" },
  { "Dragon Roar", "modifier.multitarget", "target.range <= 5" },

  -- Rotation
  { "Execute" },
  { "Overpower" },
  { "Mortal Strike" },
  { "Colossus Smash" },
  { "Heroic Throw" },
  
  { "Heroic Strike", { 
    "player.rage > 70", 
    "target.debuff(Colossus Smash)",
  }},
  
  { "Slam", "player.rage > 40" },
  
  ------------------
  -- End Rotation --
  ------------------
  
})
