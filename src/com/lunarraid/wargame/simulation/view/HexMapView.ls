package com.lunarraid.wargame.simulation.view
{
	import Loom2D.Display.DisplayObject;
	import Loom2D.Display.Sprite;
	import Loom2D.Math.Point;
	
	import System.Math;
	
	import Loom.GameFramework.ILoomManager;
	
	public class HexMapView implements ILoomManager
	{
		private static const SQRT3:Number = Math.sqrt(3);
		private static const N3D2:Number = 3/2;
		
		private var _viewComponent:Sprite;
		private var _children:Vector.<HexRenderer>;
		private var _hexSize:int;
		
		public function get viewComponent():DisplayObject { return _viewComponent; }
		
		public function initialize():void
		{
			_viewComponent = new Sprite();
			_children = [];
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
		
		public function project( position:Point, modifyOriginal:Boolean=true ):Point
		{
			var result:Point = modifyOriginal ? position : new Point();
			result.x = position.x * _hexSize * N3D2; 
			result.y = position.y * _hexSize * SQRT3 * 0.75;
			return result;
		}
		
		public function unproject( position:Point, modifyOriginal:Boolean=true ):Point
		{
			var result:Point = modifyOriginal ? position : new Point();
			result.x = result.x / _hexSize / N3D2;
			result.y = result.y / _hexSize / SQRT3 / 0.75;
			return result;
		}
	}
}