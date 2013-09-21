package com.lunarraid.wargame.view.projection
{
	import com.lunarraid.wargame.math.Point3;
	
	public class HexProjection implements IProjection
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
		
		public function HexProjection() { tileWidth = 256; }
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		public function set tileWidth( value:int ):void
		{
			_tileWidth = value;
			_projectXMultiplier = _tileWidth * 3/4;
			_projectYMultiplier = _tileWidth * Math.sqrt(3) * 0.25;
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
			_scratchPoint.y = ( position.x * 0.5 + position.y + position.z ) * _projectYMultiplier;
			_scratchPoint.z = _scratchPoint.y - position.z * _projectYMultiplier; 
			return _scratchPoint;
		}
		
		public function unproject( position:Point3 ):Point3
		{
			_scratchPoint.x = position.x * _unprojectXMultiplier;
			_scratchPoint.y = ( position.y - position.z ) * _unprojectYMultiplier;
			_scratchPoint.z = ( position.y * _unprojectYMultiplier ) - ( _scratchPoint.x * 0.5 ) - _scratchPoint.z;
			return _scratchPoint;
		}
	}
}