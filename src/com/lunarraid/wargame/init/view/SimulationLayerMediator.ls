package com.lunarraid.wargame.init.view
{
    import org.puremvc.as3.patterns.mediator.Mediator;
    import org.puremvc.as3.patterns.facade.Facade;
	
	import loom.gameframework.LoomGroup;
	import loom.gameframework.LoomGameObject;
	
	import loom2d.textures.Texture;
	import loom2d.display.*;
	import loom2d.math.Point;
	import loom2d.events.TouchEvent;
	
	import com.lunarraid.wargame.simulation.view.ProjectedViewManager;
	import com.lunarraid.wargame.simulation.view.ProjectedAtlasSpriteRenderComponent;
	import com.lunarraid.wargame.simulation.view.*;
	import com.lunarraid.wargame.simulation.groups.*;
	
	import feathers.display.*;
	
	public class SimulationLayerMediator extends Mediator
	{
		public static const NAME:String = "SimulationLayerMediator";
		
		private var _rootGroup:LoomGroup;
		private var _simulationGroup:ISimulationGroup;
		private var _viewComponent:Sprite;
		
		public function SimulationLayerMediator( rootGroup:LoomGroup )
		{
			_rootGroup = rootGroup;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			_rootGroup.registerManager( facade, Facade );
			
			_simulationGroup = new MapViewGroup();
			_simulationGroup.owningGroup = _rootGroup;
			_simulationGroup.initialize( "simulationGroup" );
			
        	_viewComponent = new Sprite();
        	_viewComponent.addChild( _simulationGroup.viewComponent );
        	
        	setViewComponent( _viewComponent );
		}
		
        private function getScale( texWidth:int, texHeight:int, targetWidth:int, targetHeight:int ):Point
        {
        	return new Point( targetWidth / texWidth, targetHeight / texHeight );
        }
	}
}