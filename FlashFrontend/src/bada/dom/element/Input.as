import bada.dom.element.Div;
import bada.dom.Dom;
import bada.dom.element.Span;
import bada.Helper;
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
		
		this.css( {
			height: this._mergedCss.height || 40,
			borderImage: ['src.resources.800.ex.input.bitmap.png', 16],
			padding: [0, 20,0, 20]
			//backgroundColor:0xff0000
		});
		
		
		Helper.extend(data._css, {
			x : this.style.paddingLeft,
			y : this.style.paddingTop,
			width : this.width - this.style.paddingLeft - this.style.paddingRight,
			height: this.height - this.style.paddingTop - this.style.paddingBottom  - 5,
			lineHeight: this.height - this.style.paddingTop - this.style.paddingBottom - 5,
			verticalAlign:'middle'
		});
		delete data._css.backgroundImage;
		delete data._css.backgroundGradient;
		delete data._css.backgroundColor;
		
		this.$span = new Span(this, { _text: data._text || ' ', _css: data._css});
		
		var _textField:TextField = this.$span.textField;
		_textField.selectable = true;
		_textField.autoSize = false;
		_textField.multiline = false;
		
		
		_textField.type = 'input';
		_textField.wordWrap = false;
		
		_textField.onChanged = Function.bind(function() {
			this.$span.text(this.$span.text());						
		},this);
		
		if (Bada.multitouchEnabled){
			this.bind('touchEnd', Function.bind(function() {
				Dom.focused = this;
				Proxy.service('ForceKeypad', this.$span.text());				
			}, this));
		}
		
		/*this.touchEnd(function() {
			Selection.setFocus(this.$span.textField);
			var length = this.$span.text().length;
			Selection.setSelection(0, length);
			
		}.bind(this));*/
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