package com.lunarraid.wargame.init.view
{
	import loom2d.display.DisplayObject;
	import loom2d.display.Stage;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.interfaces.IMediator;
	
	public class StageMediator extends Mediator
	{
		public static const MEDIATOR_NAME:String = "StageMediator";
		
		private var _layers:Vector.<IMediator> = [];
		private var _stage:Stage;
		
		public function StageMediator( stage:Stage )
		{
			super( MEDIATOR_NAME, stage );
			_stage = stage;
		}
		
		public function appendLayer( layerMediator:IMediator ):void
		{
			facade.registerMediator( layerMediator );
			if (_layers.indexOf(layerMediator) == -1) _layers.push( layerMediator );
			_stage.addChild( layerMediator.getViewComponent() as DisplayObject );
		}
		
		public function removeLayer( layerMediator:IMediator ):void
		{
			facade.removeMediator( layerMediator.getMediatorName() );
			var layerIndex:int = _layers.indexOf( layerMediator );
			if ( layerIndex != -1 ) _layers.splice( layerIndex, 1 );
			var targetView:DisplayObject = layerMediator.getViewComponent as DisplayObject;
			if ( _stage.contains( targetView ) ) _stage.removeChild( targetView, true );
		}
	}
}