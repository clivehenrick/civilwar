package
{
	import loom.graphics.Graphics;
    import com.lunarraid.wargame.GameFacade;
    import com.lunarraid.wargame.controller.StartupCommand;
    import com.lunarraid.wargame.view.projection.IsoProjection;
	import com.lunarraid.wargame.math.Point3;
	
	import loom.graphics.Graphics;
	
	import loom2d.math.Point;
	
    import loom2d.display.*;
	import loom2d.ui.*;
	
	import loom.Application;

    public class WarGame extends Application
    {
        override public function run():void
        {
            super.run();
        	stage.scaleMode = StageScaleMode.NONE;
            //Graphics.setDebug( Graphics.DEBUG_NONE );
            //Graphics.setDebug( Graphics.DEBUG_STATS | Graphics.DEBUG_TEXT );
        	GameFacade.getInstance().sendNotification( StartupCommand.NAME, this );
       }
    }
}