package com.lunarraid.wargame.view
{
    import system.platform.Platform;
    
    import loom2d.Loom2D;
    
    import loom2d.display.DisplayObject;
    import loom2d.math.Point;
    import loom2d.math.Matrix;
    
    import org.gestouch.core.Gestouch;
    
    import org.gestouch.events.GestureEvent;
    import org.gestouch.gestures.ZoomGesture;
    import org.gestouch.gestures.PanGesture;
    import org.gestouch.gestures.TapGesture;
    import org.gestouch.gestures.RotateGesture;
    
    import loom2d.animation.Tween;
    import loom2d.animation.Transitions;
    
    public class GestureManager
    {
        private static const PAN_THRESHOLD_MS:int = 33;
        
        private var _panGesture:PanGesture;
        private var _tapGesture:TapGesture;
        private var _touchTarget:DisplayObject;
        private var _motionTarget:DisplayObject;
        
        private var _onTap:Function;
        
        private var _lastPanMS:int;
        private var _panDeltaTime:int;
        private var _lastPanDistance:Point;
        private var _panVelocity:Point;
        
        public function GestureManager()
        {
            _panGesture = new PanGesture();
            _panGesture.maxNumTouchesRequired = 1;
            _panGesture.addEventListener( GestureEvent.GESTURE_BEGAN, onPanStart );
            _panGesture.addEventListener( GestureEvent.GESTURE_CHANGED, onPan );
            _panGesture.addEventListener( GestureEvent.GESTURE_ENDED, onPanEnd );
            
            _tapGesture = new TapGesture();
            _tapGesture.numTapsRequired = 1;
            _tapGesture.addEventListener( GestureEvent.GESTURE_RECOGNIZED, onTargetTap );            
        }
        
        public function get onTap():Function { return _onTap; }
        
        public function set onTap( value:Function ):void { _onTap = value; }
        
        public function get touchTarget():DisplayObject { return _touchTarget; }
        
        public function set touchTarget( value:DisplayObject ):void
        {
            _touchTarget = value;
            _panGesture.target = value;
            _tapGesture.target = value;
        }
        
        public function get motionTarget():DisplayObject { return _motionTarget; }

        public function set motionTarget( value:DisplayObject ):void
        {
            if ( _motionTarget ) Loom2D.juggler.removeTweens( _motionTarget );
            _motionTarget = value;
        }
        
        private function onPanStart( e:GestureEvent ):void
        {
            Loom2D.juggler.removeTweens( _motionTarget );
            _panDeltaTime = 0;
            _panVelocity.x = 0;
            _panVelocity.y = 0;
            _lastPanMS = Platform.getTime();
        }
        
        private function onPan( e:GestureEvent ):void
        {
            if ( !_motionTarget ) return;
            
            var pan:PanGesture = e.target as PanGesture;
            
            var currentTime:int = Platform.getTime(); 
            _panDeltaTime += ( currentTime - _lastPanMS );
            
            _lastPanDistance.x += pan.offsetX;
            _lastPanDistance.y += pan.offsetY;
            
            if ( _panDeltaTime > PAN_THRESHOLD_MS )
            {
                _panVelocity.x = _lastPanDistance.x;
                _panVelocity.y = _lastPanDistance.y;
                _lastPanDistance.x = 0;
                _lastPanDistance.y = 0;
                _panDeltaTime = 0;
            }
            
            _motionTarget.x = Math.round( _motionTarget.x + pan.offsetX );
            _motionTarget.y = Math.round( _motionTarget.y + pan.offsetY );
            
            _lastPanMS = currentTime;
        }
        
        private function onPanEnd( e:GestureEvent ):void
        {
            return; // for now, fix inertial scroll later
                       
            if ( !_motionTarget ) return;
            
            var tween:Tween = new Tween( _motionTarget, 1.0, Transitions.EASE_OUT );
            tween.animate( "x", _motionTarget.x + _panVelocity.x * 10 );
            tween.animate( "y", _motionTarget.y + _panVelocity.y * 10 );
            Loom2D.juggler.add(tween);            
        }
        
        private function onTargetTap( e:GestureEvent ):void
        {
            var matrix:Matrix = new Matrix();
            Loom2D.stage.getTargetTransformationMatrix( motionTarget, matrix );
            //motionTarget.getTargetTransformationMatrix( Loom2D.stage, matrix );
            trace( "MATRIX: " + matrix );
            var location:Point = TapGesture( e.target ).location;
            location = matrix.transformCoord( location.x, location.y );
            if ( _onTap ) _onTap( location );
        }
    }
}