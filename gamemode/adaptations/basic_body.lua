local tbl = {}
tbl.Name = "Basic Body"
tbl.Model = "models/hunter/blocks/cube025x05x025.mdl"
tbl.type = "Body"
tbl.desc = ""
tbl.default = true
tbl.cost = 0
tbl.slots = {
	[1] = {
		pos = Vector(0,0, 10),
		ang = Angle(0,0,0),
	}
}
tbl.effects = {
	["HUD"] = function(self)

	end,
	["Skill"] = function(self)

	end,
	["Damage"] = function(self)

	end,
	["Death"] = function(self)

	end,
	["Evolve"] = function(self)

	end,
}
RegisterAdaptation(tbl)
