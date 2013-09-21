package com.lunarraid.wargame.model
{
    public class MapTerrainVO
    {
        public var type:String;
        public var assetId:String;
        public var traversable:Boolean;
        public var modifiers:Dictionary.<String, Number>;
        
        public static function createFromData( data:Dictionary.<String, Object> ):MapTerrainVO
        {
            var result:MapTerrainVO = new MapTerrainVO();
            result.type = data[ "type" ] as String;
            result.assetId = data[ "assetId" ] as String;
            result.traversable = data[ "traversable" ] as Boolean;
            result.modifiers = data[ "modifiers" ] as Dictionary.<String, Number>;
            return result;
        }
    }
}