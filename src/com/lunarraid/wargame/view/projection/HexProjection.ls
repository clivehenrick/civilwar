package com.lunarraid.wargame.view.projection
{
	import com.lunarraid.wargame.math.Point3;
	
	public class HexProjection implements IProjection
	{
		//--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------
		
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
		
		public function project( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var resultX:Number = position.x * _projectXMultiplier;
			var resultY:Number = ( position.x * 0.5 + position.y + position.z ) * _projectYMultiplier;
			var resultZ:Number = resultY - position.z * _projectYMultiplier; 
			var result:Point3 = modifyOriginal ? position : new Point3();
			result.setTo( resultX, resultY, resultZ );
			return result;
		}
		
		public function unproject( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var resultX:Number = position.x * _unprojectXMultiplier;
			var resultZ:Number = ( position.y - position.z ) * _unprojectYMultiplier;
			var resultY:Number = ( position.y * _unprojectYMultiplier ) - ( resultX * 0.5 ) - resultZ;
			var result:Point3 = modifyOriginal ? position : new Point3();
			result.setTo( resultX, resultY, resultZ );
			return result;
		}
		
		function roundCoordinates( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			Debug.assert( false, "NOT YET IMPLEMENTED" );
			return null;
		}
	}
}