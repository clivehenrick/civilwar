package com.lunarraid.wargame.simulation.view
{
	import Loom2D.Textures.Texture;
	import Loom2D.Display.Image;
	import Loom2D.Display.DisplayObject;
	import Loom2D.Display.Sprite;
	import Loom.GameFramework.LoomComponent;
	
	public class HexRenderer extends LoomComponent
	{
		[Inject]
		public var hexMapView:HexMapView;
	
		private var _viewComponent:Image;
		
		public function get viewComponent():DisplayObject { return _viewComponent; }
		
		override public function onAdd():Boolean
		{
			super.onAdd();
        	var tex:Texture = Texture.fromAsset( "assets/textures/pattern.png" );
        	_viewComponent = new Image( tex );
        	hexMapView.addChild( this );
        	
        	return true;
		}
		
		override public function onRemove():void
		{
			hexMapView.removeChild( this );
			_viewComponent.dispose();
			_viewComponent = null;
			super.onRemove();
		}
	}
}