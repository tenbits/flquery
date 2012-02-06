import bada.dom.*;
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
		/*this._movie = bada.Utils.createMovieClip(this._parent._movie, this._id);        
		CSS.prepairCss(this, this._css);
		CSS.renderCss(this);        	*/	
		super.render();
		Button.clipdiv2(this);
			
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
	private static function clipdiv2(button:Button):Void {
		var $img:MovieClip = button.movie.backgroundImage;
		if ($img == null) return;
		
		var height:Number = $img._height / 2,
        width:Number = $img._width;
		
		
		Utils.setMask(button.movie, width, height);
		
		button.hover(hoverImageOn, hoverImageOff);
		
        $img._x = 0;
        $img._y = height * -1;
    }
    
    private function renderText(button:Button) {
		if (button._text == null) return;
		
		var css = Helper.extend(null, button._css);
		delete css.x;
		delete css.y;
		css.height -= 4;
		
		if (css.verticalAlign == null) css.verticalAlign = 'middle';
		if (css.textAlign  == null) css.textAlign  = 'center';
		
		button._span = (new Span(button._text, css));		
		button._span._parent = button;			
		button._children.push(button._span.render());
	}

}