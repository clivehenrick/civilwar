package com.lunarraid.wargame.simulation.groups
{
	import loom.gameframework.*;
	import loom2d.display.DisplayObject;
	
	import com.lunarraid.wargame.simulation.gameobjects.*;
	import com.lunarraid.wargame.simulation.view.*;
	
	public class IntermediateViewGroup extends LoomGroup implements ISimulationGroup
	{
		private var _hexMapView:ProjectedViewManager;
		
		public function get viewComponent():DisplayObject { return _hexMapView ? _hexMapView.viewComponent : null; }
		
		override public function initialize( objectName:String ):void
		{
			super.initialize( objectName );
			
			_hexMapView = new ProjectedViewManager();
			registerManager( _hexMapView );
			
			var backgroundPlate:StaticImageGameObject = new StaticImageGameObject( "assets/textures/backgrounds/bg1.png" );
			backgroundPlate.owningGroup = this;
			backgroundPlate.initialize( "background" );
		}
	}
}