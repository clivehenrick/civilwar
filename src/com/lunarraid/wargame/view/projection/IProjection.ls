package com.lunarraid.wargame.view.projection
{
	import com.lunarraid.wargame.math.Point3;
	
	public interface IProjection
	{
		function set tileWidth( value:int ):void;
		function get tileWidth():int;
		function project( position:Point3, modifyOriginal:Boolean=true ):Point3;
		function unproject( position:Point3, modifyOriginal:Boolean=true ):Point3;
		function roundCoordinates( position:Point3, modifyOriginal:Boolean=true ):Point3;
	}
}