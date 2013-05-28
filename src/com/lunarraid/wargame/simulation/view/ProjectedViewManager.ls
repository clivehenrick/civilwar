package com.lunarraid.wargame.simulation.view
{
	import Loom2D.Display.DisplayObject;
	import Loom2D.Display.Sprite;
	import Loom2D.Events.EnterFrameEvent;
	import Loom2D.Math.Point;
	import System.Math;
	import com.lunarraid.wargame.simulation.math.Point3;
	import Loom.GameFramework.ILoomManager;
	import com.lunarraid.wargame.simulation.view.projection.*;
	
	public class ProjectedViewManager implements ILoomManager
	{
		private var _viewComponent:Sprite;
		private var _children:Vector.<ProjectedViewRenderComponent>;
		private var _projection:IProjection; 
		
		public function get viewComponent():DisplayObject { return _viewComponent; }
		
		public function get tileSize():int { return _projection.tileSize; }
		
		public function set tileSize( value:int ):void
		{
			_projection.tileSize = value;
			updateChildPositions();
		}
		
		public function initialize():void
		{
			if ( _projection == null ) _projection = new HexProjection();
			_viewComponent = new Sprite();
			_viewComponent.addEventListener( EnterFrameEvent.ENTER_FRAME, onFrame );
			_children = [];
		}
		
		public function destroy():void
		{
			_viewComponent.removeEventListener( EnterFrameEvent.ENTER_FRAME, onFrame );
		}
		
		public function addChild( child:ProjectedViewRenderComponent ):void
		{
			if ( _children.indexOf( child ) == -1 )
			{
				_children.push( child );
				_viewComponent.addChild( child.viewComponent );
				child.updatePosition();
			}
		}
		
		public function removeChild( child:ProjectedViewRenderComponent ):void
		{
			var childIndex:int = _children.indexOf( child );
			if ( childIndex > -1 )
			{
				_children.splice( childIndex, 1 );
				_viewComponent.removeChild( child.viewComponent );
			}
		}
		
		public function project( position:Point3, modifyOriginal:Boolean=true ):Point3 { return _projection.project( position, modifyOriginal ); }
		public function unproject( position:Point3, modifyOriginal:Boolean=true ):Point3 { return _projection.unproject( position, modifyOriginal ); }
		
		private function onFrame( e:EnterFrameEvent ):void
		{
			//_children.sort( ySort );
			//for each ( var child:ProjectedViewRenderComponent in _children ) _viewComponent.addChild( child.viewComponent );
		}
		
		private function ySort( a:ProjectedViewRenderComponent, b:ProjectedViewRenderComponent ):int
		{
			return a.viewComponent.y - b.viewComponent.y;
		}
		
		private function updateChildPositions():void
		{
			var numChildren:int = _children.length;
			for ( var i:int = 0; i < numChildren; i++ ) _children[ i ].updatePosition();
		}
	}
}