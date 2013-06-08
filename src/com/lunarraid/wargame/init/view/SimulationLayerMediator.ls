package com.lunarraid.wargame.init.view
{
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import loom.gameframework.LoomGroup;
	import loom.gameframework.LoomGameObject;
	
	import loom2d.textures.Texture;
	import loom2d.display.Image;
	import loom2d.math.Point;
	import loom2d.events.TouchEvent;
	
	import loom.animation.Tween;
	
	import com.lunarraid.wargame.simulation.view.ProjectedViewManager;
	import com.lunarraid.wargame.simulation.view.ProjectedImageRenderComponent;
	import com.lunarraid.wargame.simulation.view.projection.*;
	
	public class SimulationLayerMediator extends Mediator
	{
		public static const NAME:String = "SimulationLayerMediator";
		
		private var _rootGroup:LoomGroup;
		private var _simulationGroup:LoomGroup;
		private var _hexMapView:ProjectedViewManager;
		
		private var _objects:Vector.<LoomGameObject> = [];
		
		private var tempX:int = 0;
		private var tempY:int = 0;
		
		public function SimulationLayerMediator( rootGroup:LoomGroup )
		{
			_rootGroup = rootGroup;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			_hexMapView = new ProjectedViewManager();
			
			_simulationGroup = new LoomGroup();
			_simulationGroup.owningGroup = _rootGroup;
			_simulationGroup.initialize( "simulationGroup" );
			_simulationGroup.registerManager( _hexMapView );
			
        	setViewComponent( _hexMapView.viewComponent );
        	_hexMapView.viewComponent.addEventListener( TouchEvent.TOUCH, onTouch );
        	//_hexMapView.projection = new IsoProjection();
        	
        	onTouch();
        	
        	/*
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
			*/
		}
		
		private function onTouch( e:TouchEvent=null ):void
		{
        	if (tempY > 25)
        	{
        		while ( _objects.length > 0 ) _objects.pop().destroy();
        		tempY = 0;
        		_hexMapView.viewComponent.y = 50;
        	}
        	
        	
        	var hexEntity:LoomGameObject = new LoomGameObject();
        	hexEntity.owningGroup = _simulationGroup;
        	
	       	var hexRenderer:ProjectedImageRenderComponent = new ProjectedImageRenderComponent();
   			hexRenderer.x = tempX;
   			hexRenderer.y = tempY;
   			hexEntity.addComponent( hexRenderer, "ProjectedImageRenderComponent" );
        	
        	hexEntity.initialize();
        	
	       	if ( int(Math.random() * 10) == 5 )
	       	{
		       	var hexRenderer2:ProjectedImageRenderComponent = new ProjectedImageRenderComponent("building");
	   			hexRenderer2.x = tempX;
	   			hexRenderer2.y = tempY;
	   			hexRenderer2.z = -0.6;
	   			hexEntity.addComponent( hexRenderer2, "ProjectedImageRenderComponent2" );
	   		}
   			
        	tempX++;
        	if (tempX > 10)
        	{
        		tempX = 0;
        		tempY++;
        		_hexMapView.viewComponent.y -= 20;
        	}
        	
        	_objects.push( hexEntity );
		}
		
        private function getScale( texWidth:int, texHeight:int, targetWidth:int, targetHeight:int ):Point
        {
        	return new Point( targetWidth / texWidth, targetHeight / texHeight );
        }
	}
}