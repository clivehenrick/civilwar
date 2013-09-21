package com.lunarraid.wargame.view
{

import system.platform.File;

import loom2d.math.Point;
import loom2d.display.QuadBatch;
import loom2d.text.BitmapFont;

/**
 * Temporarily borrowed from the Loom SDK
 */

class SimpleLabel extends QuadBatch
{

    //____________________________________________
    //  Public Properties
    //____________________________________________
    /**
     *  Sets the text for the Label. The fontFile property must be set before
     *  this method can take effect.
     */
    public function set text(value:String):void
    {
        if (value == _text)
            return;

        valid = false;
        _text = value;

        validate();

    }

    /**
     *  Gets the text for the Label.
     */
    public function get text():String
    {
        return _text;
    }

    /**
     *  Sets the .fnt file path to load from the assets folder.
     */
    public function set fontFile(value:String):void
    {
        valid = false;
        _fontFile = value;
    }

    /**
     *  Gets the .fnt file path that has been loaded from the assets folder. 
     */
    public function get fontFile():String
    {
        return _fontFile;
    }

    /**
     *  Gets the size of the Label.
     */
    public function get size():Point
    {
        return _size;
    }
    
    override public function get width():Number { return _size.x; }
    override public function get height():Number { return _size.y; }

    protected override function validate():void
    {
        super();
        
        if (!fontFile || !text)
            return;

        if (!_bmFont)
        {
            _bmFont = BitmapFont.load(fontFile);

        }

        if (_bmFont && autoSize && text)
            _size = _bmFont.getStringDimensions(text, Number.MAX_VALUE, Number.MAX_VALUE);            
            
        reset();
        _bmFont.fillQuadBatch(this, _size.x, _size.y, text, -1, 0xffffff, "center", "center", true, true);

    }

    //____________________________________________
    //  Constructor
    //____________________________________________
    /**
     *  Creates a Label and optionally loads a .fnt file from the assets directory.
     *     
     *  @param fntFile The fnt file to load from the assets directory. (optional)
     *  @param width The width of the label, passing in a 0 will enable auto sizing based on provided text
     *  @param height The height of the label, passing in a 0 will enable auto sizing based on provided text
     */
    public function SimpleLabel(fntFile:String=null, width:int = 0, height:int = 0)
    {   

        autoSize = !width || !height;

        if (!autoSize)
        {
            _size.x = width;
            _size.y = height;
        }

        fontFile = fntFile;

        if (fontFile)
        {
            _bmFont = BitmapFont.load(fontFile);
        }

    }

    public var autoSize = false;

    //____________________________________________
    //  Public Functions
    //____________________________________________

    //____________________________________________
    //  Protected Properties
    //____________________________________________
    protected var _text:String;
    protected var _fontFile:String;
    protected var _size:Point = new Point(100, 100);
    protected var _bmFont:BitmapFont;
 }

}