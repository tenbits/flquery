﻿import bada.dom.CSS;
import bada.dom.css.CSSEngine;
import bada.dom.element.INode;
import bada.dom.element.Div;
import bada.Helper;

class bada.dom.element.Span extends INode{
    
	private var _html:String;
	private var _text: String;
	public var _font:TextFormat;
    
	private var _shadowSpan:Span;
	
	/**
	 * @param Div as parent, String as htmlText
	 * @param data as Object or as css object
	 */
	function Span() {
		this._tagName = 'span';
		super.init.apply(this, arguments);
		
		this.style.height = -1; // 'auto';
		
		if (arguments[0] instanceof Div) {
			_parent = arguments[0];
			var data = arguments[1];
			this._name = data._name;
			this._id = data._id;
			this._html = data._html;
			this._css = data._css;
			this._text = data._text;
			
			this.render();
		}
		else if (typeof arguments[0] == 'string'){
			this._text = arguments[0];
			this._css = arguments[1];			
		}
		
		this._css.wordWrap = true;
		
	}
	
	public function text(){
		
		if (arguments.length == 0){
			return _textField.text;
		}
		
		var text = '';
		for(var i = 0; i< arguments.length; i++){
			text+=arguments[i];
			if (i < arguments.length - 1){
				text+= ' ';
			}
		}
		this._html = null;
		this._textField.html = false;
		
		_textField.text = (this._text = text);
		_textField.setTextFormat(_font);
		
		if (this._shadowSpan){
			this._shadowSpan.text(text);            
		}
		
		return this;
	}
	
	public function html() {
		if (arguments.length == 0){
			return _textField.htmlText;
		}		
		this._textField.html = true;
		this._textField.htmlText = (this._text = arguments[0]);
		this._textField.setTextFormat(this._font);   
		
		if (this._shadowSpan){
			this._shadowSpan.html(arguments[0]);            
		}
	}
    
    
    public function render() : INode {
        
		var p = this._parent;
		var parentMovie:MovieClip = this.parent.style.overflow == 'scroll' ? p.scroller.scroller._movie : p._movie;
		
		var depth = parentMovie.getNextHighestDepth();
		
		
		if (this._css.textShadow) {            
			this._shadowSpan = (new Span(this._text)).appendTo(this._parent);  
			this._parent._children.splice(this._parent._children.length - 1,1);
			depth++;
		}
		
		CSSEngine.parseClass(this);	
		this.style.inheritCss(this.parent.style, this._css);
		
		CSSEngine.calculateCss(this, this._css);
		
		//CSS.prepairCss(span, span._css);
		
		parentMovie.createTextField('text' + depth, depth, this.style.x, this.style.y, this.style.width || 200, this.style.height || 40);
		this._textField = parentMovie['text' + depth];
		this._textField.multiline = true;
		this._textField.wordWrap = true;
		this._textField.autoSize = true;
		
		
		if (this._html) {
			this._textField.multiline = true;
			this._textField.html = true;
			this._textField.htmlText  = this._html;						
		}else {
			this._textField.text = this._text || '';			
		}        
		
		Bada.log('rendered span', this.style.width, this.style.height, this._text, this._textField);
		//CSS.renderCss(span);
		CSSEngine.render(this, this._css);
		
		if (this.style.verticalAlign == 'middle') {
			var height = this._textField.textHeight;
			var lineheight = this.style.height;
			
			var dy = (lineheight - height) / 2;
			if (dy > 0) {
				this._textField._y += dy;
			}
		}
		
		/** [size,color,dx,dy,alpha] */
		if (this._shadowSpan) {
			this._shadowSpan._css = Helper.extend(null, this._css);
			this._shadowSpan._css.fontSize += this._shadowSpan._css.textShadow[0];
			
			this._shadowSpan._css.color = this._shadowSpan._css.textShadow[1] || 0x000000;
			this._shadowSpan._css.alpha = this._shadowSpan._css.textShadow[4] || 80;
			
			//delete this._shadowSpan._css.verticalAlign;
			delete this._shadowSpan._css.textShadow;
			delete this._shadowSpan._css.position;
			
			this._shadowSpan._css.width = '100%';
			
			this._shadowSpan.x = this._textField._x + (this._css.textShadow[2] || 0);
			this._shadowSpan.y = this._textField._y + (this._css.textShadow[3] || 0);
			this._shadowSpan.width = this._textField._width;
			this._shadowSpan.height = this._textField._height;
			CSSEngine.render(this._shadowSpan);
		}
		
        return this;
    }
    
	public function toggle():INode{
		var visible = (typeof arguments[0] == 'boolean') ? arguments[0] : !_textField._visible;
		
		this._textField.toggle(visible);
		if (this._shadowSpan) this._shadowSpan.toggle(visible);
		return this;
	}
	
	public function remove() {
		this._textField.removeTextField();
		this._textField = null;
		if (this._shadowSpan) this._shadowSpan.remove();
	}
	
	public function applyCss(key:String):Void {
		var value = this.style[key];
		
		if (value == null) {
			Bada.log('Error # Span.applyCss: undefined value', key, this._css[key]);
			return;
		}
		
		switch(key) {
			case 'color':
				_textField.textColor = value;
				return;
			case 'bold':
				_textField.bold = value;
				return;
			case 'wordWrap':
				_textField.wordWrap = value;
				return;
			case 'autoSize':
				_textField.autoSize = value;
				return;
			case 'display':
				if (value === 'none') toggle(false);
				return;
			case 'textShadow':
				//createShadow(value);
				return;
			case 'background':
				_textField.background = value;
				return;
			case 'backgroundColor':
				_textField.background = true;
				_textField.backgroundColor = value;
				return;
			/* text format properties, so no return and set textFormat on the end*/
			case 'fontSize':
				if (_font == null) _font = new TextFormat();
				_font.size = value;
				break;
			case 'fontFamily':
				if (value == '') return;
				if (_font == null) _font = new TextFormat();
				_font.font = value;
				_textField.embedFonts = true;
				break;
			case 'textAlign':
				if (_font == null) _font = new TextFormat();
				_font.align = value;
				break;
			default: 
				if (_font == null) _font = new TextFormat();
				_font[key] = value;
		}
		if (this._css.autoSize == 'center') _font.align = 'center';
		
		
		_textField.setTextFormat(_font);
		
	}
	
	public function appendTo(parent:INode):Span {
		if (this._textField != null) this.remove();			
		parent.append(this);
		return this;
	}
	
	public function get height():Number {
		if (this.style.height == -1) return this._textField.textHeight;
		return this.style.height;
	}
	public function set height(value) {
		this._textField._height = (this.style.height = value);
	}
	
	public function get width():Number {
		if (this.style.width == -1) return this._textField.textWidth;
		return this.style.width;
	}
	public function set width(value) {
		this._textField._width = (this.style.width = value);
	}
	
	public function set x(value:Number):Void {
		_textField._x = (this.style.x = value);
	}
	public function get x():Number {
		return _textField._x;
	}
	public function set y(value:Number):Void {
		_textField._y = (this.style.y = value);
	}
	public function get y():Number {
		return _textField._y;
	}
}