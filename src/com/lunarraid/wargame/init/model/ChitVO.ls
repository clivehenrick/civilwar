package com.lunarraid.wargame.model
{
    public class ChitVO
    {
        public var name:String;
        public var commander:String;
        public var experience:int;
        public var health:Number;
        public var morale:Number;
        
        public static function createFromData( data:Dictionary.<String, Object> ):ChitVO
        {
            var result:ChitVO = new ChitVO();
            result.name = data[ "name" ] as String;
            result.commander = data[ "commander" ] as String;
            result.experience = data[ "experience" ] as int;
            result.health = data[ "health" ] as Number;
            result.morale = data[ "morale" ] as Number;
            return result;
        }
    }
}