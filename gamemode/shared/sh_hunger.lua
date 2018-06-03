local plymeta = FindMetaTable( "Player" )

if SERVER then

    util.AddNetworkString( "Hunger" )

    function plymeta:AddHunger( amount )
		local hunger = self:GetHunger()
		self:SetHunger(hunger + amount)
    end

    function plymeta:SetHunger( amount )
		net.Start("Hunger")
			net.WriteDouble(amount)
		net.Send( self )
    end

else

    net.Receive( "Hunger", function( len, pl )
        if not LocalPlayer().stats then LocalPlayer().stats = {} end
		LocalPlayer().stats["Hunger"] = net.ReadDouble()
    end)

end

function plymeta:GetHunger()
	return self.stats["Hunger"] || 0
end
