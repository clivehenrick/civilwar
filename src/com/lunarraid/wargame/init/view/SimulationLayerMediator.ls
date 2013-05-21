package com.lunarraid.wargame.init.view
{
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import Loom.GameFramework.LoomGroup;
	
	import Loom2D.Textures.Texture;
	import Loom2D.Display.Image;
	import Loom2D.Math.Point;
	
	public class SimulationLayerMediator extends Mediator
	{
		public static const NAME:String = "SimulationLayerMediator";
		
		private var _rootGroup:LoomGroup;
		
		public function SimulationLayerMediator( rootGroup:LoomGroup )
		{
			
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
        	
        	
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