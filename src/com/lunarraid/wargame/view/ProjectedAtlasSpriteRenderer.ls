package com.lunarraid.wargame.view
{
	import loom2d.textures.Texture;
	import loom2d.display.Image;
	import loom2d.display.DisplayObject;
	import loom2d.display.Sprite;
	import com.lunarraid.wargame.math.Point3;
	import loom2d.ui.TextureAtlasSprite;
	
	public class ProjectedAtlasSpriteRenderer extends ProjectedViewRenderer
	{
		//--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------

		protected var _atlasName:String = "sprites";
		protected var _textureName:String = "default";
		
        //--------------------------------------
        //  GETTERS / SETTERS
        //--------------------------------------
        
        public function get atlasName():String { return _atlasName; }
        
        public function set atlasName( value:String ):void
        {
            _atlasName = value;
            if ( _viewComponent )
            {
                TextureAtlasSprite( _viewComponent ).atlasName = value;
                _viewComponent.center();
            }
        }
        
        public function get textureName():String { return _textureName; }
        
        public function set textureName( value:String ) :void
        {
            _textureName = value;
            if ( _viewComponent )
            {
                TextureAtlasSprite( _viewComponent ).textureName = value;
                _viewComponent.center();
            }
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