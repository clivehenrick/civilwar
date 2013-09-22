package com.lunarraid.wargame.view
{
	import loom2d.display.DisplayObject;
	import loom2d.display.Stage;
	import loom2d.Loom2D;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.interfaces.IMediator;
	
	public class StageMediator extends Mediator
	{
        //--------------------------------------
        // CLASS CONSTANTS
        //--------------------------------------
        
		public static const MEDIATOR_NAME:String = "StageMediator";
		
        //--------------------------------------
        // PRIVATE / PROTECTED
        //--------------------------------------
        
		private var _layers:Vector.<IMediator> = [];
		
        //--------------------------------------
        // CONSTRUCTOR
        //--------------------------------------
        
		public function StageMediator()
		{
			super( MEDIATOR_NAME, Loom2D.stage );
		}
		
        //--------------------------------------
        //  PUBLIC METHODS
        //--------------------------------------
        
		public function appendLayer( layerMediator:IMediator ):void
		{
			facade.registerMediator( layerMediator );
			if (_layers.indexOf(layerMediator) == -1) _layers.push( layerMediator );
			Loom2D.stage.addChild( layerMediator.getViewComponent() as DisplayObject );
		}
		
		public function removeLayer( layerMediator:IMediator ):void
		{
			facade.removeMediator( layerMediator.getMediatorName() );
			var layerIndex:int = _layers.indexOf( layerMediator );
			if ( layerIndex != -1 ) _layers.splice( layerIndex, 1 );
			var targetView:DisplayObject = layerMediator.getViewComponent as DisplayObject;
			if ( Loom2D.stage.contains( targetView ) ) Loom2D.stage.removeChild( targetView, true );
		}
	}
}