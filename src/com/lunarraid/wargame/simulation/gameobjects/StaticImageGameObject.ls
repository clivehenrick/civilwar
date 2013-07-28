package com.lunarraid.wargame.simulation.gameobjects
{
	import loom.gameframework.*;
	
	import com.lunarraid.wargame.simulation.view.ProjectedImageRenderComponent;
	
	public class StaticImageGameObject extends LoomGameObject
	{
		private var _url:String;
		private var _renderer:ProjectedImageRenderComponent;
		
		public function StaticImageGameObject( url:String )
		{
			_url = url;
		}
		
		override public function initialize( objectName:String ):void
		{
			super.initialize( objectName );
			_renderer = new ProjectedImageRenderComponent( _url );
			addComponent( _renderer, "Renderer" );
		}
	}
}