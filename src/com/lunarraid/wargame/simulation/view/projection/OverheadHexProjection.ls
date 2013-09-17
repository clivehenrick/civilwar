package com.lunarraid.wargame.simulation.view.projection
{
	import com.lunarraid.wargame.simulation.math.Point3;
	
	public class OverheadHexProjection implements IProjection
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
		
		public function project( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var resultX:Number = position.x * _projectXMultiplier;
			var resultY:Number = ( position.x * 0.5 + position.y ) * _projectYMultiplier;
			var result:Point3 = modifyOriginal ? position : new Point3();
			result.setTo( resultX, resultY, position.z );
			return result;
		}
		
		public function unproject( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var resultX:Number = position.x * _unprojectXMultiplier;
			var resultY:Number = ( position.y * _unprojectYMultiplier ) - ( resultX * 0.5 );
			var result:Point3 = modifyOriginal ? position : new Point3();
			result.setTo( resultX, resultY, position.z );
			return result;
		}
		
		public function roundCoordinates( position:Point3, modifyOriginal:Boolean=true ):Point3
		{
			var resultX:int = Math.round( position.x );
			var resultY:int = Math.round( position.y );
			var resultZ:int = Math.round( -position.x - position.y );
		
		    var xErr:Number = Math.abs( resultX - position.x );
		    var yErr:Number = Math.abs( resultY - position.y );
		    var zErr:Number = Math.abs( resultZ + position.x + position.y );
		
		    if ( xErr > yErr && xErr > zErr ) resultX = -resultY - resultZ;
		    else if ( yErr > zErr ) resultY = -resultX - resultZ;
		    else resultZ = -resultX - resultY;
		
			var result:Point3 = modifyOriginal ? position : new Point3();
			result.setTo( resultX, resultY, position.z );
			
		    return result;			
		}
	}
}