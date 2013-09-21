package com.lunarraid.wargame.controller
{
    import loom2d.ui.TextureAtlasManager;
	
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	import com.lunarraid.wargame.view.StageMediator;
	import com.lunarraid.wargame.view.MapMediator;
	
	public class InitializeViewCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace( "INITIALIZING VIEW");
			
            // Register Sprites
            TextureAtlasManager.register("sprites", "assets/textures/sprites.xml");
			
			// Register Mediators 
			var stageMediator:StageMediator = new StageMediator(); 
			facade.registerMediator( stageMediator );
			var mapMediator:MapMediator = new MapMediator();
			stageMediator.appendLayer( mapMediator );
		}
	}
}