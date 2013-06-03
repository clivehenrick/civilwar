package com.lunarraid.wargame.simulation.view.projection
{
	import com.lunarraid.wargame.simulation.math.Point3;
	
	public class IsoProjection implements IProjection
	{
		//--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------
		
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
		
		public function project( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var result:Point3 = modifyOriginal ? position : new Point3();
			var resultX:Number = ( position.x - position.y ) * _tileWidth * 0.5;
			var resultY:Number = ( position.x + position.y + position.z + position.z ) * _tileWidth * 0.25;
			var resultZ:Number = resultY - position.z * _tileWidth * 0.5;
			result.setTo( resultX, resultY, resultZ );
			return result;
		}
		
		public function unproject( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var result:Point3 = modifyOriginal ? position : new Point3();
			var resultZ:Number = ( position.y - position.z ) / ( _tileWidth * 0.5 );
			var resultX:Number = ( position.z + position.z + position.x ) / _tileWidth;
			var resultY:Number = ( position.z + position.z - position.x ) / _tileWidth;
			result.setTo( resultX, resultY, resultZ );
			return result;
		}
	}
}