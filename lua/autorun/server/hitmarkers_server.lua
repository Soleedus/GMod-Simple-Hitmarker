util.AddNetworkString( "Hitmarkers.hit" );
 
local function HitMarkersServer( objEnt, dmgInfo )
	if( !IsValid( objEnt ) ) then return; end
 
	local objAttacker = dmgInfo:GetAttacker( );
 
	if( !IsValid( objAttacker ) || !objAttacker:IsPlayer( ) ) then return; end
 
	if( objEnt:IsPlayer( ) || objEnt:IsNPC( ) ) then
		net.Start( "Hitmarkers.hit" );
			net.WriteBit( objEnt:IsNPC( ) );
		net.Send( objAttacker );
	end	
end
hook.Add( "EntityTakeDamage", "Hitmarkers.detect", HitMarkersServer );
 
print( "[Simple Hitmarkers loaded...]" )