package com.lunarraid.wargame.view
{
	import loom2d.textures.Texture;
	import loom2d.display.Image;
	import loom2d.display.DisplayObject;
	import loom2d.display.Sprite;
	import loom2d.display.Image;
	import com.lunarraid.wargame.math.Point3;
	import loom2d.ui.TextureAtlasSprite;
	
	public class ProjectedImageRenderer extends ProjectedViewRenderer
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
		
		public function ProjectedImageRenderer( url:String )
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