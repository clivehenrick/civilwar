package com.lunarraid.wargame.simulation.chits
{
    import com.lunarraid.wargame.model.ChitVO;
    
    import loom.gameframework.LoomComponent;
    
    import loom2d.math.Point;
    import loom2d.math.Rectangle;
    
    public class ChitControllerComponent extends LoomComponent
    {
        //--------------------------------------
        // PRIVATE / PROTECTED
        //--------------------------------------
        
        private var _chitVO:ChitVO;
        private var _renderComponent:ChitRenderComponent;
        
        //--------------------------------------
        //  GETTERS / SETTERS
        //--------------------------------------
        
        public function get chitVO():ChitVO { return _chitVO; }
        
        public function set chitVO( value:ChitVO ):void
        {
            _chitVO = value;
            update();
        }
        
        //--------------------------------------
        //  CONSTRUCTOR
        //--------------------------------------
        
        public function ChitControllerComponent( chitVO:ChitVO )
        {
            this.chitVO = chitVO;
        }
        
        //--------------------------------------
        //  PUBLIC METHODS
        //--------------------------------------
        
        override public function onAdd():Boolean
        {
            var returnValue:Boolean = super.onAdd();
            update();
            return returnValue;
        }
        
        override public function onRemove():void
        {
            owner.removeComponent( _renderComponent );
            super.onRemove();
        }
        
        public function update():void
        {
            if ( !owner ) return;
            if ( !_renderComponent ) createRenderer();
            
            _renderComponent.configure( "sprites", _chitVO.color, "infantry", _chitVO.name, chitVO.commander, chitVO.experience );
            _renderComponent.health = _chitVO.health; 
            _renderComponent.morale = _chitVO.morale; 
        }
        
        //--------------------------------------
        //  PRIVATE / PROTECTED METHODS
        //--------------------------------------
        
        private function createRenderer():void
        {
            _renderComponent = new ChitRenderComponent();
            _renderComponent.registerForUpdates = false;
            _renderComponent.configure( "sprites", _chitVO.color, "infantry", _chitVO.name, chitVO.commander, chitVO.experience );
            owner.addComponent( _renderComponent, "ChitControllerRenderer" );
        }
        
    }
}