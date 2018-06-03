AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

local bo,ao = Vector(-25,-25,-25),Vector(25,25,25)
local up	= Vector(0,0,1)
local zero  = Vector(0,0,0)

function ENT:OnRemove()	
end

function ENT:KeyValue(key,value)
end

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x05x025.mdl")
	self:PhysicsInitBox(bo,ao)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self.Phys = self:GetPhysicsObject()
	self.Phys:EnableMotion(true)
	self.Phys:EnableGravity(false)
	self.Phys:Wake()
	self:StartMotionController()
end

function ENT:OnRemove()

end

function ENT:OnTakeDamage(dmg)

end

function ENT:Use(ent)
end


function ENT:Think()
	if self:GetPlayer() then
		local pl 	= self:GetPlayer()
		if pl:KeyDown(IN_ATTACK2) then
			self.storedangle = pl:EyeAngles()
		end
		if pl:KeyDown(IN_FORWARD) then
			self.Speed = math.Clamp((self.Speed || 0) + 1, -self.MaxSpeed, self.MaxSpeed)
		elseif pl:KeyDown(IN_BACK) then
			self.Speed = math.Clamp( (self.Speed || 0) - 1, -self.MaxSpeed, self.MaxSpeed)
		end
			
		if !self.storedangle then self.storedangle = self:GetAngles() end
	end
end

local ShadowParams = {
    secondstoarrive     = 1,
    maxangular             = 1000,
    maxangulardamp         = 10000,
    maxspeed             = 1000000,
    maxspeeddamp         = 10000,
    dampfactor             = 0.8,
    teleportdistance     = 200,
    deltatime             = deltatime
}

function ENT:PhysicsSimulate(phys,delta)
    phys:Wake()
    ShadowParams.pos         = self:GetPos() + self:GetForward() * ( (self.Speed || 0) *  (self.ShipSpeed || 10))
    ShadowParams.angle         = self.storedangle
    ShadowParams.deltatime     = delta
    
    phys:ComputeShadowControl( ShadowParams )
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
