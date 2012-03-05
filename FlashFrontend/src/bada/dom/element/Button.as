import bada.dom.*;
import bada.dom.css.BackgroundHelper;
import bada.dom.element.*;
import bada.Helper;
import bada.Utils;

class bada.dom.element.Button extends Div{

	private var _text:String;
	private var _span:Span;

	function Button(parent:Div, data:Object) {		
		this._tagName = 'button';
		this._text = data._text;
		super.init.apply(this, arguments);			
	}

	private function render():INode {
		super.render();
		
		if (Button.clipdiv2(this) == false && this._hoverClass == null){
			this._hoverClass = 'hover';
			this.hover(this.addClass.bind(this, this._hoverClass), this.removeClass.bind(this, this._hoverClass));		
		}
		
		
		if (this._text != null) {
			this.renderText(this);
		}		
		return this;
	}

	public function remove() {
		if (this._span != null) this._span.remove();		
		super.remove();
	}

	public function text() {
		if (arguments.length == 0){
			return this._span == null ? '' : this._span.text();
		}
		if (this._span != null) {
			this._span.text.apply(this._span, arguments);
			return this;
		}
	}

    // helpers >>>>
	private static function hoverImageOn(movie:Button):Void {
		movie.movie.backgroundImage._y = 0;
	}
	private static function hoverImageOff(movie:Button):Void {
		var img = movie.movie.backgroundImage
		img._y = img._height / -2;
	}	
	private static function clipdiv2(button:Button):Boolean {
		
		var $img:MovieClip = button.movie.backgroundImage;
		if ($img == null) return false;
		
		var height:Number = $img._height / 2,
		width:Number = $img._width;
		
		
		Utils.setMask(button.movie, width, height);
		
		button.hover(hoverImageOn, hoverImageOff);
		
		$img._x = 0;
		$img._y = height * -1;
		
		button.style.height = height;
		return true;
	}
    
	private function renderText(button:Button) {
		if (button._text == null) return;
		
		var css = {
			//verticalAlign: 'middle',
			//textAlign: 'center',
			display: 'inline-block',
			position: 'static'
		};
		
		if (button.width > 0) {
			css.width = button.width;
		}
		
		button.style.padding = [5, 10, 5, 10];		
		button.append(new Span(button._text, css));		
	}

}