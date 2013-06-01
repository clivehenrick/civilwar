package com.lunarraid.wargame.init.view
{
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import Loom.GameFramework.LoomGroup;
	import Loom.GameFramework.LoomGameObject;
	
	import Loom2D.Textures.Texture;
	import Loom2D.Display.Image;
	import Loom2D.Math.Point;
	import Loom2D.Events.TouchEvent;
	
	import Loom.Animation.Tween;
	
	import com.lunarraid.wargame.simulation.view.ProjectedViewManager;
	import com.lunarraid.wargame.simulation.view.ProjectedViewRenderComponent;
	
	public class SimulationLayerMediator extends Mediator
	{
		public static const NAME:String = "SimulationLayerMediator";
		
		private var _rootGroup:LoomGroup;
		private var _simulationGroup:LoomGroup;
		private var _hexMapView:ProjectedViewManager;
		
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
        	var hexEntity:LoomGameObject = new LoomGameObject();
        	hexEntity.owningGroup = _simulationGroup;
        	
	       	var hexRenderer:ProjectedViewRenderComponent = new ProjectedViewRenderComponent();
   			hexRenderer.x = tempX;
   			hexRenderer.y = tempY;
   			hexEntity.addComponent( hexRenderer, "ProjectedViewRenderComponent" );
        	
        	hexEntity.initialize();
        	
	       	if ( int(Math.random() * 10) == 5 )
	       	{
		       	var hexRenderer2:ProjectedViewRenderComponent = new ProjectedViewRenderComponent("building");
	   			hexRenderer2.x = tempX;
	   			hexRenderer2.y = tempY;
	   			hexRenderer2.z = -0.6;
	   			hexEntity.addComponent( hexRenderer2, "ProjectedViewRenderComponent2" );
	   		}
   			
        	tempX++;
        	if (tempX > 10)
        	{
        		tempX = 0;
        		tempY++;
        		_hexMapView.viewComponent.y -= 20;
        	}
		}
		
        private function getScale( texWidth:int, texHeight:int, targetWidth:int, targetHeight:int ):Point
        {
        	return new Point( targetWidth / texWidth, targetHeight / texHeight );
        }
	}
}