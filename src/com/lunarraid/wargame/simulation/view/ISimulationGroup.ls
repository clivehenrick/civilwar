package com.lunarraid.wargame.simulation.view
{
	import loom2d.display.DisplayObject;
	import loom.gameframework.LoomGroup;
	
	public interface ISimulationGroup
	{
		function get viewComponent():DisplayObject;
		function get owningGroup():LoomGroup;
		function set owningGroup( value:LoomGroup ):void;
		
		function initialize( objectName:String ):void;
		function destroy():void;
	}
}