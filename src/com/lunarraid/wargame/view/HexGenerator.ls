package com.lunarraid.wargame.view
{
    import loom2d.display.QuadBatch;
    import loom2d.display.Quad;
    
    import loom2d.math.Matrix;
    import loom2d.math.Point;
    
    public static class HexGenerator
    {
        private static const LEFT_VERTEX:Point = new Point( Math.cos( Math.PI / 1.5 ) * 0.5, Math.sin( Math.PI / 1.5 ) * 0.5 );
        private static const RIGHT_VERTEX:Point = new Point( Math.cos( Math.PI / 3 ) * 0.5, Math.sin( Math.PI / 3 ) * 0.5 );
        
        private static var _partialHexQuad:Quad;
        private static var _matrix:Matrix = new Matrix();
        
        public static function generateHex( color:uint = 0xFFFFFF, thickness:Number = 0.2, resultQuadBatch:QuadBatch = null ):QuadBatch
        {
            if ( !resultQuadBatch ) resultQuadBatch = new QuadBatch();
            resultQuadBatch.reset();
            updatePartialHexQuad( thickness );
            _partialHexQuad.color = color;
            _matrix.identity();
            for ( var i:int = 0; i < 6; i++ )
            {
                resultQuadBatch.addQuad( _partialHexQuad, 1.0, null, false, _matrix ); 
                _matrix.rotate( Math.PI / 3 );
            }
            return resultQuadBatch;
        }
        
        public static function generateHoneyComb( columns:int = 5, rows:int = 5, thickness:Number = 0.2, color:uint = 0xFFFFFF, resultQuadBatch:QuadBatch = null ):QuadBatch
        {
            if ( !resultQuadBatch ) resultQuadBatch = new QuadBatch();
            resultQuadBatch.reset();
            updatePartialHexQuad( thickness, true );
            _partialHexQuad.color = color;
            
            for ( var row:int = 0; row < rows; row++ )
            {
                for ( var column:int = 0; column < columns; column++ )
                {
                    var xCoord:Number = column * 0.75;
                    var yCoord:Number = row * LEFT_VERTEX.y * 2 + ( column % 2 == 1 ? LEFT_VERTEX.y : 0 );
                    for ( var i:int = -1; i < 2; i++ ) addPartialQuad( resultQuadBatch, xCoord, yCoord, i );
                    if ( row == 0 || column == 0 ) addPartialQuad( resultQuadBatch, xCoord, yCoord, 2 );
                    if ( row == 0 ) addPartialQuad( resultQuadBatch, xCoord, yCoord, 3 );
                    if ( row == 0 || column == columns-1 ) addPartialQuad( resultQuadBatch, xCoord, yCoord, 4 );
                }
            }
            return resultQuadBatch;
        }
        
        private static function addPartialQuad( quadBatch:QuadBatch, x:int, y:int, hexPieceId:int ):void
        {
            _matrix.identity();
            _matrix.rotate( Math.PI / 3 * hexPieceId );
            _matrix.translate( x, y );
            quadBatch.addQuad( _partialHexQuad, 1.0, null, false, _matrix ); 
        }
        
        private static function updatePartialHexQuad( thickness:Number = 0.05, honeyComb:Boolean = false ):void
        {
            if ( !_partialHexQuad ) _partialHexQuad = new Quad( 1, 1, 0xFFFFFF );
            var topMultiplier:Number = honeyComb ? ( 1 + thickness * 0.5 ) : 1;
            var bottomMultiplier:Number = 1 - ( honeyComb ? ( thickness * 0.5 ) : thickness );
            _partialHexQuad.setVertexPosition( 0, LEFT_VERTEX.x * topMultiplier, LEFT_VERTEX.y * topMultiplier );
            _partialHexQuad.setVertexPosition( 1, RIGHT_VERTEX.x * topMultiplier, RIGHT_VERTEX.y * topMultiplier );
            _partialHexQuad.setVertexPosition( 2, LEFT_VERTEX.x * bottomMultiplier, LEFT_VERTEX.y * bottomMultiplier );
            _partialHexQuad.setVertexPosition( 3, RIGHT_VERTEX.x * bottomMultiplier, RIGHT_VERTEX.y * bottomMultiplier );
        }
    }
}