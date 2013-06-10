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
		// CLASS CONSTANTS
		//--------------------------------------
		
		private static const TILES:Vector.<String> = [ "water", "3dhex", "3dhex" ];
	
		//--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------

		protected var _textureName:String;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function ProjectedAtlasSpriteRenderComponent( textureName:String="" )
		{
			_textureName = textureName != "" ? textureName : TILES[ int(Math.random() * TILES.length) ];
		}
		
		//--------------------------------------
		//  PRIVATE / PROTECTED METHODS
		//--------------------------------------
		
		override protected function createDisplayObject():DisplayObject
		{
        	var result:TextureAtlasSprite = new TextureAtlasSprite();
        	result.atlasName = "sprites";
        	result.textureName = _textureName;
        	result.pivotX = result.width * 0.5;
        	result.pivotY = result.height * 0.5;
        	return result;
		}
	}
}