package com.lunarraid.wargame.init.view
{
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import loom.gameframework.LoomGroup;
	import loom.gameframework.LoomGameObject;
	
	import loom2d.textures.Texture;
	import loom2d.display.*;
	import loom2d.math.Point;
	import loom2d.events.TouchEvent;
	
	import loom.animation.Tween;
	
	import com.lunarraid.wargame.simulation.view.ProjectedViewManager;
	import com.lunarraid.wargame.simulation.view.ProjectedAtlasSpriteRenderComponent;
	import com.lunarraid.wargame.simulation.view.*;
	import com.lunarraid.wargame.simulation.groups.*;
	
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
			
			_simulationGroup = new IntermediateViewGroup();
			_simulationGroup.owningGroup = _rootGroup;
			_simulationGroup.initialize( "simulationGroup" );
			
        	_viewComponent = new Sprite();
        	_viewComponent.addChild( _simulationGroup.viewComponent );
        	setViewComponent( _viewComponent );
		}
		
		private function createRepeatingBackground():void
		{
        	var tex:Texture = Texture.fromAsset( "assets/textures/pattern.png" );
        	tex.repeat = true;
        	
        	var image:Image = new Image( tex );
        	
        	var targetScale:Point = getScale( image.width, image.height, 640, 480 );
        	
			image.setTexCoords(0, new Point(0, 0));
			image.setTexCoords(1, new Point(targetScale.x, 0));
			image.setTexCoords(2, new Point(0, targetScale.y));
			image.setTexCoords(3, new Point(targetScale.x, targetScale.y));
			
			image.width = 640;
			image.height = 480;
			
			setViewComponent( image );
		}
		
        private function getScale( texWidth:int, texHeight:int, targetWidth:int, targetHeight:int ):Point
        {
        	return new Point( targetWidth / texWidth, targetHeight / texHeight );
        }
	}
}