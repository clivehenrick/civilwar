package com.lunarraid.wargame.simulation.view.chits
{
    import com.lunarraid.wargame.simulation.view.*;
    
    import loom2d.display.DisplayObject;
    import loom2d.display.Image;
    import loom2d.display.Sprite;
    
    import loom2d.ui.SimpleLabel;
    
    import loom2d.ui.TextureAtlasSprite;
    
    import loom2d.math.Point;
    import loom2d.math.Rectangle;
    
    public class ChitRenderComponent extends ProjectedViewRenderComponent
    {
        //--------------------------------------
        // PRIVATE / PROTECTED
        //--------------------------------------
        
        private var _displayObject:Sprite;
        
        private var _spriteSheet:String;
        private var _backgroundSkin:String;
        private var _icon:String;
        private var _label1:String;
        private var _label2:String;
        private var _starCount:int;
        
        private var _iconImage:Image;
        private var _healthBarFill:Sprite;
        private var _moraleBarFill:Sprite;
        
        //--------------------------------------
        //  PUBLIC METHODS
        //--------------------------------------
        
        override public function onAdd():Boolean
        {
            var returnValue:Boolean = super.onAdd();
            createRenderers();
            return returnValue;
        }
        
        override public function onRemove():void
        {
            clearRenderers();
            super.onRemove();
        }
        
        public function configure( spriteSheet:String, backgroundSkin:String, icon:String, label1:String, label2:String, starCount:int ):void
        {
            _spriteSheet = spriteSheet;
            _backgroundSkin = backgroundSkin;
            _icon = icon;
            _label1 = label1;
            _label2 = label2;
            _starCount = starCount;
            if ( owner ) createRenderers();
        }
                
        //--------------------------------------
        //  PRIVATE / PROTECTED METHODS
        //--------------------------------------
        
        override protected function createDisplayObject():DisplayObject
        {
            _displayObject = new Sprite();
            return _displayObject;
        }
        
        private function createRenderers():void
        {
            if ( _displayObject.numChildren > 0 ) clearRenderers();
            
            var healthBarContainer:Sprite = new Sprite();
            healthBarContainer.addChild( createSpriteQuarter( "chit-fill", 0, 0x009900 ) );
            healthBarContainer.addChild( createSpriteQuarter( "chit-fill", 3, 0x009900 ) );
            
            _healthBarFill = new Sprite();
            _healthBarFill.addChild( createSpriteQuarter( "chit-fill", 0, 0x00ff00 ) );
            _healthBarFill.addChild( createSpriteQuarter( "chit-fill", 3, 0x00ff00 ) );
            _healthBarFill.clipRect = new Rectangle( 0, 0, 5, 5 );
            healthBarContainer.addChild( _healthBarFill );
            healthBarContainer.clipRect = healthBarContainer.getBounds( healthBarContainer );
            
            _displayObject.addChild( healthBarContainer );
            
            var moraleBarContainer:Sprite = new Sprite();
            //moraleBarContainer.addChild( createSpriteQuarter( "chit-fill", 1, 0x990000 ) );
            //moraleBarContainer.addChild( createSpriteQuarter( "chit-fill", 2, 0x990000 ) );
            
            _moraleBarFill = new Sprite();
            //_moraleBarFill.addChild( createSpriteQuarter( "chit-fill", 1, 0xff0000 ) );
            //_moraleBarFill.addChild( createSpriteQuarter( "chit-fill", 2, 0xff0000 ) );
            
            moraleBarContainer.clipRect = moraleBarContainer.getBounds( moraleBarContainer );
            moraleBarContainer.addChild( _moraleBarFill );
            
            _displayObject.addChild( moraleBarContainer );
            
            for ( var i:int = 0; i < 4; i++ ) _displayObject.addChild( createSpriteQuarter( "chit-corner", i, 0x1B70FE ) );
            
            var icon:TextureAtlasSprite = new TextureAtlasSprite();
            icon.atlasName = _spriteSheet;
            icon.textureName = _icon;
            icon.center();
            
            _displayObject.addChild( icon );
            
            // TODO : Make better label system <rcook 7/29/2013>
            
            var label1:SimpleLabel = new SimpleLabel( "assets/fonts/Curse-hd.fnt" );
            label1.text = _label1;
            label1.scale = 0.3;
            label1.center();
            label1.y = -50;
            _displayObject.addChild( label1 ); 
            
            var label2:SimpleLabel = new SimpleLabel( "assets/fonts/Curse-hd.fnt" );
            label2.text = _label2;
            label2.scale = 0.3;
            label2.center();
            label2.y = -25;
            _displayObject.addChild( label2 ); 
            
            var starContainer:Sprite = new Sprite();
            
            for ( var j:int = 0; j < _starCount; j++ )
            {
                var starSprite:TextureAtlasSprite = new TextureAtlasSprite();
                starSprite.atlasName = _spriteSheet;
                starSprite.textureName = "star";
                starSprite.x = starSprite.width * 1.2 * j;
                starContainer.addChild( starSprite );
            }
            
            starContainer.center();
            starContainer.y = 46;
            
            _displayObject.addChild( starContainer );
            
            _healthBarFill.rotation = Math.PI / 4;
            _moraleBarFill.rotation = -Math.PI / 4;
        }
        
        private function clearRenderers():void
        {
            _healthBarFill = null;
            _moraleBarFill = null;
            _displayObject.removeChildren( 0, _displayObject.numChildren - 1, true );
        }
        
        private function createSpriteQuarter( textureName:String, position:int, tint:uint = 0xffffff ):TextureAtlasSprite
        {
            var result:TextureAtlasSprite = new TextureAtlasSprite();
            result.atlasName = _spriteSheet;
            result.textureName = textureName;
            result.pivotX = result.width - 0.5;
            result.pivotY = result.height - 0.5;
            result.rotation = ( Math.PI / 2 ) * position;
            
            if ( tint != 0xffffff ) result.color = tint;
            
            return result;
        }
    }
}