import bada.dom.element.Div;
import bada.Utils;
/**
 * ...
 * @author tenbits
 */
class bada.dom.element.Img extends Div
{
	public var src:String;
	public var onload:Function;
	
	public function Img(parent:Div, data:Object) 
	{
		this._tagName = 'img';
		this.src = data._src;
		this.onload = data.onload;		
		super.init.apply(this, arguments);		
	}
	
	private function onloaded(img:MovieClip) {
		if (this._css.textAlign == 'center')
			img._x = (this._movie._parent._width - img._width) / 2;
		if (this.onload != null) this.onload(this);
	}
	
	public function render() {		
		super.render();
		
		Utils.loadExternalMovie(this._movie, this.src, Function.bind(this.onloaded, this));	
		
	}
	
}