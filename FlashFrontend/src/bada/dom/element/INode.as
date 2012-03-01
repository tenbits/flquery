import bada.*;
import bada.dom.*;
import bada.dom.animation.AnimationHelper;
import bada.dom.css.CssClass;
import bada.dom.css.CSSEngine;
import bada.dom.css.StyleSheet;
import bada.dom.element.Div;
import bada.dom.events.*;
import bada.dom.helper.*;
import caurina.Rotator;
import caurina.transitions.*;
import flash.display.*;
import flash.geom.Point;

class bada.dom.element.INode{
	private static var _counter:Number = 0;


	public static function render():INode{
		return null;
	}

	private var _index:Number;
	private var _movie: MovieClip;

	private var _textField:TextField;

	public var _canvas:BitmapData;
	
	public var _css: Object;	
	public var _classNames:Object; 
	public var _classes:/*bada.dom.css.CssClass*/ Array;
	public var _mergedCss:Object;
	
	public var _id: String;
	public var _name: String;
	public var _tagName:String;
	public var _parent: INode;
	public var _children:Array;
	public var _events:EventHandler;

	public var onresize:Function;

	public var style:StyleSheet;
	public var enabled:Boolean;

	public function INode(id:String){
		_counter++;		
		//this.style = new StyleSheet(this);
	}
	
	private function init() {
		this.style = new StyleSheet(this);
	}
	
	/** override */
	public function append() { }
	public function applyCss() {}
	
	public function animate():INode{
		if (arguments[0] === false){
			//Tweener.removeTweens(_movie);
			Tweener.removeTweens(this);
		}else{
			var data = arguments[0];
			if (data.transition == null) data.transition = 'linear';
			if (_movie){
				//Tweener.addTween(_movie,data);
				Tweener.addTween(this, data);
			}
		}
		return this;
	}
    
	public function get animating():Boolean{
		return Tweener.isTweening(_movie);
	}

	public function get movie():MovieClip {
		//if (this.style.overflow == 'scroll') return this._movie.scroller;		
		return this._movie;
	}
	
	public function get textField():TextField{
		return _textField;
	}
	
	public function get parent():INode{
		return _parent;
	}

	
	public function getDepth(total:Boolean):Number{
		if (total == true)  return Utils.totalDepth(this._movie);        
		if (this._movie) return this._movie.getDepth();
		if (this._textField) return this._textField.getDepth();
	}

    public function css():INode{
		if (typeof arguments[0] == 'object') {
			var css_ = arguments[0];			
			Helper.extend(this._css, css_);			
			CSSEngine.calculateCss(this, css_);			
			CSSEngine.render(this, css_);						
		}
		else if (typeof arguments[0] === 'string'){
			if (arguments.length == 1) {
				if (_css && typeof _css[arguments[0]] != 'undefined'){
					return _css[arguments[0]];
				}
				if (typeof _movie['_'+arguments[0]] != 'undefined'){
					return _movie['_'+arguments[0]];
				}				
				return Defaults.get(arguments[0]);
			}else{
				var css_ = {};
				css_[arguments[0]] = arguments[1];				
				this.css(css_);
			}
		}
		return this;
	}
	
	public function ztop():INode {
		this._movie.swapDepths(this._movie._parent.getNextHighestDepth());
		return this;
	}

	/** get absolute point */
	public function offset():Object{
		var _offset = {x:-1,y:-1};
		this._movie.localToGlobal(_offset);		
		if (Bada.smallscreen) {
			_offset.x *= 2;
			_offset.y *= 2;
		}
		return _offset;
	}


	
	public function visible() {
		if (arguments.length == 0) {
			return this._movie._visible;
		}else {
			if (this._movie != null)
				this._movie._visible = arguments[0];
			else if (this._textField != null)
				this._textField._visible = arguments[0];
		}
		return this;
	}
    
	public function toggle():INode{
		var visible:Boolean = (typeof arguments[0] === 'boolean') ? arguments[0] : !_movie._visible;
		if (visible == _movie._visible) return this;
		if (visible) {
				_movie._visible = true;
				_movie._x = this._css._x;
				_movie._y = this._css._y;
				
				//_movie.play();
			} else {
				
				this._css._x =  this._css.x || _movie._x;
				this._css._y =  this._css.y || _movie._y;
				
				_movie._visible = false;
				_movie._x += 2000;
				_movie._y += 2000;
				_movie.stop();
				_movie.enabled = false;
				
			}
			
        return this;
    }

    //** selectors */
    private function match(selector:String):Boolean{
        if (selector == null) return true;
		
		var c:String = selector.charAt(0);
		switch(c) {
			case '#':
				return this._id != null && selector === '#' + this._id;
			case '_':
				return this._name != null && selector === '_' + this._name;
			case '.':
				return this._classNames != null && this._classNames.hasOwnProperty(selector);
			case 's':
				if (selector.indexOf('style[', 0) == 0) {
					var paar = selector.substring(6, selector.length - 1).split('=');
					return this.style[paar[0]] == paar[1];
				}
			default:
				return this._tagName == selector;
		}
		
        return false;
    }
    public function children():NodeCollection{

        var list = new NodeCollection();
        if (_children == null) return list;

        var selector:String = null;
        if (typeof arguments[0] == 'string') selector = arguments[0];

        for(var i = 0; i< _children.length; i++){
            if (_children[i].match(selector)) list.append(_children[i]);
        }
        return list;
    }
    public function find(selector:String):INode {
		for (var i:Number = 0; i < this._children.length; i++)
		{
			if (this._children[i].match(selector)) return this._children[i];
		}
		for (var j:Number = 0; j < this._children.length; j++)
		{
			var found:INode = this._children[j].find(selector);
			if (found != null) return found;
		}
		return null;
	}
	
	public function findAll(selector:String):NodeCollection {
		var collection:NodeCollection = arguments[1];
		if (collection == null) collection = new NodeCollection();
		
		for (var i:Number = 0; i < this._children.length; i++)
		{
			if (this._children[i].match(selector)) collection.append(INode(this._children[i]));
		}
		for (var j:Number = 0; j < this._children.length; j++)
		{
			this._children[j].findAll(selector,collection);
		}
		return collection;
	}
	
	/**
	 * Find first element in children only!
	 * @param	selector - optional: #selector{id-selector} _selector{name-selecor} .selector{class-selector} selector{tag-selector}
	 * @return
	 */
	public function first(selector:String):INode{
		if (_children == null) return null;
		if (selector == null) return this._children[0];

		for(var i = 0; i< _children.length; i++){
			if (_children[i].match(selector)) return _children[i];
		}		
		/*for (var i = 0; i < _children.length; i++) {
			if (_children[i].first instanceof Function) {
				var child = _children[i].first(selector);
				if (child !== null) return child;
			}
		}*/		
		return null;
	}
	
	/**
	 * @see first
	 */
	public function last(selector:String):INode {
		if (this._children == null) return null;
		if (selector == null) return this._children[this._children.length - 1];
		for (var i = this._children.length - 1; i > -1; i--) {
			if (this._children[i].match(selector)) return this._children[i];
		}
		return null;
	}
	
	/**
	 * @see first
	 */
	public function next(selector:String):INode {
		var found:Boolean,
		parents:Array = this.parent._children,
		length:Number = parents.length;
		
		for (var i:Number = 0; i < length; i++) 
		{
			if (found && parents[i].match(selector)) return parents[i];
			if (!found && parents[i] == this) {
				if (selector == null) return parents[i + 1];
				found = true;
			}
		}
		return null;
	}
	
	public function childAt():Number {
		for (var i:Number = 0; i < this._parent._children.length; i++) 
		{
			if (this._parent._children[i] === this) return i;
		}
		return -1;
	}
	
	/**
	 * if no current node found, return prev. from end;
	 */
	public function prev(selector:String):INode {
		var found:Boolean,
		parents:Array = this.parent._children,
		length:Number = parents.length;
		
		for (var i:Number = length - 1; i > -1; i--) 
		{
			if (found != null && parents[i].match(selector)) return parents[i];
			if (found == null && parents[i] == this) {
				if (selector == null) return parents[i - 1];
				found = true;
			}
		}
		if (found != null) return null;		
		for (var i:Number = length - 1; i > -1; i--) {
			if (parents[i].match(selector)) return parents[i];
		}
		
		return null;
	}
	
	public function empty():INode {
		if (this._canvas instanceof BitmapData) {
			this._canvas.dispose();
			this._canvas = null;
		}
		
		if (this._children == null) return this;
		for(var i = 0,length = this._children.length; i< this._children.length; i++){
			this._children[i].remove();
			if (length > this._children.length) {
				length = this._children.length;
				i--;
			}
		}
		this._children.splice(0);
		return this;
	}
	
	public function remove():INode {
		if (this._movie != null) {
			this._movie.removeMovieClip();
			this._movie = null;
		}
		else if (this._textField != null) {
			this._textField.removeTextField();
			this._textField = null;
		}
		
		this.unbind();
		for (var j:Number = 0, length = this._children.length; j < length; j++)
		{
			this._children[j].remove();
			if (length > this._children.length) {
				length = this._children.length;
				j--;
			}
		}		
		this._children.splice(0);		
		if (this._canvas != null) {
			this._canvas.dispose();
			this._canvas = null;
		}		
		if (this._parent != null) {
			for (var i:Number = 0; i < this._parent._children.length; i++)
			{
				if (this._parent._children[i] == this) {
					this._parent._children.splice(i, 1);
				}
			}
		}
		return this;		
	}
	

    /** events handler */
	public function bind(event:String, handler:Function):INode {
		
		if (this._events == null) this._events = new EventHandler();
		this._events.bind(event, handler);
		
		if (typeof this._movie === 'movieclip') EventManager.bind(this, event, handler);
		return this;
	}
	public function unbind(arg:Object):INode {
		if (this._events != null) this._events.unbind(arg);
		EventManager.unbind(this, arg);
		return this;
	}

	public function trigger():Boolean {
		var r:Boolean;
		if ((arguments[1] instanceof Event) == false) {
			arguments.splice(1, 0, new Event(this));
		}
		Event(arguments[1]).currentTarget = this;
		if (this._events) r = this._events.trigger.apply(this._events, arguments);
		if (r == false) return false;
		for (var i:Number = 0; i < this._children; i++)
		{
			if (this._children[i]._events == null) continue;
			
			r = this._children[i]._events.trigger.apply(this._children[i]._events, arguments);
			if (r == false) return false;
		}
		return true;
	}

	public function hover(start:Function, end:Function):INode {
		EventManager.hover(this, start, end);
		return this;
	}
	
	public function touchEnd(callback:Function):INode {
		return this.bind('touchEnd', callback);
	}
	public function touchStart(callback:Function):INode {
		return this.bind('touchStart', callback);
	}

	/** casting */
	public function asSpan():bada.dom.element.Span{
		return bada.dom.element.Span(this);
	}
	public function asDiv():Div{
		return Div(this);
	}
	
	/**
	 * Properties
	 */
	public function get scale():Number{
		return _movie._xscale;
	}
	public function set scale(value:Number):Void{
		var width_:Number = this.width,
		height_:Number = this.height,
		dx:Number = 0,
		dy:Number = 0;
		
		this._movie._xscale = value;
		this._movie._yscale = value;
		this._movie._x = width_ / 2 - width_ * value / 200 + this.style.x;
		this._movie._y = height_/2 - height_ * value / 200 + this.style.y;
	}
	
	public function set opacity(value:Number):Void {
		this._movie._alpha = (this.style.opacity = value);
	}
	public function get opacity():Number{
		return _movie._alpha;
	}
	
	public function set width(value:Number):Void {
		this.style.width = value;		
	}
	public function get width():Number {
		if (this.style.width != -1)  return this.style.width;		
		if (this._css.width != null) return this._css.width;
		if (this._mergedCss.width != null) return this._mergedCss.width;
		return 0;
	}
	public function set height(value:Number):Void {
		this.style.height = value;
	}
	
	public function get height():Number {
		if (this.style.height != -1) return this.style.height;
		if (this._css.height != null) return this._css.height;
		if (this._mergedCss.height != null) return this._mergedCss.height;
		return 0;
	}
	public function set x(value:Number):Void {
		this.style.x = value;		
		if (this._movie != null) _movie._x = this.style.x;
		else _textField._x = this.style.x;
	}
	public function get x():Number {
		return this.style.x;
	}
	public function set y(value:Number):Void {
		this.style.y = value;
		if (this._movie != null) this._movie._y = this.style.y;
		else _textField._y = this.style.y;
	}
	public function get y():Number {
		return this.style.y;
	}
	
	public function get rotation():Number {
		return this._movie ? this._movie._rotation : this._textField._rotation;
	}
	
	public function set rotation(value:Number):Void {
		var pivot:Point = this.style.rotationPivot;
		Rotator.rotateNode(this, 
			(this.style.rotation = value),  
			pivot != null ? pivot.x : null, 
			pivot != null ? pivot.y : null,
			this.width,
			this.height);
	}
	
	/**margins*/
	/*public function set marginLeft(value:Number):Void {
		_movie._y += (_css.marginLeft = value);
    }
    public function get marginLeft():Number {
		return (_css.marginLeft == null) ? Defaults.get('marginLeft') : _css.marginLeft;
    }
	public function set marginRight(value:Number):Void {
		_movie._y += (_css.marginRight = value);
    }
    public function get marginRight():Number {
		return (_css.marginRight == null) ? Defaults.get('marginRight') : _css.marginRight;
    }
	
	public function set marginTop(value:Number):Void {
		_movie._y += (_css.marginTop = value);
    }
    public function get marginTop():Number {
		return (_css.marginTop == null) ? Defaults.get('marginTop') : _css.marginTop;
    }
	public function set marginBottom(value:Number):Void {
		_movie._y += (_css.marginBottom = value);
    }
    public function get marginBottom():Number {
		return (_css.marginBottom == null) ? Defaults.get('marginBottom') : _css.marginBottom;
    }*/
	
	/**paddings*/
	/*public function set paddingLeft(value:Number):Void {
		if (typeof value === 'string') value = parseInt(String(value));
		_css.paddingLeft = value;
    }
    public function get paddingLeft():Number {
		return (_css.paddingLeft == null) ? Defaults.get('paddingLeft') : _css.paddingLeft;
    }
	public function set paddingRight(value:Number):Void {
		if (typeof value === 'string') value = parseInt(String(value));
		_css.paddingRight = value;
    }
    public function get paddingRight():Number {
		return (_css.paddingRight == null) ? Defaults.get('paddingRight') : _css.paddingRight;
    }
	public function set paddingTop(value:Number):Void {
		if (typeof value === 'string') value = parseInt(String(value));
		_css.paddingTop = value;
    }
    public function get paddingTop():Number {
		return (_css.paddingTop == null) ? Defaults.get('paddingTop') : _css.paddingTop;
    }
	public function set paddingBottom(value:Number):Void {
		if (typeof value === 'string') value = parseInt(String(value));
		_css.paddingBottom = value;
    }
    public function get paddingBottom():Number {
		return (_css.paddingBottom == null) ? Defaults.get('paddingBottom') : _css.paddingBottom;
    }*/
	// --
	/** borders */
	
	/** top */
	/*public function set borderTopColor(value:Number):Void {
		_css.borderTopColor = value;
    }
    public function get borderTopColor():Number {
		return (_css.borderTopColor == null) ? 0x000000 : _css.borderTopColor;
    }
	public function set borderTopWidth(value:Number):Void {
		_css.borderTopWidth = value;
    }
    public function get borderTopWidth():Number {
		return (_css.borderTopWidth == null) ? undefined : _css.borderTopWidth;
    }
	public function set borderTopOpacity(value:Number):Void {
		_css.borderTopOpacity = value;
    }
    public function get borderTopOpacity():Number {
		return (_css.borderTopOpacity == null) ? 100 : _css.borderTopOpacity;
    }*/
	
	/** right */
	/*public function set borderRightColor(value:Number):Void {
		_css.borderRightColor = value;
    }
    public function get borderRightColor():Number {
		return (_css.borderRightColor == null) ? 0x000000 : _css.borderRightColor;
    }
	public function set borderRightWidth(value:Number):Void {
		_css.borderRightWidth = value;
    }
    public function get borderRightWidth():Number {
		return (_css.borderRightWidth == null) ? undefined : _css.borderRightWidth;
    }
	public function set borderRightOpacity(value:Number):Void {
		_css.borderRightOpacity = value;
    }
    public function get borderRightOpacity():Number {
		return (_css.borderRightOpacity == null) ? 100 : _css.borderRightOpacity;
    }*/
	
	/** bottom */
	/*public function set borderBottomColor(value:Number):Void {
		_css.borderBottomColor = value;
    }
    public function get borderBottomColor():Number {
		return (_css.borderBottomColor == null) ? 0x000000 : _css.borderBottomColor;
    }
	public function set borderBottomWidth(value:Number):Void {
		_css.borderBottomWidth = value;
    }
    public function get borderBottomWidth():Number {
		return (_css.borderBottomWidth == null) ? undefined : _css.borderBottomWidth;
    }
	public function set borderBottomOpacity(value:Number):Void {
		_css.borderBottomOpacity = value;
    }
    public function get borderBottomOpacity():Number {
		return (_css.borderBottomOpacity == null) ? 100 : _css.borderBottomOpacity;
    }*/
	
	/** left */
	/*public function set borderLeftColor(value:Number):Void {
		_css.borderLeftColor = value;
    }
    public function get borderLeftColor():Number {
		return (_css.borderLeftColor == null) ? 0x000000 : _css.borderLeftColor;
    }
	public function set borderLeftWidth(value:Number):Void {
		_css.borderLeftWidth = value;
    }
    public function get borderLeftWidth():Number {
		return (_css.borderLeftWidth == null) ? undefined : _css.borderLeftWidth;
    }
	public function set borderLeftOpacity(value:Number):Void {
		_css.borderLeftOpacity = value;
    }
    public function get borderLeftOpacity():Number {
		return (_css.borderLeftOpacity == null) ? 100 : _css.borderLeftOpacity;
    }*/
	
	
	
	/** border radius */
	/*public function set borderRadiusTopLeft(value:Number):Void {
		_css.borderRadiusTopLeft = value;
	}
	public function get borderRadiusTopLeft():Number {
		return (_css.borderRadiusTopLeft == null) ? 0 : _css.borderRadiusTopLeft;
	}
	public function set borderRadiusTopRight(value:Number):Void {
		_css.borderRadiusTopRight = value;
	}
	public function get borderRadiusTopRight():Number {
		return (_css.borderRadiusTopRight == null) ? 0 : _css.borderRadiusTopRight;
	}
	public function set borderRadiusBottomRight(value:Number):Void {
		_css.borderRadiusBottomRight = value;
	}
	public function get borderRadiusBottomRight():Number {
		return (_css.borderRadiusBottomRight == null) ? 0 : _css.borderRadiusBottomRight;
	}

	public function set borderRadiusBottomLeft(value:Number):Void {
		_css.borderRadiusBottomLeft = value;
	}
	public function get borderRadiusBottomLeft():Number {
		return (_css.borderRadiusBottomLeft == null) ? 0 : _css.borderRadiusBottomLeft;
	}*/


	/** movie */
	public function get xscale():Number {
		return this._movie._xscale;
	}
	public function set xscale(value):Void {
		this._movie._xscale = value;
	}
	public function get yscale():Number {
		return this._movie._yscale;
	}
	public function set yscale(value):Void {
		this._movie._yscale = value;
	}
	public function get alpha():Number {
		return this._movie._alpha;
	}
	public function set alpha(value):Void {
		this._movie._alpha = value;
	}
	
	/* animations */
	function fadeOut(time:Object):INode {
		if (time  == null) time = .4;
		AnimationHelper.fadeOut(this, time);
		return this;
	}
	function fadeIn(time:Object):INode {
		if (time  == null) time = .4;
		AnimationHelper.fadeIn(this, time);
		return this;
	}
	
	
	function hasClass(className:String):Boolean {
		if (this._classNames == null) return false;		
		return this._classNames.hasOwnProperty(className);
	}
	
	function addClass(className:String):INode {		
		if (this.hasClass(className)) return this;		
		var cssclass:CssClass = StyleSheets.getClassForNode(className, this);		
		
		if (this._classNames == null) this._classNames = { };
		this._classNames[className] = null;
		
		if (cssclass == null) return this;
		
		if (this._classes == null) this._classes = [];
		this._classes.push(cssclass);
		
		var css_ = Helper.extend(null, cssclass.css);
		CSSEngine.calculateCss(this, css_);			
		CSSEngine.render(this, css_);			
		
		return this;
	}
	
	function removeClass(className:String):INode {
		if (this._classNames == null) return this;
		/*if (this._classNames[className] == null) {
			delete this._classNames[className];
			return this;
		}
		*/
		if (this.hasClass(className) == false) return this;
		delete this._classNames[className];
		
		var class_:CssClass;
		for (var i:Number = 0; i < this._classes.length; i++) 
		{
			if (this._classes[i].className == className) {
				class_ = this._classes.splice(i, 1)[0];
				break;
			}
		}
		if (class_ == null) return this;
		
		
		var css_:Object = {};
		
		for (var j:Number = 0; j < this._classes.length; j++) 
		{
			Helper.extendOnly(css_, this._classes[j].css, class_.css);
		}		
		Helper.extendOnly(css_, this._css, class_.css);
		
		
		CSSEngine.calculateCss(this, css_);			
		CSSEngine.render(this, css_);					
		return this;
	}
	
	/*private var _hover:Object;
	public function set hover(value:Object) {
		this._hover = value;
		
		this.hover(
	}*/
}