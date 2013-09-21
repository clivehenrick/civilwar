package com.lunarraid.wargame.view.projection
{
	import com.lunarraid.wargame.math.Point3;
	
	public interface IProjection
	{
		function set tileWidth( value:int ):void;
		function get tileWidth():int;
		function project( position:Point3 ):Point3;
		function unproject( position:Point3 ):Point3;
	}
}