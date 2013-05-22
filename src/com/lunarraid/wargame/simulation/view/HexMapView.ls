package com.lunarraid.wargame.simulation.view
{
	import Loom2D.Display.Sprite;
	
	import Loom.GameFramework.ILoomManager;
	
	public class HexMapView implements ILoomManager
	{
		private var _viewComponent:Sprite;
		
		public function initialize():void
		{
		}
		
		public function destroy():void
		{
		}
		
		public function addChild( child:HexRenderer ):void
		{
		}
		
		public function removeChild( child:HexRenderer ):void
		{
		}
	}
}