import bada.dom.css.BackgroundHelper;
import bada.dom.events.EventManager;
import bada.Events;
import bada.Graphics;
import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Rectangle;
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
			Bada.log('ATTACH FAIL', newurl, 'target:', target);		
		}
		
		if (Bada.smallscreen) {
			target[id]._xscale = 200;
			target[id]._yscale = 200;
		}
		return target[id];
	}

	

	public static function extend() {
		/** obsolete */
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
		
		Function.prototype.bind = function() {
			if (typeof arguments[0] == "undefined") return this;
			var args = arguments,
			// Array.prototype.slice.call(arguments),
			__method = this,
			object = args.shift();
			return function() {
				return __method.apply(object, args.concat(arguments));
			}
		}
		
		if (Bada.multitouchEnabled) {
			Events.bind("multitouch", function(event, x, y) {
				x = parseInt(x);
				y = parseInt(y);
				//handle hover
				for (var i:Number = 0; i < EventManager._hovers.length; i++) 
				{
					var movie = EventManager._hovers[i].movie;
					if (event == 'touchStart'){
						if (movie.hitTest(x, y, true)) {
							movie.onPress();
						}
					}
					else if (event == 'touchEnd' && movie.onMouseUp != null) {
						movie.onMouseUp();
					}
				}
				
				EventManager.evaluate(event, x, y);
			});
		}
		
		
		if (Bada.smallscreen) {
			/** workaround */
			Graphics.drawBorderImage = function(movie:MovieClip, w:Number, h:Number, resource:String, border:Number,  cropped:Rectangle) {
				BackgroundHelper.fillBackground(movie, 0x000000, w, h, 12, 60);
				return null;
			}
		}
		
		
	}


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