import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Transform;
import org.flashdevelop.utils.FlashConnect;
import org.flashdevelop.utils.FlashViewer;

class bada.Utils {
	public static function clone(movie: MovieClip):MovieClip {
		var depth = movie._parent.getNextHighestDepth();
		return movie.duplicateMovieClip('clip-' + depth, depth);
	}
	
	
	public static function loadMovie2(target: MovieClip, url: String, success: Function) : MovieClip {
		
		if (!url && target['img2'] != null) {
			target['img2'].removeMovieClip();
			return null;
		}
		
		var newurl = 'src.resources.' + (Bada.smallscreen ? '400.' : '800.') + url;
		
		var movie = target.attachMovie(newurl, 'img2', 1);
		if (movie == null) Bada.log('LOAD FAIL', newurl);
		
		if (Bada.smallscreen) {
			target['img2']._xscale = 200;
			target['img2']._yscale = 200;
		}
		
		if (success) success(target['img2']);
		return target['img2'];
	}
	
	public static function loadExternalMovie(target:MovieClip, url:String, success:Function):Void {
		var newurl = 'external/' + (Bada.smallscreen ? '400/' : '800/') + url,
		depth = target.getNextHighestDepth(),
		id = 'image-' + depth,
		container = Utils.createMovieClip(target, id),
		mc: MovieClipLoader = new MovieClipLoader(),
		mclListener: Object = {
			onLoadInit: function($div) {
				if (success) success($div);
				mc = null;
			},
			onLoadError: function() {
				Bada.log('LOAD IMAGE ERROR', url, arguments);
			}
		};
		
		mc.addListener(mclListener);
		mc.loadClip(url, container);
	}
	
	public static function attachMovie(target: MovieClip, url: String, id:String, depth:Number) : MovieClip {		
		if (!url) {
			if (typeof id === 'string' && target[id] !== null) {
				target[id].removeMovieClip();
				target[id] = null;
			}
			return null
		}
		
		var newurl = 'src.resources.' + (Bada.smallscreen ? '400.' : '800.') + url
		
		if (depth == null) depth = target.getNextHighestDepth();
		if (id == null) id = 'attached.movie.' + depth;
		
		var movie = target.attachMovie(newurl, id, depth);
		if (movie == null) {
			Bada.log('ATTACH FAIL', newurl, 'target', target);		
		}
		
		if (Bada.smallscreen) {
			target[id]._xscale = 200;
			target[id]._yscale = 200;
		}
		return target[id];
	}

	

	public static
	function extend() {
		
		
		Function.bind = function() {
			if (arguments.length < 2 && typeof arguments[0] == "undefined") return this;
			var args = arguments,
			// Array.prototype.slice.call(arguments),
			__method = args.shift(),
			object = args.shift();
			return function() {
				return __method.apply(object, args.concat(arguments));
			}
		}

/* obsolete		MovieClip.prototype.isVisible = function() : Boolean {
			if (this._visible == false) return false;
			//if (this._x === -1000) return false;
			return true;
		}

		TextField.prototype.setText = function(text: String) : TextField {
			this.text = text;
			if (this['_font']) this.setTextFormat(this['_font']);
			return this;
		}
*/
	}
	//public static function $(target:MovieClip){
	//    if (target.css == null){
	//        target.css = MovieClip.prototype.css;
	//    }
	//}
	//
	//public static function css(movie:MovieClip, _css:Object){
	//    
	//    var width = movie._width || _css['width'],
	//    height = movie._height || _css['height'];
	//                    
	//     for(var prop in _css){
	//            //if (typeof css[prop] == 'Number'){
	//            //    css[prop] = adjustNumericValue(css[prop]);
	//            //}
	//            
	//            if (typeof movie['_'+prop] !== 'undefined'){
	//                movie['_'+prop] = _css[prop];
	//                continue;
	//            }
	//            
	//            switch(prop){
	//                case 'bottom':
	//                    movie._y = Stage.height - _css[prop] - height;
	//                    continue;
	//                case 'right':
	//                    movie._x = Stage.width - _css[prop] - width;
	//                    continue;
	//                case 'top':
	//                    movie._y = _css[prop];
	//                    continue;
	//                case 'left':
	//                    movie._x = _css[prop];
	//                    continue;
	//                case 'backgroundColor':
	//                    movie.beginFill(_css[prop],_css['opacity'] || 100);
	//                    movie.moveTo(0,0);
	//                    movie.lineTo(0,0);
	//                    movie.lineTo(width,0);
	//                    movie.lineTo(width,height);
	//                    movie.lineTo(0,height);
	//                    movie.lineTo(0,0);
	//                    movie.endFill();
	//                    continue;
	//            }
	//            Bada.log('unknown css prop',prop);
	//        }
	//        return movie;
	//}

	public static function totalDepth(movie: MovieClip) : Number {
		var depth = movie.getDepth();
		var parent: MovieClip = movie._parent;
		var parentsDepth: Number = parent.getDepth();
		while (parentsDepth > -1) {
			depth += parentsDepth;
			parent = parent._parent;
			parentsDepth = parent.getDepth();

		}
		return depth;
	}

	public static function createMovieClip(parent: MovieClip, id: String, css: Object) : MovieClip {
		if (id == null) id = 'simplemovie' + parent.getNextHighestDepth();
		parent.createEmptyMovieClip(id, parent.getNextHighestDepth());
		var movie = parent[id];
		movie._xscale = 100;
		movie._yscale = 100;
		return movie;
	}

	/*public static function createTextField(container: MovieClip, text: String, data: Object) : TextField {
		var depth = container.getNextHighestDepth();
		depth++;
		container.createTextField('text' + depth, depth, data.x, data.y, data.width || 200, data.height || 200);
		var $text = container['text' + depth];
		$text.textColor = data.color || 0xFFFFFF;
		$text.bold = data.bold || false;
		$text.autoSize = data.autoSize || 'none';
		$text.text = text;

		var font = new TextFormat();
		font.size = data.fontSize || 20;
		font.align = 'center';

		if (data.font) {
			font.font = data.font;
			$text.embedFonts = true;
		}

		$text.multiline = true;
		$text.wordWrap = true;

		$text.setTextFormat(font);

		$text._font = font;
		return $text;
	}*/

	/*public static
	function createLoadedMovie(parent: MovieClip, url: String, _css: Object) : MovieClip {
		var movie = Utils.createMovieClip(parent);
		Utils.loadMovie2(movie, url);

		if (_css) {
			movie.css(_css);
		}

		return movie;
	}*/

	public static function setColor(movie: MovieClip, color: Number) {		
		var _transform: Transform = new Transform(movie);
		var _colorTransform: ColorTransform = new ColorTransform();
		if (color > 16777215) color = 16777215;
		else if (color < 0) color = 0;
		_colorTransform.rgb = color;
		_transform.colorTransform = _colorTransform;
	}
	
	public static function setMask(movie:MovieClip, width:Number, height:Number) {		
		var mask1 = Utils.createMovieClip(movie, 'mask1');
        mask1._x = 0;
        mask1._y = 0;
        mask1.beginFill(0xFF0000);
        mask1.lineTo(0, 0);
        mask1.lineTo(width, 0);
        mask1.lineTo(width, height);
        mask1.lineTo(0, height);
        mask1.lineTo(0, 0);
        mask1.endFill();
		
		movie.setMask(mask1);
		
		mask1._height = height;
        mask1._width = width;
	}
}