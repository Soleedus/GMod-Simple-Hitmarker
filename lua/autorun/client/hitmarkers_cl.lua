resource.AddFile( "sound/hitmarker.wav" ) -- required for surface.PlaySound()

local DrawHitmarkers = CreateClientConVar( "hitmarkers_enable", 1 )
local NPCHitmarkers = CreateClientConVar( "hitmarkers_npc", 1 )
local PlayerHitmarkers = CreateClientConVar( "hitmarkers_player", 1 )

local alpha = 255 -- I wouldn't change this

hook.Add( "HUDPaint", "HitMarkers.draw", function()
	
	if DrawHitmarkers:GetBool() == false or !LocalPlayer():Alive() then alpha = 0 return end
	
	alpha = math.Approach( alpha, 0, 5 )
	
	local screen = Vector(ScrW() / 2, ScrH() / 2)
	
	surface.SetDrawColor( 255, 255, 255, alpha ) -- changes the color value of the hitmarker
	
	-- drawing the hitmarker
	surface.DrawLine( screen.x - 15, screen.y - 15, screen.x - 5, screen.y - 5 )
	surface.DrawLine( screen.x - 15, screen.y + 15, screen.x - 5, screen.y + 5 )
	surface.DrawLine( screen.x + 15, screen.y - 15, screen.x + 5, screen.y - 5 )
	surface.DrawLine( screen.x + 15, screen.y + 15, screen.x + 5, screen.y + 5 )
end );

net.Receive( "Hitmarkers.hit", function( iLen )
	local bIsNPC = ( net.ReadBit( ) == 1 && true || false );

	if( NPCHitmarkers:GetBool( ) && bIsNPC ) then
		alpha = 255;
	end

	if( PlayerHitmarkers:GetBool( ) && !bIsNPC ) then
		alpha = 255;
	end

	--surface.PlaySound( "/hitmarker.wav" ) -- old

	LocalPlayer():EmitSound("hitmarker.wav", 500, 100, 1) -- provides vars for volume
end );
