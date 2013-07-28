package com.lunarraid.wargame.simulation.spatial
{
    import loom.gameframework.ILoomManager;
    import com.lunarraid.wargame.simulation.math.Point3;
    
    public class BasicSpatialManager3D implements ILoomManager
    {
      protected var _objectList:Vector.<SpatialComponent3D> = [];
      
      public function initialize() {}
            
      public function destroy() {}
            
      public function addSpatialObject( object:SpatialComponent3D ):void
      {
         var index:int = _objectList.indexOf( object );
         if ( index == -1 ) _objectList.push( object );
      }
      
      public function removeSpatialObject(object:SpatialComponent3D):void
      {
         var index:int = _objectList.indexOf( object );
         if (index == -1) return;
         _objectList.splice(index, 1);
      }
    }
    
}