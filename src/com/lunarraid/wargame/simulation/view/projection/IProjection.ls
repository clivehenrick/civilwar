package com.lunarraid.wargame.simulation.view.projection
{
	import com.lunarraid.wargame.simulation.math.Point3;
	
	public interface IProjection
	{
		function set tileSize( value:int ):void;
		function get tileSize():int;
		function project( position:Point3, modifyOriginal:Boolean=true ):Point3;
		function unproject( position:Point3, modifyOriginal:Boolean=true ):Point3;
	}
}