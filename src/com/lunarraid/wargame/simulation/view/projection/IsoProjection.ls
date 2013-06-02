package com.lunarraid.wargame.simulation.view.projection
{
	import com.lunarraid.wargame.simulation.math.Point3;
	
	public class IsoProjection implements IProjection
	{
		private var _tileSize:int;
		
		public function IsoProjection() { tileSize = 64; }
		
		public function set tileSize( value:int ):void
		{ 
			_tileSize = value;
		}
		
		public function get tileSize():int { return _tileSize; }
		
		public function project( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var result:Point3 = modifyOriginal ? position : new Point3();
			var resultX:Number = ( position.x - position.y ) * _tileSize * 0.5;
			var resultY:Number = ( position.x + position.y + position.z + position.z ) * _tileSize * 0.25;
			var resultZ:Number = resultY - position.z * _tileSize * 0.5;
			result.setTo( resultX, resultY, resultZ );
			return result;
		}
		
		public function unproject( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var result:Point3 = modifyOriginal ? position : new Point3();
			var resultZ:Number = ( position.y - position.z ) / ( _tileSize * 0.5 );
			var resultX:Number = ( position.z * 2 + position.x ) / _tileSize;
			var resultY:Number = ( position.z * 2 - position.x ) / _tileSize;
			result.setTo( resultX, resultY, resultZ );
			return result;
		}
	}
}