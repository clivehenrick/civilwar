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
            trace( "LOADING TILEMAP INTO MAPPROXY" );
            var startTime:int = Platform.getTime();
            
            _tileMap = {};
            
            var startX:int = 0; // Math.floor( -MAP_WIDTH / 2 );
            var endX:int = MAP_WIDTH; // Math.floor( MAP_WIDTH / 2 );
            var startY:int = 0; // Math.floor( -MAP_HEIGHT / 2 );
            var endY:int = MAP_HEIGHT; // Math.floor( MAP_HEIGHT / 2 );
            
            var numChits:int = 0;
            
            for ( var x:int = startX; x < endX; x++ )
            {
                for ( var y:int = startY; y < endY; y++ )
                {
                    if ( x & 1 && y == endY ) continue;
                    
                    var newTile:MapHexTileVO = new MapHexTileVO();
                    newTile.x = x;
                    newTile.y = y - Math.floor( x * 0.5 );
                    newTile.terrain = ( x + y ) % 2 == 1 ? _tileTypes[ "plains" ] : _tileTypes[ "river" ];
                    
                    if ( numChits < 30 )
                    {
                        var occupant:ChitVO = new ChitVO();
                        occupant.color = 0x1B70FE;
                        occupant.type = numChits % 3 == 0 ? "infantry" : numChits % 3 == 1 ? "cavalry" : "artillery";
                        occupant.name = "NAME";
                        occupant.commander = "COMMANDER";
                        occupant.experience = Math.floor( Math.random() * 3 ) + 1;
                        occupant.health = Math.random(); 
                        occupant.morale = Math.random();
                        newTile.occupant = occupant;
                        numChits++;
                    }
                    
                    var tileId:int = getHash( newTile.x, newTile.y );
                    if ( _tileMap[ tileId ] != null ) trace( "TILE FOUND WHERE IT DOESN'T BELONG" );
                    _tileMap[ tileId ] = newTile;
                }
            }
            
            trace( "MAP LOAD COMPLETED IN ", Platform.getTime() - startTime, " MILLISECONDS" );
            
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