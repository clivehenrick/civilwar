package com.lunarraid.wargame.init.controller
{
	import Loom2D.Display.Stage;
	import Loom2D.Display.Loom2DGame;
	
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	import com.lunarraid.wargame.init.view.StageMediator;
	import com.lunarraid.wargame.init.view.SimulationLayerMediator;
	
	import WarGame;
	
	public class InitializeViewCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace( "INITIALIZING VIEW");
			var warGame:WarGame = notification.getBody() as WarGame;
			var stageMediator:StageMediator = new StageMediator( warGame.getStage() ); 
			facade.registerMediator( stageMediator );
			var simulationLayerMediator:SimulationLayerMediator = new SimulationLayerMediator( warGame.group );
			stageMediator.appendLayer( simulationLayerMediator );
		}
	}
}