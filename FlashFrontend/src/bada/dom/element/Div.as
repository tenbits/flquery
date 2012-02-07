import bada.dom.CSS;
import bada.dom.css.BackgroundHelper;
import bada.dom.css.BorderImage;
import bada.dom.css.CSSEngine;
import bada.dom.events.EventManager;
import bada.dom.helper.EventHandler;
import bada.dom.helper.XmlParser;
import bada.dom.element.INode;
import bada.dom.NodesFactory;
import bada.dom.Scroller;
import bada.dom.element.Span;
import bada.Graphics;
import bada.Helper;
import bada.Utils;
import bada.views.DebugView;
import flash.display.BitmapData;

class bada.dom.element.Div extends INode{
	public var dragging:Boolean;

	private var scroller:Scroller;
	private var _data:Object = null;



	public function data():Object{
		
		
		if (arguments.length == 1){
			return _data == null ? null : _data[arguments[0]];
		}
		if (arguments.length == 2){
			if (_data == null) _data = {};
			_data[arguments[0]] = arguments[1];
			return this;
		}
	}
    
    /**
     * @arguments:
     * 1. [_movie:MovieClip,_id:String,_css:Object,_class:Array||String]
     * 2. [_parent:Div, data:Object]
     *
     *  data:Object{_css,_class,_id}
     */
    public function Div() {
        	super(arguments[1]._id);		
		
		this._tagName = 'div';
		
		/** all child inheritances must call super.init explicit,
		 * 	or better this.__proto__.costructor.init.apply(this,arguments);
		 */
		if (this.__proto__ == Div.prototype) this.init.apply(this, arguments);		
    }
	
	private function init():Object {
		
		INode.prototype.init.apply(this, arguments);
		
		var data:Object;
		var args = Array.prototype.slice.call(arguments);
		if (args.length == 0) return data;
		var children:Array = null;
		if (args[0] instanceof Div) {
			data = args[1]
			this._parent = args[0];
		}else if (typeof args[0] === 'movieclip'){
			this._movie = args[0];
			this._id = args[1];
			this._css = args[2];
			this._class = args[3];
			CSSEngine.calculateCss(this, this._css);
		}else if (typeof args[0] === 'object') {
			if (args[0]._css != null) {
				data = args[0];				
			}else {
				this._css = args[0];
			}
		}
		if (data != null) {
			this._class = data._class || null;
			this._css = data._css || null;
			this._id = data._id || null;
			this._name = data._name || null;
			
			if (data.tag != null) this._tagName = data.tag;		
			children = data._children || null;			
			if (data._data) _data = data._data;				
		}
		
		//Bada.log('Div initialize', this._id, this.style);
		
		if (this._movie == null && this._parent != null) {			
			//this._children = children;			
			this.render(this);
			if (data && data.handler){
				if (data.handler.touchStart) this.bind('touchStart', data.handler.touchStart);
				if (data.handler.touchEnd) this.bind('touchEnd', data.handler.touchEnd);
			}			
		}
		
		if (children) this.append(children);
		
		return data;
	}
    
    private function render():Div {
		if (this._parent == null){
			Bada.log('div parent is null');
		}
		if (this._parent._movie == null) return this;
	   
		
		var m:MovieClip = this.parent.style.overflow == 'scroll' ? Div(this._parent).scroller.scroller._movie : this.parent._movie;
		//-this._movie = Utils.createMovieClip(this._parent.movie, this._id);		
		this._movie = Utils.createMovieClip(m, this._id);		
		
		
		CSSEngine.parseClass(this);
		
		if (this._css.backgroundImage) {
			/** width/height fix */
			CSSEngine.backgroundImage(this);
		}
		CSSEngine.calculateCss(this, this._css);
		
		this.style.inheritCss(this.parent.style, this._css);
		
		CSSEngine.render(this, this._css, true);
		
		if (this._children) {
			var _children = this._children;
			this._children = null;
			this.append(_children);
		}
		
		if (this._events) {
			EventManager.bindAll(this);
		}
		
		if (this.onresize instanceof Function) this.onresize();
		return this;
    }
	
	public function invalidate() {
		CSSEngine.calculateCss(this, this._css);
		CSSEngine.render(this, this._css);       
	}
    
	public static function create(movie:MovieClip, data:Object):Div{
		return new Div(movie, data);
	}
    
    
	public function append():Div{
		var children = arguments[0];
		if (this._children == null) this._children = [];
		//var container:Div = this.style.overflow == 'scroll' ? this.first('#scroller').asDiv() : this;
		
		var container:Div = this; // this.scroller == null ? this : this.scroller.scroller;
		
		if (container == null) {
			Bada.log('children', this._children.length, this._children[0]._id, this.movie.scroller);
		}
		
		if (typeof children === 'string') {
			children = XmlParser.parseHtml(children);	
		}

		if (children instanceof Array) {
			for (var i = 0, length = children.length, item; item = children[i], i < length; i++) {		
				if (item instanceof INode)  
					NodesFactory.create(container, item);				
				else 
					this._children.push(NodesFactory.create(container,item));
			}
		}
		else if (children instanceof Div) {
			children._parent = container;			
			this._children.push(Div(children).render());
		}
		else if (children instanceof Span) {
			children._parent = container;
			this._children.push(Span(children).render());
		}
		else if (typeof children === 'object') {
			if (children._name == 'scroller' || children._name == 'overflowMask') container = this;
			this._children.push(NodesFactory.create(container, children));
		}
		
		this.afterChildAppend(this._children[this._children.length - 1]);
		return this;
    }
	
	public function appendTo(parent:Div):Div {
		if (this._movie != null) {
			this._movie.removeMovieClip();
			if (this._canvas) this._canvas.dispose();
		}
		
		parent.append(this);
		return this;
	}
	
	public function applyCss(key:String) {
		switch(key) {		
			case 'borderImage':
				/** value: [resourceImageFile:String, broderSize:Number, cropp:Rectangle ] */
				var border:BorderImage = this.style.borderImage;
				if (border){
					this._canvas = Graphics.drawBorderImage(this._movie, 
								this.width, this.height, border.source, border.borderWidth, border.crop);
				}
				return;		
			case 'display':
				if (this.style.display == 'none') this.toggle(false);
				return;
			case 'overflow':
				if (this.style.overflow == 'scroll') {
					if (this.scroller == null) {
						var scrollerMovie:MovieClip = Utils.createMovieClip(this.movie, 'scroller');
						if (this._children && this._children.length) {
							Bada.log('Error # appeding scroller, but container has children');
						}
						
						var container:Div = (new Div(scrollerMovie, 'scroller', {
								x:0,
								y:0,
								width:this.width,
								height:this.height,
								padding: this._css.padding
						}));
						
						Bada.log('before init scroller',container.width, container.height);
						this.scroller = new Scroller(this, container);
						Bada.log('after init scroller', container);
					}else {
						this.scroller.refresh(this.width, this.height);
					}
				}
				return;
		}
	}
    
	
	private function afterChildAppend(child:INode) {
		if (this.style.overflow == 'hidden' || this.style.overflow == 'scroll') {
			var mask:MovieClip = this._movie.overflowMask;
			if (mask == null) {
				var bottom:Number = this.height,
				right = this.width,
				overflowed = false;
				
				if (child.y + child.height > bottom) overflowed = true;
				if (child.y < 0) overflowed = true;
				if (child.x < 0) overflowed = true;
				if (child.x + child.width > right) overflowed = true;
				
				if (overflowed) {
					mask = Utils.createMovieClip(this.movie, 'overflowMask');
					Graphics.fill(mask, 0xff0000, 100, this.width, this.height);
					this._movie.setMask(mask);
					break;
				}
			}	
			if (this.scroller != null) {
				scroller.refresh(child.x + child.width, child.y + child.height);
			}
		}
		
		if (this.style.position == 'static' && 
			this._css.height == null && 
			child.style.position == 'static' &&
			child.style.display !== 'none') {			
			
			this.style.height = child.y + child.height + this.style.paddingBottom;
			this.onChildResized(child);			
		}
		
		if (this._css.align == 'horizontal') {
			var width = this.width;
			var childs = this._children.length;
			var cell = width / childs;
			for (var i = 0; i < childs; i++) {
				this._children[i].x = cell * i + (cell - this._children[i].width) / 2;
			}
		}
		
		if (this._css.verticalAlign == 'middle') {
			child.y = (this.height - child.height) / 2;
		}
		
	}
	
	public function onChildResized(child:INode, lastChild:INode) {
		
		var pos:Number = child.childAt();
		var last:INode = child;
		if (pos > -1) {
			for (var i:Number = pos + 1; i < this._children.length; i++) 
			{
				if (this._children[i].style.position === 'static') {
					CSSEngine.reposition(this._children[i], last);
					last = this._children[i];
				}
			}
		}
		
		if (lastChild == null) lastChild = this.last('style[position=static]');
		
		this.style.height = lastChild.y + lastChild.height + this.style.paddingBottom;
		
		if (this.style.position === 'static') Div(this.parent).onChildResized(this);
		BackgroundHelper.render2(this);	
	}
	
	public function refreshScroll():Void {
		if (this._children.length == 0) return;
		
		this.afterChildAppend(this._children[this._children.length - 1]);
	}
	
	
	public function setMovie(movie:MovieClip):Div {
		this._movie = movie;
		return this;
	}
	
	public function cloneCanvas(source:MovieClip):Div {
		
		this._movie.clear();
		
		
		return this;
	}
}