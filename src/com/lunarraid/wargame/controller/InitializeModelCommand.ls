package com.lunarraid.wargame.controller
{
	import com.lunarraid.wargame.model.MapProxy;
	
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	public class InitializeModelCommand extends SimpleCommand
	{
		override public function execute( notification:INotification ):void
		{
			trace( "INITIALIZING MODEL");
            facade.registerProxy( new MapProxy() );
		}
	}
}