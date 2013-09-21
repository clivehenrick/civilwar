package com.lunarraid.wargame.view.projection
{
	import com.lunarraid.wargame.math.Point3;
	
	public class OverheadHexProjection implements IProjection
	{
		//--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------
		
		private static var _scratchPoint:Point3;
		
		private var _tileWidth:int;
		
		// PROJECTION PRECALCULATION
		
		private var _projectXMultiplier:Number;
		private var _projectYMultiplier:Number;
		private var _unprojectXMultiplier:Number;
		private var _unprojectYMultiplier:Number;
	
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function OverheadHexProjection() { tileWidth = 256; }
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		public function set tileWidth( value:int ):void
		{
			_tileWidth = value;
			_projectXMultiplier = _tileWidth * 3/4;
			_projectYMultiplier = _tileWidth * Math.sqrt(3) * 0.5;
			_unprojectXMultiplier = 1 / _projectXMultiplier;
			_unprojectYMultiplier = 1 / _projectYMultiplier;
		}
		
		public function get tileWidth():int { return _tileWidth; }
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		public function project( position:Point3 ):Point3
		{
			_scratchPoint.x = position.x * _projectXMultiplier;
			_scratchPoint.y = ( position.x * 0.5 + position.y ) * _projectYMultiplier;
			_scratchPoint.z = position.z;
			return _scratchPoint;
		}
		
		public function unproject( position:Point3 ):Point3
		{
			_scratchPoint.x = position.x * _unprojectXMultiplier;
			_scratchPoint.y = ( position.y * _unprojectYMultiplier ) - ( _scratchPoint.x * 0.5 );
			_scratchPoint.z = position.z;
			return _scratchPoint;
		}
		
		/*  Save this for later -- <rcook 9/21/2013>
		public function roundCoordinates( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			_scratchPoint.x = Math.round( position.x );
			_scratchPoint.y = Math.round( position.y );
			_scratchPoint.z = Math.round( -position.x - position.y );
		
		    var xErr:Number = Math.abs( _scratchPoint.x - position.x );
		    var yErr:Number = Math.abs( _scratchPoint.y - position.y );
		    var zErr:Number = Math.abs( _scratchPoint.z + position.x + position.y );
		
		    if ( xErr > yErr && xErr > zErr ) _scratchPoint.x = -_scratchPoint.y - _scratchPoint.z;
		    else if ( yErr > zErr ) _scratchPoint.y = -_scratchPoint.x - _scratchPoint.z;
		    else _scratchPoint.z = -_scratchPoint.x - _scratchPoint.y;
		
		    return _scratchPoint;			
		}
		*/
	}
}