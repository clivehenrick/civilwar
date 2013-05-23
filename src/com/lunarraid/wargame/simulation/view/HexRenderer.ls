package com.lunarraid.wargame.simulation.view
{
	import Loom2D.Textures.Texture;
	import Loom2D.Display.Image;
	import Loom2D.Display.DisplayObject;
	import Loom2D.Display.Sprite;
	import Loom.GameFramework.LoomComponent;
	import com.lunarraid.wargame.simulation.math.Point3;
	
	public class HexRenderer extends LoomComponent
	{
		[Inject]
		public var hexMapView:HexMapView;
	
		private var _viewComponent:Image;
		private var _position:Point3 = new Point3();
		private var _scratchPoint:Point3 = new Point3();
		
		public function get viewComponent():DisplayObject { return _viewComponent; }
		
		public function get x():Number { return _position.x; }
		
		public function set x( value:Number ):void
		{
			if ( _position.x == value ) return;
			_position.x = value;
			updatePosition();
		}
		
		public function get y():Number { return _position.y; }

		public function set y( value:Number ):void
		{
			if ( _position.y == value ) return;
			_position.y = value;
			updatePosition();
		}

		public function get z():Number { return _position.z; }
		
		public function set z( value:Number ):void
		{
			if ( _position.z == value ) return;
			_position.z = value;
			updatePosition();
		}
		
		override public function onAdd():Boolean
		{
			super.onAdd();
        	var tex:Texture = Texture.fromAsset( "assets/textures/pattern.png" );
        	_viewComponent = new Image( tex );
        	_viewComponent.pivotX = _viewComponent.width * 0.5;
        	_viewComponent.pivotY = _viewComponent.height * 0.5;
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
		
		public function updatePosition():void
		{
			if ( !hexMapView ) return;
			_scratchPoint.copyFrom( _position );
			hexMapView.project( _scratchPoint );
			_viewComponent.x = _scratchPoint.x;
			_viewComponent.y = _scratchPoint.y;
		}
	}
}