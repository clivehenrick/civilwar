package com.lunarraid.wargame.simulation.factory
{
	import Loom.GameFramework.LoomGroup;
	
	public class SimulationGroupFactory
	{
		public static const HEX_MAP_GROUP:String = "HexMapGroup";
		
		public static function createGroup( name:String ):LoomGroup
		{
			var result:LoomGroup = new LoomGroup();
			
			switch( name )
			{
				case HEX_MAP_GROUP:
					//result.registerManager( new HexMapView() );
			}
			
		}
	}
}