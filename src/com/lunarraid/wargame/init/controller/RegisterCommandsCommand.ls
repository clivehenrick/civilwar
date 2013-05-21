package com.lunarraid.wargame.init.controller
{
	import System.Debug;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	public class RegisterCommandsCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace( "REGISTERING COMMANDS");
		}
	}
}