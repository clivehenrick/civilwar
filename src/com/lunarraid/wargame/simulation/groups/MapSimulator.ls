package com.lunarraid.wargame.simulation.groups
{
    import loom.gameframework.*;
    
    import loom2d.display.Quad;
    import loom2d.display.DisplayObject;
    import loom2d.display.Sprite;
    
    import loom2d.math.Point;
    
    import loom2d.Loom2D;
    
    import org.puremvc.as3.patterns.facade.Facade;
    
    import com.lunarraid.wargame.model.MapProxy;
    import com.lunarraid.wargame.model.MapHexTileVO;
    import com.lunarraid.wargame.model.ChitVO;
    
    import com.lunarraid.wargame.simulation.gameobjects.*;
    import com.lunarraid.wargame.simulation.controller.*;
    import com.lunarraid.wargame.simulation.view.*;
    import com.lunarraid.wargame.simulation.math.*;
    
    import com.lunarraid.wargame.simulation.chits.*;
    
    public class MapSimulator extends LoomGroup implements ISimulationGroup
    {
        private var _hexMapView:ProjectedViewManager;
        private var _gestureManager:GestureManager;
        private var _viewComponent:Sprite;
        private var _bgQuad:Quad;
        
        public function get viewComponent():DisplayObject { return _viewComponent; }
        
        override public function initialize( objectName:String ):void
        {
            super.initialize( objectName );
            
            registerManager( this );
            
            _viewComponent = new Sprite();
            
            _bgQuad = new Quad( Loom2D.stage.nativeStageWidth, Loom2D.stage.nativeStageHeight, 0x000000 );
            _viewComponent.addChildAt( _bgQuad, 0 );
            
            _hexMapView = new ProjectedViewManager();
            _hexMapView.depthSort = false;
            registerManager( _hexMapView );
            _hexMapView.viewComponent.touchable = false;
            _viewComponent.addChild( _hexMapView.viewComponent );
            
            _gestureManager = new GestureManager();
            _gestureManager.touchTarget = _viewComponent;
            _gestureManager.motionTarget = _hexMapView.viewComponent;
            _gestureManager.onTap = onTap;
            registerManager( _gestureManager );
            
            var gameMap:LoomGameObject = new LoomGameObject();
            gameMap.owningGroup = this; 
            gameMap.initialize( "GameMap" );
            
            var facade:Facade = getManager( Facade ) as Facade;
            var mapProxy:MapProxy = facade.retrieveProxy( MapProxy.NAME ) as MapProxy;
            var map:Dictionary.<int, MapHexTileVO> = mapProxy.tileMap;
            
            var i:int = 0;
            
            trace( "GENERATING TILEMAP RENDERERS" );
            var startTime:int = Platform.getTime();
            
            for each( var tile:MapHexTileVO in map )
            {
                var hexRenderer:ProjectedAtlasSpriteRenderComponent = new ProjectedAtlasSpriteRenderComponent();
                hexRenderer.atlasName = "sprites";
                hexRenderer.textureName = tile.terrain.assetId;
                hexRenderer.x = tile.x;
                hexRenderer.y = tile.y;
                hexRenderer.registerForUpdates = false;
                gameMap.addComponent( hexRenderer, "Renderer " + tile.x + " " + tile.y );
                
                if ( tile.occupant ) addChit( tile.occupant );
            }
            
            trace( "MAP GENERATION COMPLETED IN ", Platform.getTime() - startTime, " MILLISECONDS" );
            
            _hexMapView.viewComponent.scale = 0.7;
        }
        
        private function createMap():void
        {
        }
        
        private function addChit( chitVO:ChitVO ):LoomGameObject
        {
            var chit:LoomGameObject = new LoomGameObject();
            chit.owningGroup = this;
            chit.initialize();
            
            var chitController:ChitControllerComponent = new ChitControllerComponent( chitVO );
            chit.addComponent( chitController, "Controller" );
            
            return chit;
        }
        
        private function onTap( location:Point ):void
        {
            var mapPoint:Point3 = new Point3( location.x - _hexMapView.viewComponent.x, location.y - _hexMapView.viewComponent.y, 0 );
            _hexMapView.unproject( mapPoint );
            trace( "TAPPED " + mapPoint ); 
        }
    }
}