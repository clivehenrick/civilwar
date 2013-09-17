package com.lunarraid.wargame.simulation.groups
{
    import loom2d.display.Quad;
    import loom.gameframework.*;
    import loom2d.display.DisplayObject;
    import loom2d.display.Sprite;
    import loom2d.Loom2D;
    
    import org.puremvc.as3.patterns.facade.Facade;
    
    import com.lunarraid.wargame.model.MapProxy;
    import com.lunarraid.wargame.model.MapHexTileVO;
    
    import com.lunarraid.wargame.simulation.gameobjects.*;
    import com.lunarraid.wargame.simulation.controller.*;
    import com.lunarraid.wargame.simulation.view.*;
    
    import com.lunarraid.wargame.simulation.view.chits.*;
    
    public class MapViewGroup extends LoomGroup implements ISimulationGroup
    {
        private static const MAP_WIDTH:int = 20;
        private static const MAP_HEIGHT:int = 20;
        
        private var _hexMapView:ProjectedViewManager;
        private var _gestureManager:GestureManager;
        private var _viewComponent:Sprite;
        
        public function get viewComponent():DisplayObject { return _viewComponent; }
        
        override public function initialize( objectName:String ):void
        {
            super.initialize( objectName );
            
            _viewComponent = new Sprite();
            
            var bgQuad:Quad = new Quad( Loom2D.stage.nativeStageWidth, Loom2D.stage.nativeStageHeight, 0x000000 );
            _viewComponent.addChildAt( bgQuad, 0 );
            
            _hexMapView = new ProjectedViewManager();
            _hexMapView.depthSort = false;
            registerManager( _hexMapView );
            _viewComponent.addChild( _hexMapView.viewComponent );
            
            _gestureManager = new GestureManager();
            _gestureManager.touchTarget = _viewComponent;
            _gestureManager.motionTarget = _hexMapView.viewComponent;
            registerManager( _gestureManager );
            
            var gameMap:LoomGameObject = new LoomGameObject();
            gameMap.owningGroup = this; 
            gameMap.initialize( "GameMap" );
            
            var facade:Facade = getManager( Facade ) as Facade;
            var mapProxy:MapProxy = facade.retrieveProxy( MapProxy.NAME ) as MapProxy;
            var map:Dictionary.<int, MapHexTileVO> = mapProxy.tileMap;
            
            var i:int = 0;
            
            for each( var tile:MapHexTileVO in map )
            {
                var hexRenderer:ProjectedAtlasSpriteRenderComponent = new ProjectedAtlasSpriteRenderComponent();
                hexRenderer.atlasName = "sprites";
                hexRenderer.textureName = tile.terrain.assetId;
                hexRenderer.x = tile.x;
                hexRenderer.y = tile.y;
                gameMap.addComponent( hexRenderer, "Renderer " + tile.x + " " + tile.y );
                
                if ( Math.round( Math.random() * 10 ) == 5 )
                {
                    var chitComponent:ChitRenderComponent = new ChitRenderComponent();
                    chitComponent.configure( "sprites", "blue", "infantry", "Brigade " + tile.x + "," + tile.y, "Cook", 3 ); 
                    chitComponent.x = tile.x;
                    chitComponent.y = tile.y;
                    gameMap.addComponent( chitComponent, "Chit" + i );
                    i++;
                }
            }
            
            
            _hexMapView.viewComponent.scale = 0.7;
        }
    }
}