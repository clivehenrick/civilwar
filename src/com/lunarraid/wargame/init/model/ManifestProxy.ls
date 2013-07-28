package com.lunarraid.wargame.init.model
{
	import system.Dictionary;
	import system.JSON;
	import system.platform.File;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ManifestProxy extends Proxy
	{
		public static const PROXY_NAME:String = "ManifestProxy";
		
		private static const MANIFEST_URL:String = "assets/data/manifest.json";
		
		public function ManifestProxy() { super( PROXY_NAME ); }
		
		override public function onRegister():void
		{
			super.onRegister();
			loadManifestData();
		}
		
		private function loadManifestData():void
		{
		}
	}
}