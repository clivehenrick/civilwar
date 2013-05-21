package
{
	import System.Dictionary;
	import Loom2D.Display.StageScaleMode;
	import Loom2D.Display.Stage;
	import Loom2D.Display.Loom2DGame;
	import Loom2D.Textures.Texture;
	import Loom2D.Display.Image;
	import Loom2D.Math.Point;
    
    import com.lunarraid.wargame.GameFacade;
    import com.lunarraid.wargame.init.controller.StartupCommand;

    public class WarGame extends Loom2DGame
    {
        override public function run():void
        {
            super.run();
        	stage.scaleMode = StageScaleMode.LETTERBOX;
        	stage.stageWidth = 640;
        	stage.stageHeight = 960;
        	GameFacade.getInstance().sendNotification(StartupCommand.NAME, this);
        	
        	
        	
        	
        	
        	
        	
        	/*
        	var tex:Texture = Texture.fromAsset( "assets/textures/pattern.png" );
        	tex.repeat = true;
        	
        	var image:Image = new Image( tex );
        	
        	var targetScale:Point = getScale( image.width, image.height, stage.stageWidth, stage.stageHeight );
        	
			image.setTexCoords(0, new Point(0, 0));
			image.setTexCoords(1, new Point(targetScale.x, 0));
			image.setTexCoords(2, new Point(0, targetScale.y));
			image.setTexCoords(3, new Point(targetScale.x, targetScale.y));
			
			image.width = stage.stageWidth;
			image.height = stage.stageHeight;
			        	
        	stage.addChild(image);
        	*/
        }
        
        public function getStage():Stage { return stage; }
        
        private function getScale( texWidth:int, texHeight:int, targetWidth:int, targetHeight:int ):Point
        {
        	return new Point( targetWidth / texWidth, targetHeight / texHeight );
        }
    }
}