import bada.dom.element.Div;
import bada.dom.Dom;
import bada.dom.helper.XmlParser;

/**
 * ...
 * @author tenbits
 */
class bada.dom.widgets.ToggleSlide extends Div
{
	private var _sliderWidth:Number;
	private var _status:Boolean;
	private var _slider:Div;
	
	public function ToggleSlide(parent:Div, data:Object) 
	{
		this._tagName = 'toggleSlide';
		data._css.backgroundImage = 'ex.toggleslide.png';
		super.init(parent, data);	
		
		this.append( {
			_css: {
				x: 5,
				backgroundImage : 'ex.slider_head.png'
			}
		});
		
		this.bind('touchEnd', Function.bind(this.toggle, this));	
		this._status = data.status;
		
		this._slider = this.first('div').asDiv();
		this._sliderWidth = this._slider.width;
		
		this._slider.x =  this._status ? 5 : this.width - this._sliderWidth - 5
		
	}
	
	
	private function toggle() {
		this._status = !this._status;
		this._slider.animate( {
			x: this._status ? 5 : this.width - this._sliderWidth - 5,
			time: 1,
			transition:'easeinout'
		});
		this.trigger('onchange',this._status);
	}
}