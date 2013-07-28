package com.lunarraid.wargame.init.controller
{
	import org.puremvc.as3.patterns.command.MacroCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	public class StartupCommand extends MacroCommand
	{
		public static const NAME:String = "StartupCommand";
	
		override protected function initializeMacroCommand():void
		{
			addSubCommand( RegisterCommandsCommand );
			addSubCommand( InitializeModelCommand );
			addSubCommand( InitializeViewCommand );
		}
	}
}