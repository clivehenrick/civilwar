package com.lunarraid.wargame.view
{
	import loom2d.display.DisplayObject;
	import loom.gameframework.AnimatedComponent;
	import com.lunarraid.wargame.math.Point3;
	
	public class ProjectedViewRenderer
	{
        //--------------------------------------
        // PUBLIC
        //--------------------------------------
		
		public var viewManager:ProjectedViewManager;
		
		//--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------

		protected var _viewComponent:DisplayObject;
		protected var _position:Point3 = new Point3();
		protected var _scratchPoint:Point3 = new Point3();
		
        //--------------------------------------
        //  CONSTRUCTOR
        //--------------------------------------
        
        public function ProjectedViewRenderer()
        {
            _viewComponent = createDisplayObject();
        }
        
        //--------------------------------------
        //  GETTER/SETTERS
        //--------------------------------------
        
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
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		public function dispose():void
		{
			if ( viewManager ) viewManager.removeChild( this );
			if ( _viewComponent ) _viewComponent.dispose();
			_viewComponent = null;
		}
		
		public function updatePosition():void
		{
			if ( !viewManager ) return;
			_scratchPoint = viewManager.project( _position );
			_viewComponent.x = _scratchPoint.x;
			_viewComponent.y = _scratchPoint.y;
			_viewComponent.depth = _scratchPoint.z * 100 - _position.z;
		}
		
		//--------------------------------------
		//  PRIVATE / PROTECTED METHODS
		//--------------------------------------
		
		protected function createDisplayObject():DisplayObject
		{
			// OVERRIDE THIS IN SUBCLASSES
			return null;
		}
		
	}
}