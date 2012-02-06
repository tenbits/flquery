import bada.dom.element.Div;
import bada.dom.Dom;
import bada.dom.element.Span;
import bada.Proxy;

/**
 * ...
 * @author tenbits
 */
class bada.dom.element.Input extends Div
{
	//private  var _textField:TextField;
	//private  var _font:TextFormat;
	private var $span:Span;
	public function Input() 
	{
		this._tagName = 'input';
		var data:Object = super.init.apply(this,arguments);
		
		
		/*css( {
			width:347,
			height:48,
			backgroundImage:'resources/800/background/input.png'
		});*/
		
		data._css.x = this.style.paddingLeft;
		data._css.y = this.style.paddingTop;
		data._css.width = this.width - this.style.paddingLeft - this.style.paddingRight;
		data._css.height = this.height - this.style.paddingTop - this.style.paddingBottom;
		delete data._css.backgroundImage;
		delete data._css.backgroundGradient;
		delete data._css.backgroundColor;
		
		this.$span = new Span(this, { _text: data._text || ' ', _css: data._css});
		
		var _textField:TextField = this.$span.textField;
		_textField.type = 'input';
		//_textField.wordWrap = false;
		
		/*_textField.text = data._text || '';
		_textField.textColor = 0xfafafa;
		
		_font = new TextFormat();
		_font.align = 'center';
		_font.size = 32;
		_textField.setTextFormat(_font);
		*/
		_textField.onChanged = Function.bind(function() {
			this.$span.text(this.$span.text());						
		},this);
		
		if (Bada.multitouchEnabled){
			this.bind('touchEnd', Function.bind(function() {
				Dom.focused = this;
				Proxy.service('ForceKeypad', this.$span.text());				
			}, this));
		}
		/*var lineHeight:Number = 38;
		if (_textField.textHeight < lineHeight) {
			_textField._y -= Math.floor((_textField.textHeight - lineHeight) / 2);
		}*/
	}
	
	public function text():Object {
		if (arguments[0] != null) {
			//this._textField.text = arguments[0];
			this.$span.text(arguments[0]);
			this.trigger('onchange', arguments[0]);
			return this;
		}
		else return this.$span.text();
		//return this._textField.text;
		
	}
	
}