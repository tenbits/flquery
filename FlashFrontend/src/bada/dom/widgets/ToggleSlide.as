import bada.dom.element.Div;
import bada.dom.Dom;
import bada.dom.helper.XmlParser;

/**
 * ...
 * @author tenbits
 */
class bada.dom.widgets.ToggleSlide extends Div
{
	private var _width:Number;
	private var _sliderWidth:Number;
	private var _status:Boolean;
	private var _slider:Div;
	
	public function ToggleSlide() 
	{
		var data:Object = super.init.apply(this, arguments);		
		//this._css.backgroundImage = 'view-menu.panel_player.png';		
		this.append("<div style='x:5;' background='view-menu.slider_player.png'></div>");		
		this.bind('touchEnd', Function.bind(this.toggle, this));	
		this._status = data.status;
	}
	
	private function onresize() {	
		this._slider = this.first('div').asDiv();
		this._sliderWidth = this._slider.width;
		this._width = this.width;
		
		this._slider._movie._x =  this._status ? 5 : this._width - this._sliderWidth - 5
		
	}
	
	private function toggle() {
		this._status = !this._status;
		this._slider.animate( {
			_x: this._status ? 5 : this._width - this._sliderWidth - 5,
			time: 1,
			transition:'easeinout'
		});
		this.trigger('onchange',this._status);
	}
}