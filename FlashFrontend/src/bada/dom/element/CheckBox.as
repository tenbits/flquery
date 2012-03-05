import bada.dom.element.Div;
import bada.Utils;

/**
 * ...
 * @author ...
 */
class bada.dom.element.CheckBox extends Div
{
	private var _checked:Boolean;	
	
	public function CheckBox() 
	{	
		this._tagName = 'checkbox';
		var data:Object = super.init.apply(this, arguments);				
		this.checked = data.checked != null ? data.checked : false;
		
		this.bind('touchEnd', Function.bind(function() {
			this.checked = !this.checked;
			return false;
		},this));
		
	}
	
	public function render() {
		super.render();
		var $img:MovieClip = this._movie.backgroundImage;
		if ($img != null){		
			var height:Number = $img._height / 2,
			width:Number = $img._width;
			Utils.setMask(this._movie, width, height);		
			$img._x = 0;
			$img._y = this._checked ? 0 : height * -1;			
		}
	}
	
	public function get height():Number {
		return super.height / 2;
	}
	
	public function get checked():Boolean 
	{
		return this._checked;
	}	
	public function set checked(value:Boolean):Void 
	{
		this._checked = value;
		var img:MovieClip = this._movie.backgroundImage;
		img._y = this._checked ? 0 : (img._height / 2) * -1;	
		
		this.trigger('onchange');
	}
	
	
}