package com.lunarraid.wargame.simulation.view
{
	import loom2d.display.DisplayObject;
	import loom2d.display.Sprite;
	import loom2d.events.EnterFrameEvent;
	import loom2d.math.Point;
	import system.Math;
	import com.lunarraid.wargame.simulation.math.Point3;
	import loom.gameframework.ILoomManager;
	import loom.gameframework.IAnimated;
	import loom.gameframework.TimeManager;
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