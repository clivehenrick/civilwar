package com.lunarraid.wargame.view
{
	import loom2d.display.DisplayObject;
	import loom2d.display.Sprite;
	import loom2d.events.EnterFrameEvent;
	
	import loom2d.math.Point;

	import com.lunarraid.wargame.math.Point3;
	
	import com.lunarraid.wargame.view.projection.*;
	
	public class ProjectedViewManager
	{
        //--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------
		
		private var _viewComponent:Sprite;
		private var _children:Vector.<ProjectedViewRenderer>;
		private var _projection:IProjection;
		private var _depthSort:Boolean = true;
		
        //--------------------------------------
        //  CONSTRUCTOR
        //--------------------------------------
        
        public function ProjectedViewManager( projection:IProjection = null )
        {
            _projection = new OverheadHexProjection();
            _viewComponent = new Sprite();
            _viewComponent.depthSort = _depthSort;
            _children = [];
        }
        
        //--------------------------------------
        //  GETTERS / SETTERS
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
		
		public function get depthSort():Boolean { return _depthSort; }
		
		public function set depthSort( value:Boolean ):void
		{
            _depthSort = value;
            if ( _viewComponent ) _viewComponent.depthSort = value;
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		public function destroy():void
		{
			_viewComponent.removeChildren();
			_children.length = 0;
			_viewComponent.dispose();
			_viewComponent = null;
		}
		
		public function addChild( child:ProjectedViewRenderer ):void
		{
			if ( _children.indexOf( child ) == -1 )
			{
				_children.push( child );
				_viewComponent.addChild( child.viewComponent );
				child.viewManager = this;
				child.updatePosition();
			}
		}
		
		public function removeChild( child:ProjectedViewRenderer ):void
		{
			var childIndex:int = _children.indexOf( child );
			if ( childIndex > -1 )
			{
				child.viewManager = null;
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