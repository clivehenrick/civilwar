package com.lunarraid.wargame.simulation.controller
{
    import loom.gameframework.ILoomManager;
    import loom.gameframework.LoomGameObject;
    
    public class MapStateManager implements ILoomManager
    {
        private var _tiles:Dictionary.<int, LoomGameObject> = {};
        
        public function initialize():void
        {
        }
        
        public function destroy():void
        {
        }
        
        private static function getHashId( x:int, y:int ):int
        {
            return ( x << 16 & 0xFFFF0000 ) | ( y & 0x0000FFFF );
        } 
    }
}