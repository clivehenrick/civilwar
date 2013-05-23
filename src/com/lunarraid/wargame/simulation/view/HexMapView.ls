package com.lunarraid.wargame.simulation.view
{
	import Loom2D.Display.DisplayObject;
	import Loom2D.Display.Sprite;
	import Loom2D.Math.Point;
	import System.Math;
	import com.lunarraid.wargame.simulation.math.Point3;
	import Loom.GameFramework.ILoomManager;
	
	public class HexMapView implements ILoomManager
	{
		private static const SQRT3:Number = Math.sqrt(3);
		private static const N3D2:Number = 3/2;
		
		private var _viewComponent:Sprite;
		private var _children:Vector.<HexRenderer>;
		private var _hexSize:int = 0;
		
		public function get viewComponent():DisplayObject { return _viewComponent; }
		
		public function get hexSize():int { return _hexSize; }
		
		public function set hexSize( value:int ):void
		{
			_hexSize = value;
			updateChildPositions();
		}
		
		public function initialize():void
		{
			_viewComponent = new Sprite();
			_children = [];
			if ( hexSize == 0 ) hexSize = 64;
		}
		
		public function destroy():void
		{
		}
		
		public function addChild( child:HexRenderer ):void
		{
			if ( _children.indexOf( child ) == -1 )
			{
				_children.push( child );
				_viewComponent.addChild( child.viewComponent );
				child.updatePosition();
			}
		}
		
		public function removeChild( child:HexRenderer ):void
		{
			var childIndex:int = _children.indexOf( child );
			if ( childIndex > -1 )
			{
				_children.splice( childIndex, 1 );
				_viewComponent.removeChild( child.viewComponent );
			}
		}
		
		public function project( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var result:Point3 = modifyOriginal ? position : new Point3();
			var resultX = _hexSize * N3D2 * position.x;
			var resultY = _hexSize * 0.5 * SQRT3 * (position.y + position.x * 0.5 + position.z);
			result.setTo( resultX, resultY, position.z );
			return result;
		}
		
		public function unproject( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var result:Point3 = modifyOriginal ? position : new Point3();
			return result;
		}
		
		private function updateChildPositions():void
		{
			var numChildren:int = _children.length;
			for ( var i:int = 0; i < numChildren; i++ ) _children[ i ].updatePosition();
		}
	}
}