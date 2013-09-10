package com.lunarraid.wargame.simulation.groups
{
	import loom.gameframework.*;
    import loom2d.display.DisplayObject;
    import loom2d.display.Sprite;
	
    import com.lunarraid.wargame.simulation.gameobjects.*;
    import com.lunarraid.wargame.simulation.controller.*;
	import com.lunarraid.wargame.simulation.view.*;
	
    import com.lunarraid.wargame.simulation.view.chits.*;
	
	public class MapViewGroup extends LoomGroup implements ISimulationGroup
	{
		private var _hexMapView:ProjectedViewManager;
		private var _gestureManager:GestureManager;
        private var _viewComponent:Sprite;
		
		public function get viewComponent():DisplayObject { return _viewComponent; }
		
		override public function initialize( objectName:String ):void
		{
			super.initialize( objectName );
			
			_viewComponent = new Sprite();
			
			_gestureManager = new GestureManager( _viewComponent );
			registerManager( _gestureManager );
			
			_hexMapView = new ProjectedViewManager();
			_hexMapView.depthSort = false;
			registerManager( _hexMapView );
			_viewComponent.addChild( _hexMapView.viewComponent );
			
			var gameMap:LoomGameObject = new LoomGameObject();
            gameMap.owningGroup = this; 
			gameMap.initialize( "GameMap" );
			
			for ( var x:int = 0; x < 2; x++ )
			{
                for ( var y:int = 0; y < 2; y++ )
                {
                    if ( x & 1 && y == 1 ) continue;
                    var hexRenderer:ProjectedAtlasSpriteRenderComponent = new ProjectedAtlasSpriteRenderComponent();
                    hexRenderer.x = x;
                    hexRenderer.y = y - Math.floor( x / 2 );
                    gameMap.addComponent( hexRenderer, "Renderer " + x + " " + y );
                }
			}
			
			var chitComponent:ChitRenderComponent = new ChitRenderComponent();
			chitComponent.configure( "sprites", "blue", "infantry", "1st Brigade", "Cook", 3 ); 
            chitComponent.x = 0;
            chitComponent.y = 0;
            gameMap.addComponent( chitComponent, "Chit" );
			
            _hexMapView.viewComponent.x = 100;
            _hexMapView.viewComponent.y = 100;
            _hexMapView.viewComponent.scale = 0.7;
			
			/*
			var backgroundPlate:StaticImageGameObject = new StaticImageGameObject( "assets/textures/backgrounds/bg1.png" );
			backgroundPlate.owningGroup = this;
			backgroundPlate.initialize( "background" );
			*/
		}
	}
}