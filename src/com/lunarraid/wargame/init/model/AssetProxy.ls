package com.lunarraid.wargame.init.model
{
	import Loom2D.UI.TextureAtlasManager;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.interfaces.INotification;
	
	public class AssetProxy extends Proxy
	{
		public static const PROXY_NAME:String = "AssetProxy";
		
		public function AssetProxy() { super( PROXY_NAME ); }
		
		override public function onRegister():void
		{
			super.onRegister();
			TextureAtlasManager.register("sprites", "assets/textures/");
		}
	}
}