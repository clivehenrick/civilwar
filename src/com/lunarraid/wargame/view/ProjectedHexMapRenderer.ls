package com.lunarraid.wargame.view
{
	import loom2d.ui.TextureAtlasSprite;
	
    import loom2d.display.QuadBatch;
    import loom2d.display.DisplayObject;
    
    import loom2d.math.Matrix;
	
    import com.lunarraid.wargame.math.Point3;
    import com.lunarraid.wargame.model.MapHexTileVO;
    import com.lunarraid.wargame.view.projection.OverheadHexProjection;
	
    public class ProjectedHexMapRenderer extends ProjectedViewRenderer
    {
        private var _quadBatch:QuadBatch = new QuadBatch();
        private var _hexProjection:OverheadHexProjection = new OverheadHexProjection();
        private var _atlasSprite:TextureAtlasSprite = new TextureAtlasSprite();
        private var _scratchPoint3:Point3;
         
        public function generateMap( atlasName:String, map:Dictionary.<int, MapHexTileVO> ):void
        {
            trace( "GENERATING TILEMAP RENDERERS" );
            var startTime:int = Platform.getTime();
            
            _quadBatch.reset();
            _atlasSprite.atlasName = atlasName;
            
            for ( var tileId:int in map )
            {
                var tile:MapHexTileVO = map[ tileId ];
                _scratchPoint3.setTo( tile.x, tile.y, 0 );
                _scratchPoint3 = _hexProjection.project( _scratchPoint3 );
                _atlasSprite.textureName = tile.terrain.assetId;
                _atlasSprite.center();
                _atlasSprite.x = _scratchPoint3.x;
                _atlasSprite.y = _scratchPoint3.y;
                _quadBatch.addImage( _atlasSprite );
            }
            
            trace( "MAP GENERATION COMPLETED IN ", Platform.getTime() - startTime, " MILLISECONDS" );
        }
        
        override protected function createDisplayObject():DisplayObject
        {
            return _quadBatch;
        }
    }
}