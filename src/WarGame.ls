package
{
    import com.lunarraid.wargame.GameFacade;
    import com.lunarraid.wargame.init.controller.StartupCommand;
    import com.lunarraid.wargame.simulation.view.projection.IsoProjection;
	import com.lunarraid.wargame.simulation.math.Point3;
	
	import loom2d.display.*;
	import loom2d.ui.*;
	
	import loom.Application;

    public class WarGame extends Application
    {
        override public function run():void
        {
            super.run();
        	stage.scaleMode = StageScaleMode.NONE;
        	stage.stageWidth = 960;
        	stage.stageHeight = 640;
        	GameFacade.getInstance().sendNotification(StartupCommand.NAME, this);
       }
        
        public function getStage():Stage { return stage; }
    }
}