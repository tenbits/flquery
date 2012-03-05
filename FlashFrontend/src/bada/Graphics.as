import bada.Helper;
import bada.Utils;
import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.Transform;
import mx.data.encoders.Num;
/**
 * ...
 * @author tenbits
 */
class bada.Graphics
{
	
	/**
	 * note that mask have to be loaded as extarnal png with Utils.loadImage
	 * @param	image
	 * @param	mask
	 */
	public static function alphablend(image:MovieClip, mask:MovieClip, target:MovieClip, removesource:Boolean):MovieClip {
		var _image:BitmapData = new BitmapData(image._width, image._height, true , 0x000000);
		var _mask:BitmapData = new BitmapData(mask._width, mask._height, true , 0x000000);
		
		
		_image.draw(image, new Matrix(), new ColorTransform());
		_mask.draw(mask, new Matrix(), new ColorTransform());
		
		_image.copyChannel(_mask, new Rectangle(0, 0, image._width, image._height), new Point(0, 0), 8, 8);
		
		if (target == null) target = image._parent;
		
		var depth = target.getNextHighestDepth();
		target.createEmptyMovieClip('i' + depth, depth);
		
		var movie:MovieClip = target['i' + depth];
		
		movie._width = image._width;
		movie._height = image._height;
		movie._x = image._x;
		movie._y = image._y;
		
		movie._xscale = 100;
		movie._yscale = 100;
		
		movie.beginBitmapFill(_image);
		movie.moveTo(0,0);
		movie.lineTo(0,0);
		movie.lineTo(image._width,0);
		movie.lineTo(image._width,image._height);
		movie.lineTo(0,image._height);
		movie.lineTo(0,0);
		movie.endFill();
        
		_mask.dispose();
		
		if (removesource != false){
			image.removeMovieClip();
			mask.removeMovieClip();
		}
		
		//imageclone.removeMovieClip();
		
		
		return movie;
	}
	
	/*public static function blur(bitmap:BitmapData):BitmapData {
		bitmap = Graphics.cropN(bitmap, new Rectangle(10, 10, 300, 100));
		for (var y = 0; y < height; y++) {
			for (var x = 0; x < width; x++) {
				var total = 0;
				var sum = 0;
				for (var kx = -radius + 1; kx <= radius; kx++)
					for (var ky = -radius + 1; ky <= radius; ky++) {
						sum++;
						total += bitmap.getPixel(x + kx, y + ky);
					}
				blured.setPixel(x,y,total / sum); 
				
				
			}
		}
		
		
		return blured;
	}*/
	
	/**
	 * @deprecated use drawCanvas instead and cache BitmapData return for further disposing
	 * @param	movie - source movieclip as bitmapdata
	 * @param	parent - target, where to place new movieclip with cloned bitmapdata
	 * @param	width
	 * @param	height
	 * @return
	 */
	public static function cloneCanvas(movie:MovieClip, parent:MovieClip, width:Number, height:Number):MovieClip {
		movie._x -= 3000;
		movie._y -= 3000;		
		var _image:BitmapData = new BitmapData(width, height, true , 0x000000);
		_image.draw(movie, new Matrix(), new ColorTransform());
		
		var depth = parent.getNextHighestDepth();
		parent.createEmptyMovieClip('i' + depth, depth);
		
		var clone:MovieClip = parent['i' + depth];
		
		/*clone._width = width;
		clone._height = height;
		
		clone._xscale = 100;
		clone._yscale = 100;*/
		
		clone.clear();
		clone.beginBitmapFill(_image);
		clone.moveTo(0,0);
		clone.lineTo(0,0);
		clone.lineTo(width,0);
		clone.lineTo(width,height);
		clone.lineTo(0,height);
		clone.lineTo(0,0);
		clone.endFill();
        
		movie._x += 3000;
		movie._y += 3000;
		clone._x = movie._x;
		clone._y = movie._y;
		return clone;
	}
	
	public static function drawCanvas(movie:MovieClip, clone:MovieClip):BitmapData {
		movie._x -= 3000;
		movie._y -= 3000;
		
		var width = movie._width,
		height = movie._height;
		
		var _image:BitmapData = new BitmapData(width, height, true , 0x000000);
		
		
		_image.draw(movie, new Matrix(), new ColorTransform());
		
		
		/*clone._width = width;
		clone._height = height;
		clone._xscale = 100;
		clone._yscale = 100;*/
		
		clone.clear();
		clone.beginBitmapFill(_image);
		Graphics.outlineRectangle(clone, new Rectangle(0, 0, width, height));
		clone.endFill();
        
		movie._x += 3000;
		movie._y += 3000;
		clone._x = movie._x;
		clone._y = movie._y;
		
		return _image;
	}
	
	
	public static function repeatCanvas(parent:MovieClip, img:MovieClip, width:Number, height:Number):BitmapData {
		var _image:BitmapData = new BitmapData(img._width, img._height, true , 0x000000);
		_image.draw(img, new Matrix(), new ColorTransform());
		
		var clone = Utils.createMovieClip(parent);		
		clone.beginBitmapFill(_image);
		
		Graphics.outlineRectangle(clone, new Rectangle(0, 0, width, height));
		clone.endFill();        
		img.removeMovieClip();		
		return _image;
	}
	
	public static function outlineRectangle(movie:MovieClip, rec: Rectangle) {
		movie.moveTo(rec.x,rec.y);
		movie.lineTo(rec.x,rec.y);
		movie.lineTo(rec.width + rec.x,rec.y);
		movie.lineTo(rec.width + rec.x,rec.height + rec.y);
		movie.lineTo(rec.x,rec.height + rec.y);
		movie.lineTo(rec.x,rec.y);
	}
	
	public static function outlineRoundedRectangle(movie:MovieClip, rec:Rectangle, roundedCorner:Number) {
		movie.moveTo(rec.x + roundedCorner,rec.y);
		movie.lineTo(rec.x + roundedCorner,rec.y);
		movie.lineTo(rec.width + rec.x - roundedCorner , rec.y);
		
		movie.curveTo(rec.width + rec.x, rec.y, rec.width + rec.x, rec.y + roundedCorner);
		
		movie.lineTo(rec.width + rec.x, rec.height + rec.y - roundedCorner);
		movie.curveTo(rec.width + rec.x, rec.height + rec.y, rec.width + rec.x - roundedCorner, rec.height + rec.y);
		
		movie.lineTo(rec.x + roundedCorner, rec.height + rec.y);
		movie.curveTo(rec.x, rec.height +rec.y, rec.x, rec.height +rec.y - roundedCorner);
		
		movie.lineTo(rec.x, rec.y + roundedCorner);
		movie.curveTo(rec.x, rec.y, rec.x + roundedCorner, rec.y);
	}
	
	/**
	 * @resource is a full path to the BitmapData resource
	 */
	static function drawBorderImage(movie:MovieClip, w:Number, h:Number, resource:String, border:Number,  cropped:Rectangle):BitmapData {
		
		if (w == null) w = movie._width;
		if (h == null) h = movie._height;
		
		movie.clear();
		//var brd:MovieClip = Utils.attachMovie(movie, resource);
		
		var source:BitmapData = BitmapData.loadBitmap(resource);//Graphics.fromMovie(brd);
		//brd.removeMovieClip();
		
		var target:BitmapData = new BitmapData(w, h, true, 0xffffff);
		
		if (cropped instanceof Rectangle) {
			var _n:BitmapData =  Graphics.cropN(source, cropped);		
			source.dispose();
			source = _n;
		}
		
		/** border drawings */
		target.copyPixels(source, new Rectangle(0, 0, border, border), new Point(0, 0));
		
		
		var x:Number = border,
		y:Number = border,
		width:Number = target.width - border - border,
		height:Number = target.height - border - border,
		step = source.width - border - border;
		
		
		
		var top:BitmapData = Graphics.cropN(source, new Rectangle(border, 0, source.width - border - border, border));
		Graphics.drawN(target, top, new Rectangle(border, 0, target.width - border - border, border));
		top.dispose();
		
		target.copyPixels(source, new Rectangle(source.width - border, 0, border, border), new Point(target.width - border, 0));
		
		var right:BitmapData = Graphics.cropN(
				source, 
				new Rectangle(source.width - border, 
								border, 
								border,
								source.height - border - border));
		
		Graphics.drawN(target, right, new Rectangle(target.width - border, border, border, target.height - border - border));
		right.dispose();
		
		target.copyPixels(source, new Rectangle(source.width - border, source.height - border, border, border), new Point(target.width - border, target.height - border));
		
		var bottom:BitmapData = Graphics.cropN(source, new Rectangle(border, source.height - border, source.width - border - border, border));
		Graphics.drawN(target, bottom, new Rectangle(border, target.height - border, target.width - border - border, border));
		bottom.dispose();
		
		target.copyPixels(source, new Rectangle(0, source.height - border, border, border), new Point(0, target.height - border));
		
		var left:BitmapData = Graphics.cropN(source, new Rectangle(0, border, border, source.height - border - border));
		Graphics.drawN(target, left, new Rectangle(0, border, border, target.height - border - border));
		left.dispose();
		
		var center:BitmapData = Graphics.cropN(source, new Rectangle(border, border, source.width - border - border, source.height - border - border));
		Graphics.drawN(target, center, new Rectangle(border, border, target.width - border - border, target.height - border - border));
		center.dispose();
		
		/** end border drawings */
		source.dispose();
		
		Graphics.drawOnMovie(target, movie);
		return target;
	}
	
	private static function fillBorder(source:BitmapData, target:BitmapData, border:Number) {
		target.copyPixels(source, new Rectangle(0, 0, border, border), new Point(0, 0));
		
		var x:Number = border,
		y:Number = border,
		width:Number = target.width - border - border,
		height:Number = target.height - border - border,
		step = source.width - border - border;
		
		
		
		var top:BitmapData = Graphics.cropN(source, new Rectangle(border, 0, source.width - border - border, border));
		Graphics.drawN(target, top, new Rectangle(border, 0, target.width - border - border, border));
		top.dispose();
		
		target.copyPixels(source, new Rectangle(source.width - border, 0, border, border), new Point(target.width - border, 0));
		
		var right:BitmapData = Graphics.cropN(
				source, 
				new Rectangle(source.width - border, 
								border, 
								border,
								source.height - border - border));
		
		Graphics.drawN(target, right, new Rectangle(target.width - border, border, border, target.height - border - border));
		right.dispose();
		
		target.copyPixels(source, new Rectangle(source.width - border, source.height - border, border, border), new Point(target.width - border, target.height - border));
		
		var bottom:BitmapData = Graphics.cropN(source, new Rectangle(border, source.height - border, source.width - border - border, border));
		Graphics.drawN(target, bottom, new Rectangle(border, target.height - border, target.width - border - border, border));
		bottom.dispose();
		
		target.copyPixels(source, new Rectangle(0, source.height - border, border, border), new Point(0, target.height - border));
		
		var left:BitmapData = Graphics.cropN(source, new Rectangle(0, border, border, source.height - border - border));
		Graphics.drawN(target, left, new Rectangle(0, border, border, target.height - border - border));
		left.dispose();
		
		var center:BitmapData = Graphics.cropN(source, new Rectangle(border, border, source.width - border - border, source.height - border - border));
		Graphics.drawN(target, center, new Rectangle(border, border, target.width - border - border, target.height - border - border));
		center.dispose();
		
	}
	
	public static function cropN(bmp:BitmapData, rect:Rectangle):BitmapData {
		var _new:BitmapData = new BitmapData(rect.width, rect.height, true, 0xffffff);
		
		var matrix = new Matrix();
		matrix.tx = -rect.x;
		matrix.ty = -rect.y;
		
		_new.draw(bmp, matrix, new ColorTransform(), null, new Rectangle(0, 0, rect.width, rect.height));
		return _new;
	}
	
	public static function drawN(target:BitmapData, source:BitmapData, rect:Rectangle) {
		var matrix:Matrix = new Matrix();
		matrix.a = rect.width / source.width;
		matrix.d = rect.height / source.height;
		matrix.tx = rect.x;
		matrix.ty = rect.y;
		
		target.draw(source, matrix);
	}
	
	public static function fromMovie(movie:MovieClip):BitmapData {
		var canvas:BitmapData = new BitmapData(movie._width, movie._height, true, 0xffffff);
		canvas.draw(movie, new Matrix(), new ColorTransform());
		return canvas;
	}
	
	public static function drawOnMovie(graphics:BitmapData, movie:MovieClip) {
		movie.beginBitmapFill(graphics, null, null, true);
		movie.moveTo(0, 0);
		movie.lineTo(graphics.width, 0);
		movie.lineTo(graphics.width, graphics.height);
		movie.lineTo(0, graphics.height);
		movie.lineTo(0, 0);
		movie.endFill();
		
	}
	
	public static function changeColor(movie:MovieClip, color:Number) {
		var _new:Color = new Color(movie);
		_new.setRGB(color);
	}
	
	public static function fill(movie: MovieClip, color: Number, alpha: Number, width: Number, height: Number) : MovieClip {
		movie.clear();
		movie.beginFill(color, alpha);
		movie.moveTo(0, 0);
		movie.lineTo(0, 0);
		movie.lineTo(width, 0);
		movie.lineTo(width, height);
		movie.lineTo(0, height);
		movie.lineTo(0, 0);
		movie.endFill();
		return movie;
    }
}