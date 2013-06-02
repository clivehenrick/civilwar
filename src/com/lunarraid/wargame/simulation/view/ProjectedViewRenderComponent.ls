package com.lunarraid.wargame.simulation.view
{
	import Loom2D.Display.DisplayObject;
	import Loom.GameFramework.AnimatedComponent;
	import com.lunarraid.wargame.simulation.math.Point3;
	
	public class ProjectedViewRenderComponent extends AnimatedComponent
	{
		//--------------------------------------
		// INJECTIONS
		//--------------------------------------
		
		[Inject]
		public var viewManager:ProjectedViewManager;
		
		//--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------

		protected var _viewComponent:DisplayObject;
		protected var _position:Point3 = new Point3();
		protected var _scratchPoint:Point3 = new Point3();
		protected var _isDirty:Boolean = false;
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		public function get viewComponent():DisplayObject { return _viewComponent; }
		
		public function get x():Number { return _position.x; }
		
		public function set x( value:Number ):void
		{
			if ( _position.x == value ) return;
			_position.x = value;
			_isDirty = true;
		}
		
		public function get y():Number { return _position.y; }

		public function set y( value:Number ):void
		{
			if ( _position.y == value ) return;
			_position.y = value;
			_isDirty = true;
		}

		public function get z():Number { return _position.z; }
		
		public function set z( value:Number ):void
		{
			if ( _position.z == value ) return;
			_position.z = value;
			_isDirty = true;
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		override public function onAdd():Boolean
		{
			super.onAdd();
			_viewComponent = createDisplayObject();
        	updatePosition();
        	viewManager.addChild( this );
        	return true;
		}
		
		override public function onRemove():void
		{
			viewManager.removeChild( this );
			if ( _viewComponent ) _viewComponent.dispose();
			_viewComponent = null;
			super.onRemove();
		}
		
		override public function onFrame():void
		{
			super.onFrame();
			if ( _isDirty ) updatePosition();
		}
		
		public function updatePosition():void
		{
			if ( !viewManager ) return;
			_scratchPoint.copyFrom( _position );
			viewManager.project( _scratchPoint );
			_viewComponent.x = _scratchPoint.x;
			_viewComponent.y = _scratchPoint.y;
			_viewComponent.depth = _scratchPoint.z * 100 - _position.z;
			_isDirty = false;
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