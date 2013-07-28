package com.lunarraid.wargame.simulation.view
{
	import loom2d.textures.Texture;
	import loom2d.display.Image;
	import loom2d.display.DisplayObject;
	import loom2d.display.Sprite;
	import loom2d.display.Image;
	import loom.gameframework.AnimatedComponent;
	import com.lunarraid.wargame.simulation.math.Point3;
	import loom2d.ui.TextureAtlasSprite;
	
	public class ProjectedImageRenderComponent extends ProjectedViewRenderComponent
	{
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		//--------------------------------------
		// PRIVATE / PROTECTED
		//--------------------------------------
		
		private var _url:String;

		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function ProjectedImageRenderComponent( url:String )
		{
			_url = url;
		}
		
		//--------------------------------------
		//  PRIVATE / PROTECTED METHODS
		//--------------------------------------
		
		override protected function createDisplayObject():DisplayObject
		{
        	var result:Image = new Image( Texture.fromAsset( _url ) );
        	result.pivotX = result.width * 0.5;
        	result.pivotY = result.height * 0.5;
        	return result;
		}
	}
}