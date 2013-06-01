package
{
	import Loom2D.Display.StageScaleMode;
	import Loom2D.Display.Stage;
	import Loom2D.Display.Loom2DGame;
    
    import com.lunarraid.wargame.GameFacade;
    import com.lunarraid.wargame.init.controller.StartupCommand;
    import com.lunarraid.wargame.simulation.view.projection.HexProjection;
	import com.lunarraid.wargame.simulation.math.Point3;
	
	import Loom2D.Display.*;
	import Loom2D.UI.*;

    public class WarGame extends Loom2DGame
    {
        override public function run():void
        {
            super.run();
        	stage.scaleMode = StageScaleMode.LETTERBOX;
        	stage.stageWidth = 960;
        	stage.stageHeight = 640;
        	GameFacade.getInstance().sendNotification(StartupCommand.NAME, this);
       }
        
        public function getStage():Stage { return stage; }
    }
}