package com.lunarraid.wargame.view.projection
{
	import com.lunarraid.wargame.math.Point3;
	
	public class IsoProjection implements IProjection
	{
		//--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------
		
		private static var _scratchPoint:Point3;
		
		private var _tileWidth:int;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function IsoProjection() { tileWidth = 128; }
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		public function set tileWidth( value:int ):void { _tileWidth = value; }		
		public function get tileWidth():int { return _tileWidth; }
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		public function project( position:Point3 ):Point3
		{
			_scratchPoint.x = ( position.x - position.y ) * _tileWidth * 0.5;
			_scratchPoint.y = ( position.x + position.y + position.z + position.z ) * _tileWidth * 0.25;
			_scratchPoint.z = _scratchPoint.y - position.z * _tileWidth * 0.5;
			return _scratchPoint;
		}
		
		public function unproject( position:Point3 ):Point3
		{
			_scratchPoint.z = ( position.y - position.z ) / ( _tileWidth * 0.5 );
			_scratchPoint.x = ( position.z + position.z + position.x ) / _tileWidth;
			_scratchPoint.y = ( position.z + position.z - position.x ) / _tileWidth;
			return _scratchPoint;
		}
	}
}