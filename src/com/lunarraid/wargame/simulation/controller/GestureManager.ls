package com.lunarraid.wargame.simulation.controller
{
    import system.platform.Platform;
    
    import loom.gameframework.ILoomManager;
    
    import loom2d.Loom2D;
    
    import loom2d.display.DisplayObject;
    import loom2d.math.Point;
    
    import org.gestouch.core.Gestouch;
    
    import org.gestouch.events.GestureEvent;
    import org.gestouch.gestures.ZoomGesture;
    import org.gestouch.gestures.PanGesture;
    import org.gestouch.gestures.RotateGesture;
    
    import loom2d.animation.Tween;
    import loom2d.animation.Transitions;
    
    public class GestureManager implements ILoomManager
    {
        private static const PAN_THRESHOLD_MS:int = 33;
        
        private var _panGesture:PanGesture;
        private var _target:DisplayObject;
        
        private var _lastPanMS:int;
        private var _panDeltaTime:int;
        private var _lastPanDistance:Point;
        private var _panVelocity:Point;
        
        public function GestureManager( target:DisplayObject = null )
        {
            trace( "ADDING PAN GESTURE TO " + target.toString() );
            
            _target = target;
            _panGesture = new PanGesture( _target );
            _panGesture.maxNumTouchesRequired = 1;
            _panGesture.addEventListener( GestureEvent.GESTURE_BEGAN, onPanStart );
            _panGesture.addEventListener( GestureEvent.GESTURE_CHANGED, onPan );
            _panGesture.addEventListener( GestureEvent.GESTURE_ENDED, onPanEnd );
        }
        
        public function set target( value:DisplayObject ):void
        {
            _target = value;
            _panGesture.target = value;
        }
        
        public function get target():DisplayObject { return _target; }

        public function initialize():void
        {
        }
            
        public function destroy():void
        {
        }

        private function onPanStart( e:GestureEvent ):void
        {
            Loom2D.juggler.removeTweens( _target );
            _panDeltaTime = 0;
            _panVelocity.x = 0;
            _panVelocity.y = 0;
            _lastPanMS = Platform.getTime();
        }
        
        private function onPan( e:GestureEvent ):void
        {
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
            
            _target.x += pan.offsetX;
            _target.y += pan.offsetY;
            
            _lastPanMS = currentTime;
        }
        
        private function onPanEnd( e:GestureEvent ):void
        {
            var tweenTime:Number = Math.log( 0.8 ) * ( 1000 / _panVelocity.length );
            
            var tween:Tween = new Tween( _target, tweenTime, Transitions.EASE_OUT );
            tween.animate( "x", _target.x + _panVelocity.x * 10 );
            tween.animate( "y", _target.y + _panVelocity.y * 10 );
            Loom2D.juggler.add(tween);            
        }
    }
}