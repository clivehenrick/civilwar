package com.lunarraid.wargame.simulation.spatial
{
    import loom.gameframework.TickedComponent;
    import com.lunarraid.wargame.simulation.math.Point3;
    
    public class SpatialComponent3D extends TickedComponent
    {
		[Inject]
		public var spatialManager:BasicSpatialManager3D;
        
        public var velocity:Point3 = new Point3();
		public var angularVelocity:Number = 0;
		
		protected var _position:Point3 = new Point3();
		protected var _positionCache:Point3 = new Point3();
		protected var _rotation:Number = 0;
		protected var _size:Point3 = new Point3(64, 64, 64);
    	
        public function get position():Point3
        {
        	_positionCache.copyFrom( _position );
            return _positionCache;
        }
        
        public function set position( value:Point3 ):void
        {
        	_position.copyFrom( value );
        }
		
        public function set x(value:Number):void { _position.x = value; }
        public function get x():Number { return _position.x; }
        
        public function set y(value:Number):void { _position.y = value; }
        public function get y():Number { return _position.y; }

        public function set z(value:Number):void { _position.z = value; }
        public function get z():Number { return _position.z; }

        public function get rotation():Number { return _rotation; }
        
        public function set rotation(value:Number):void
        {
            _rotation = value;
			if (_rotation < 0 || _rotation > 359)
			{
				_rotation = _rotation % 360;
				if (_rotation < 0) _rotation += 360;
			}
        }	  
        
        
        override public function onTick():void
        {
        	super.onTick();
        	
            //_position.x += velocity.x * tickRate;
            //_position.y += velocity.y * tickRate;
            //_position.z += velocity.z * tickRate;
            //rotation += angularVelocity * tickRate;
        }
        
        override protected function onAdd():Boolean
        {
            super.onAdd();
			spatialManager.addSpatialObject( this );
			return true;
        }
        
        override protected function onRemove():void
        {
			spatialManager.removeSpatialObject( this );
            super.onRemove();
        }
        
        private static function clamp(v:Number, min:Number = 0, max:Number = 1):Number
        {
            if(v < min) return min;
            if(v > max) return max;
            return v;
        }        
    }
}
