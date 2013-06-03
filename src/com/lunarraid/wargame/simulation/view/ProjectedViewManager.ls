package com.lunarraid.wargame.simulation.view
{
	import Loom2D.Display.DisplayObject;
	import Loom2D.Display.Sprite;
	import Loom2D.Events.EnterFrameEvent;
	import Loom2D.Math.Point;
	import System.Math;
	import com.lunarraid.wargame.simulation.math.Point3;
	import Loom.GameFramework.ILoomManager;
	import Loom.GameFramework.IAnimated;
	import Loom.GameFramework.TimeManager;
	import com.lunarraid.wargame.simulation.view.projection.*;
	
	public class ProjectedViewManager implements ILoomManager
	{
		//--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------
		
		private var _viewComponent:Sprite;
		private var _children:Vector.<ProjectedViewRenderComponent>;
		private var _projection:IProjection;
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		public function get viewComponent():DisplayObject { return _viewComponent; }
		
		public function get projection():IProjection { return _projection; }
		public function set projection( value:IProjection ):void { _projection = value; }
		
		public function get tileWidth():int { return _projection.tileWidth; }
		
		public function set tileWidth( value:int ):void
		{
			_projection.tileWidth = value;
			updateChildPositions();
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		public function initialize():void
		{
			if ( _projection == null ) _projection = new HexProjection();
			_viewComponent = new Sprite();
			_viewComponent.depthSort = true;
			_children = [];
		}
		
		public function destroy():void
		{
			_viewComponent.removeChildren();
			_children.length = 0;
			_viewComponent.dispose();
			_viewComponent = null;
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
		
		//--------------------------------------
		//  PRIVATE / PROTECTED METHODS
		//--------------------------------------
		
		private function updateChildPositions():void
		{
			var numChildren:int = _children.length;
			for ( var i:int = 0; i < numChildren; i++ ) _children[ i ].updatePosition();
		}
	}
}