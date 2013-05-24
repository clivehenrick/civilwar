package com.lunarraid.wargame.init.view
{
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import Loom.GameFramework.LoomGroup;
	import Loom.GameFramework.LoomGameObject;
	
	import Loom2D.Textures.Texture;
	import Loom2D.Display.Image;
	import Loom2D.Math.Point;
	
	import Loom.Animation.Tween;
	
	import com.lunarraid.wargame.simulation.view.HexMapView;
	import com.lunarraid.wargame.simulation.view.HexRenderer;
	
	public class SimulationLayerMediator extends Mediator
	{
		public static const NAME:String = "SimulationLayerMediator";
		
		private var _rootGroup:LoomGroup;
		private var _simulationGroup:LoomGroup;
		
		public function SimulationLayerMediator( rootGroup:LoomGroup )
		{
			_rootGroup = rootGroup;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			var hexMapView:HexMapView = new HexMapView();
			
			_simulationGroup = new LoomGroup();
			_simulationGroup.registerManager( hexMapView );
			_simulationGroup.owningGroup = _rootGroup;
			_simulationGroup.initialize( "simulationGroup" );
			
        	var hexEntity:LoomGameObject = new LoomGameObject();
        	hexEntity.owningGroup = _simulationGroup;
        	
        	for ( var i:int = 0; i<10; i++ )
        	{
        		for ( var j:int = 0; j < 10; j++ )
        		{
		        	var hexRenderer:HexRenderer = new HexRenderer();
        			hexRenderer.x = i;
        			hexRenderer.y = j;
        			hexEntity.addComponent( hexRenderer, "HexRenderer" + ( i * 10 + j ) );
        		}
        	}
        	
        	hexEntity.initialize();
        	
        	setViewComponent( hexMapView.viewComponent );
        	
        	
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
		
        private function getScale( texWidth:int, texHeight:int, targetWidth:int, targetHeight:int ):Point
        {
        	return new Point( targetWidth / texWidth, targetHeight / texHeight );
        }
	}
}