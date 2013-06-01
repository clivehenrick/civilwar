package com.lunarraid.wargame.simulation.view.projection
{
	import com.lunarraid.wargame.simulation.math.Point3;
	
	public class HexProjection implements IProjection
	{
		private static const HALF_SQRT3:Number = Math.sqrt(3) / 2;
		private static const N3D2:Number = 3/2;
		
		private var _tileSize:int;
		
		// PROJECTION PRECALCULATION
		
		private var _projectXMultiplier:Number;
		private var _projectYMultiplier:Number;
		private var _unprojectXMultiplier:Number;
		private var _unprojectYMultiplier:Number;
	
		public function HexProjection() { tileSize = 64; }
		
		public function set tileSize( value:int ):void
		{ 
			_tileSize = value;
			_projectXMultiplier = _tileSize * N3D2;
			_projectYMultiplier = _tileSize * HALF_SQRT3;
			_unprojectXMultiplier = 1 / ( N3D2 * _tileSize );
			_unprojectYMultiplier = 1 / _projectYMultiplier;
		}
		
		public function get tileSize():int { return _tileSize; }
		
		public function project( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var result:Point3 = modifyOriginal ? position : new Point3();
			var resultX:Number = position.x * _projectXMultiplier;
			var resultY:Number = ( position.x * 0.5 + position.y + position.z ) * _projectYMultiplier;
			var resultZ:Number = resultY - position.z * _projectYMultiplier; 
			result.setTo( resultX, resultY, resultZ );
			return result;
		}
		
		public function unproject( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var result:Point3 = modifyOriginal ? position : new Point3();
			var resultX:Number = position.x * _unprojectXMultiplier;
			var resultZ:Number = ( position.y - position.z ) * _unprojectYMultiplier;
			var resultY:Number = ( position.y * _unprojectYMultiplier ) - ( resultX * 0.5 ) - resultZ;
			result.setTo( resultX, resultY, resultZ );
			return result;
		}
	}
}