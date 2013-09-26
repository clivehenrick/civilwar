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
    import loom2d.display.QuadBatch;
    
    import com.lunarraid.wargame.model.MapProxy;
    import com.lunarraid.wargame.model.ChitVO;
    import com.lunarraid.wargame.model.MapTerrainVO;
    import com.lunarraid.wargame.model.MapHexTileVO;
    
    import com.lunarraid.wargame.math.Point3;
    
    public class MapMediator extends Mediator
    {
        //--------------------------------------
        // CLASS CONSTANTS
        //--------------------------------------
        
        public static const NAME:String = "MapMediator";

        //--------------------------------------
        // PRIVATE / PROTECTED
        //--------------------------------------
        
        private var _viewComponent:Sprite;
        private var _projectedViewManager:ProjectedViewManager;
        private var _gestureManager:GestureManager;
        private var _bgQuad:Quad;
        private var _tapPoint:Point3;
        
        //--------------------------------------
        // CONSTRUCTOR
        //--------------------------------------
        
        public function MapMediator()
        {
            super( NAME );
        }
        
        //--------------------------------------
        // GETTERS / SETTERS
        //--------------------------------------
        
        private function get mapProxy():MapProxy { return facade.retrieveProxy( MapProxy.NAME ) as MapProxy; }
        
        //--------------------------------------
        //  PUBLIC METHODS
        //--------------------------------------
        
        override public function onRegister():void
        {
            super.onRegister();
            _viewComponent = new Sprite();
            setViewComponent( _viewComponent );
            initialize();
        }
        
        //--------------------------------------
        //  PRIVATE / PROTECTED METHODS
        //--------------------------------------
        
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
            
            _projectedViewManager.viewComponent.scale = 0.75;
            
            createMap();
            
            var startTime:int = Platform.getTime();
            var testBatch:QuadBatch = HexGenerator.generateHoneyComb( 50, 50, 0.05, 0x0000FF );
            //testBatch.x = 100;
            //testBatch.y = 100;
            testBatch.scale = 256;
            Sprite( _projectedViewManager.viewComponent ).addChild( testBatch );
            trace( "HONEYCOMB GENERATION COMPLETED IN ", Platform.getTime() - startTime, " MILLISECONDS" );
        }
        
        private function createMap():void
        {
            var map:Dictionary.<int, MapHexTileVO> = mapProxy.tileMap;
            
            var mapRenderer:ProjectedHexMapRenderer = new ProjectedHexMapRenderer();
            _projectedViewManager.addChild( mapRenderer );
            mapRenderer.generateMap( "sprites", map );
            
            var i:int = 0;
            
            trace( "GENERATING CHITS" );
            var startTime:int = Platform.getTime();
            
            return;
            
            for ( var tileId:int in map )
            {
                var tile:MapHexTileVO = map[ tileId ];
                if ( tile.occupant ) addChit( tile.occupant, tile.x, tile.y );
            }
            
            trace( "CHIT GENERATION COMPLETED IN ", Platform.getTime() - startTime, " MILLISECONDS" );
        }
        
        private function addChit( chitVO:ChitVO, x:int, y:int ):void
        {
            var renderComponent = new ChitRenderer();
            renderComponent.configure( "sprites", chitVO.color, chitVO.type, chitVO.name, chitVO.commander, chitVO.experience );
            renderComponent.health = chitVO.health; 
            renderComponent.morale = chitVO.morale;
            renderComponent.x = x;
            renderComponent.y = y;
            _projectedViewManager.addChild( renderComponent );
        }
        
        private function onTap( location:Point ):void
        {
            _tapPoint.setTo( location.x, location.y, 0 );
            _tapPoint = _projectedViewManager.unproject( _tapPoint );
            _tapPoint.x = Math.round( _tapPoint.x );
            _tapPoint.y = Math.round( _tapPoint.y );
            trace( "TAPPED " + _tapPoint ); 
        }
        
    }
}