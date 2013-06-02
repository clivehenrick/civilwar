package
{
	import Loom2D.Display.StageScaleMode;
	import Loom2D.Display.Stage;
	import Loom2D.Display.Loom2DGame;
    
    import com.lunarraid.wargame.GameFacade;
    import com.lunarraid.wargame.init.controller.StartupCommand;
    import com.lunarraid.wargame.simulation.view.projection.IsoProjection;
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
        	
        	var isoProj:IsoProjection = new IsoProjection();
        	for (var i:int=0; i<20; i++) {
        		var tp:Point3 = new Point3( int(Math.random()*200-100), int(Math.random()*200-100), int(Math.random()*200-100) );
        		trace( tp.toString() == isoProj.unproject(isoProj.project(tp)).toString() );
        		//trace( tp.toString() + " : " + isoProj.unproject(isoProj.project(tp)).toString() );
        	}
       }
        
        public function getStage():Stage { return stage; }
    }
}