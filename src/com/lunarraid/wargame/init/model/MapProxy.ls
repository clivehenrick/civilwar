package com.lunarraid.wargame.model
{
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    public class MapProxy extends Proxy
    {
        //--------------------------------------
        // CLASS CONSTANTS
        //--------------------------------------
        
        public static const NAME:String = "MapProxy";
        
        private static const MAP_WIDTH:int = 20;
        private static const MAP_HEIGHT:int = 20;
        
        private static const TILE_DATA:Vector.<Dictionary.<String, Object>> =
        [
            { "type" : "plains", "assetId" : "plains", "traversable" : true,  "modifiers" : {} }, 
            { "type" : "forest", "assetId" : "forest", "traversable" : true,  "modifiers" : {} }, 
            { "type" : "river",  "assetId" : "water",  "traversable" : false, "modifiers" : {} } 
        ];
        
        //--------------------------------------
        // PRIVATE / PROTECTED
        //--------------------------------------

        private var _tileTypes:Dictionary.<String, MapTerrainVO>;
        private var _tileMap:Dictionary.<int, MapHexTileVO>;
        
        //--------------------------------------
        // CONSTRUCTOR
        //--------------------------------------
        
        public function MapProxy()
        {
            super( NAME );
        }
        
        //--------------------------------------
        //  GETTERS / SETTERS
        //--------------------------------------
        
        public function get tileMap():Dictionary.<int, MapHexTileVO> { return _tileMap; }
        
        //--------------------------------------
        //  PUBLIC METHODS
        //--------------------------------------
        
        public static function getHash( x:int, y:int ):int
        {
            return ( ( x < 0 ? ( ( -x & 0x7FFF ) | 0x8000 ) : ( x & 0x7FFF ) ) << 16 ) | ( y < 0 ? ( ( -y & 0x7FFF ) | 0x8000 ) : ( y & 0x7FFF ) ); 
        }
         
        override public function onRegister():void
        {
            super.onRegister();
            loadTileTypes();
            loadMap();
        }
        
        override public function onRemove():void
        {
            super.onRemove();
        }
        
        public function loadMap():void
        {
            _tileMap = {};
            
            var startX:int = Math.floor( -MAP_WIDTH / 2 );
            var endX:int = Math.floor( MAP_WIDTH / 2 );
            var startY:int = Math.floor( -MAP_HEIGHT / 2 );
            var endY:int = Math.floor( MAP_HEIGHT / 2 );
            
            for ( var x:int = startX; x < endX; x++ )
            {
                for ( var y:int = startY; y < endY; y++ )
                {
                    if ( x & 1 && y == endY ) continue;
                    
                    var newTile:MapHexTileVO = new MapHexTileVO();
                    newTile.x = x;
                    newTile.y = y - Math.floor( x * 0.5 );
                    newTile.terrain = _tileTypes[ "plains" ];
                    _tileMap[ getHash( newTile.x, newTile.y ) ] = newTile;
                }
            }
        }
        
        //--------------------------------------
        //  PRIVATE / PROTECTED METHODS
        //--------------------------------------
        
        private function loadTileTypes():void
        {
            _tileTypes = {};
            
            for each ( var tileData:Dictionary.<String, Object> in TILE_DATA )
            {
                var tile:MapTerrainVO = MapTerrainVO.createFromData( tileData );
                _tileTypes[ tile.type ] = tile;
            }
        }
        
    }    
}