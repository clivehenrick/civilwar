package com.lunarraid.wargame
{
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.interfaces.IFacade;
	
	import com.lunarraid.wargame.controller.StartupCommand;

	public class GameFacade extends Facade
	{
	    public static function getInstance():IFacade
	    {
			if (instance == null) instance = new GameFacade();
			return instance;
	    }
	    
	    override protected function initializeController ():void
	    {
	        super.initializeController();
	        registerCommand(StartupCommand.NAME, StartupCommand);
	    }
	}
}