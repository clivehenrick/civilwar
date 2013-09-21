package com.lunarraid.wargame.view
{
    import org.puremvc.as3.patterns.mediator.Mediator;
    import org.puremvc.as3.patterns.facade.Facade;
    
    import loom2d.Loom2D;
    import loom2d.textures.Texture;
    import loom2d.math.Point;
    import loom2d.events.TouchEvent;
    import loom2d.display.Sprite;
    import loom2d.display.Quad;
    
    import com.lunarraid.wargame.model.MapProxy;
    import com.lunarraid.wargame.model.ChitVO;
    import com.lunarraid.wargame.model.MapTerrainVO;
    import com.lunarraid.wargame.model.MapHexTileVO;
    
    import com.lunarraid.wargame.view.ProjectedViewManager;
    import com.lunarraid.wargame.view.ProjectedAtlasSpriteRenderer;
    
    import com.lunarraid.wargame.math.Point3;
    
    public class MapMediator extends Mediator
    {
        public static const NAME:String = "MapMediator";

        private var _viewComponent:Sprite;
        private var _projectedViewManager:ProjectedViewManager;
        private var _gestureManager:GestureManager;
        private var _bgQuad:Quad;
        private var _tiles:Dictionary.<int, ProjectedAtlasSpriteRenderer>;
        
        public function MapMediator()
        {
            super( NAME );
        }
        
        private function get mapProxy():MapProxy { return facade.retrieveProxy( MapProxy.NAME ) as MapProxy; }
        
        override public function onRegister():void
        {
            super.onRegister();
            _viewComponent = new Sprite();
            setViewComponent( _viewComponent );
            initialize();
        }
        
        private function initialize():void
        {
            _bgQuad = new Quad( Loom2D.stage.nativeStageWidth, Loom2D.stage.nativeStageHeight, 0x000000 );
            _viewComponent.addChildAt( _bgQuad, 0 );
            
            _projectedViewManager = new ProjectedViewManager();
            _projectedViewManager.depthSort = false;
            _projectedViewManager.viewComponent.touchable = false;
            _viewComponent.addChild( _projectedViewManager.viewComponent );
            
            _gestureManager = new GestureManager();
            _gestureManager.touchTarget = _viewComponent;
            _gestureManager.motionTarget = _projectedViewManager.viewComponent;
            _gestureManager.onTap = onTap;
            
            var map:Dictionary.<int, MapHexTileVO> = mapProxy.tileMap;
            
            var i:int = 0;
            
            trace( "GENERATING TILEMAP RENDERERS" );
            var startTime:int = Platform.getTime();
            
            _tiles = {};
            
            for ( var tileId:int in map )
            {
                var tile:MapHexTileVO = map[ tileId ];
                var hexRenderer:ProjectedAtlasSpriteRenderer = new ProjectedAtlasSpriteRenderer();
                hexRenderer.atlasName = "sprites";
                hexRenderer.textureName = tile.terrain.assetId;
                hexRenderer.x = tile.x;
                hexRenderer.y = tile.y;
                _projectedViewManager.addChild( hexRenderer );
                _tiles[ tileId ] = hexRenderer;
                if ( tile.occupant ) addChit( tile.occupant, tile.x, tile.y );
            }
            
            trace( "MAP GENERATION COMPLETED IN ", Platform.getTime() - startTime, " MILLISECONDS" );
            
            _projectedViewManager.viewComponent.scale = 0.7;
        }
        
        private function addChit( chitVO:ChitVO, x:int, y:int ):void
        {
            var renderComponent = new ChitRenderer();
            renderComponent.configure( "sprites", chitVO.color, "infantry", chitVO.name, chitVO.commander, chitVO.experience );
            renderComponent.health = chitVO.health; 
            renderComponent.morale = chitVO.morale;
            renderComponent.x = x;
            renderComponent.y = y;
            _projectedViewManager.addChild( renderComponent );
        }
        
        private function onTap( location:Point ):void
        {
            var mapPoint:Point3 = new Point3( location.x, location.y ); 
            mapPoint = _projectedViewManager.unproject( mapPoint );
            mapPoint.x = Math.round( mapPoint.x );
            mapPoint.y = Math.round( mapPoint.y );
            var tileId:int = mapProxy.getHash( mapPoint.x, mapPoint.y );
            if ( _tiles[ tileId ] ) _tiles[ tileId ].textureName = "water";
            trace( "TAPPED " + mapPoint ); 
        }
        
    }
}