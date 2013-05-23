package com.lunarraid.wargame.simulation.math
{
    public class Point3 
    {
        public var x:Number;
        public var y:Number;
        public var z:Number;

        public function Point3(x:Number = 0, y:Number = 0, z:Number = 0)
        {
        	setTo( x, y, z );
        }

        public function setTo(x:Number, y:Number, z:Number):void
        {
            this.x = x;
            this.y = y;
            this.z = z;
        }
        
        public function clone():Point3
        {
        	return new Point3( x, y, z );
        }
        
        public function copyFrom( source:Point3 ):void
        {
        	setTo( source.x, source.y, source.z );
        }
    }   
}