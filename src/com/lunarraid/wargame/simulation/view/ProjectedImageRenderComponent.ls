package com.lunarraid.wargame.simulation.view
{
	import Loom2D.Textures.Texture;
	import Loom2D.Display.Image;
	import Loom2D.Display.DisplayObject;
	import Loom2D.Display.Sprite;
	import Loom.GameFramework.AnimatedComponent;
	import com.lunarraid.wargame.simulation.math.Point3;
	import Loom2D.UI.TextureAtlasSprite;
	
	public class ProjectedImageRenderComponent extends ProjectedViewRenderComponent
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
		
		public function ProjectedImageRenderComponent( textureName:String="" )
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