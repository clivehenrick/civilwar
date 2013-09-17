package com.lunarraid.wargame.simulation.view
{
	import loom2d.textures.Texture;
	import loom2d.display.Image;
	import loom2d.display.DisplayObject;
	import loom2d.display.Sprite;
	import loom.gameframework.AnimatedComponent;
	import com.lunarraid.wargame.simulation.math.Point3;
	import loom2d.ui.TextureAtlasSprite;
	
	public class ProjectedAtlasSpriteRenderComponent extends ProjectedViewRenderComponent
	{
		//--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------

		protected var _atlasName:String = "";
		protected var _textureName:String = "";
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function ProjectedAtlasSpriteRenderComponent()
		{
		}
		
        //--------------------------------------
        //  GETTERS / SETTERS
        //--------------------------------------
        
        public function get atlasName():String { return _atlasName; }
        
        public function set atlasName( value:String ) :void
        {
            _atlasName = value;
            if ( _viewComponent ) TextureAtlasSprite( _viewComponent ).atlasName = value;
        }
        
        public function get textureName():String { return _textureName; }
        
        public function set textureName( value:String ) :void
        {
            _textureName = value;
            if ( _viewComponent ) TextureAtlasSprite( _viewComponent ).textureName = value;
        }
        
		//--------------------------------------
		//  PRIVATE / PROTECTED METHODS
		//--------------------------------------
		
		override protected function createDisplayObject():DisplayObject
		{
        	var result:TextureAtlasSprite = new TextureAtlasSprite();
        	if ( _atlasName ) result.atlasName = _atlasName;
        	if ( _textureName ) result.textureName = _textureName;
        	result.center();
        	return result;
		}
	}
}