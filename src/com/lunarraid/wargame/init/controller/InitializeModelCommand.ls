package com.lunarraid.wargame.init.controller
{
	import com.lunarraid.wargame.init.model.ManifestProxy;
	import com.lunarraid.wargame.init.model.AssetProxy;
	
	import com.lunarraid.wargame.model.MapProxy;
	
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	public class InitializeModelCommand extends SimpleCommand
	{
		override public function execute( notification:INotification ):void
		{
			trace( "INITIALIZING MODEL");
            facade.registerProxy( new AssetProxy() );
            facade.registerProxy( new MapProxy() );
			facade.registerProxy( new ManifestProxy() );
		}
	}
}