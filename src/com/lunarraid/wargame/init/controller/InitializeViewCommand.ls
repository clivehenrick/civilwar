package com.lunarraid.wargame.init.controller
{
	import Loom2D.Display.Stage;
	import Loom2D.Display.Loom2DGame;
	
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	import com.lunarraid.wargame.init.view.StageMediator;
	import WarGame;
	
	public class InitializeViewCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace( "INITIALIZING VIEW");
			var stageMediator:StageMediator = new StageMediator( WarGame(notification.getBody()).getStage() ); 
			facade.registerMediator( stageMediator );
		}
	}
}