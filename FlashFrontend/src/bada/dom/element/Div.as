﻿import bada.dom.css.BackgroundHelper;
import bada.dom.css.BorderImage;
import bada.dom.css.CSSEngine;
import bada.dom.element.INode;
import bada.dom.events.EventManager;
import bada.dom.helper.XmlParser;
import bada.dom.NodesFactory;
import bada.dom.Scroller;
import bada.dom.StyleSheets;
import bada.Graphics;
import bada.Helper;
import bada.Utils;

class bada.dom.element.Div extends INode{
	public var dragging:Boolean;

	private var scroller:Scroller;
	
	
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
			this._classNames = args[3];
			CSSEngine.calculateCss(this, this._css);
		}else if (typeof args[0] === 'object') {
			if (args[0]._css != null) {
				data = args[0];				
			}else {
				this._css = args[0];
			}
		}
		if (data != null) {
			if (data._class != null) {
				if (typeof data._class === 'string') {
					data._class = data._class.split(' ');
				}
				
				if (data._class instanceof Array) {
					this._classNames = { };
					for (var i:Number = 0; i < data._class.length; i++) 
					{
						if (data._class[i]) {
							this._classNames[data._class[i]] = null;
						}
					}
				}else {
					data._classNames = data._class;
				}
			}
			
			this._css = data._css || null;
			this._id = data._id || null;
			this._name = data._name || null;
			
			if (data.tag != null) this._tagName = data.tag;		
			children = data._children || null;			
			if (data._data) _data = data._data;	
			
			this._hoverClass = data.hover;
		}
		
		
		if (this._movie == null && this._parent != null) {			
			//-this._children = children;
			
			this.render(this);
			
			///this._parent.append(this);
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
		
		
		//-CSSEngine.parseClass(this);
		
		this._classes = StyleSheets.getClasses(this);
		this._mergedCss = this._classes == null ? this._css : Helper.extend(StyleSheets.combineClasses(this._classes), this._css);
		
		CSSEngine.calculateDimension(this, this._mergedCss);
		
		if (this._mergedCss.backgroundImage) {
			/** width/height fix */
			CSSEngine.backgroundImage(this, this._mergedCss);
		}
		
		
		CSSEngine.calculateCss(this, this._mergedCss);
		
		
		this.style.inheritCss(this.parent.style, this._mergedCss);
		
		CSSEngine.render(this, this._mergedCss, true);
		
		
		
		if (this._children) {			
			var _children = this._children;
			this._children = null;
			this.append(_children);
		}
		
		if (this._events) {
			EventManager.bindAll(this);
		}
		
		if (this._hoverClass != null) {
			this.hover(this.addClass.bind(this, this._hoverClass), this.removeClass.bind(this, this._hoverClass));			
		}
		
		
		if (this._parent._children == null) this._parent._children = [];
		this._parent._children.push(this);
		
		
		if (this.onresize instanceof Function) this.onresize();		
		return this;
    }
	
	/*public function invalidate() {
		CSSEngine.calculateCss(this, this._css);
		CSSEngine.render(this, this._css);       
	}*/
    
	public static function create(movie:MovieClip, data:Object):Div{
		return new Div(movie, data);
	}
    
    
	public function append():Div{
		var children = arguments[0];
		if (this._children == null) this._children = [];
		
		
		
		
		if (typeof children === 'string') {
			children = XmlParser.parseHtml(children);				
		}

		if (children instanceof Array) {
			for (var i = 0, length = children.length, item; item = children[i], i < length; i++) {		
				if (item instanceof INode)  {
					//-NodesFactory.create(container, item);				
					item._parent = this;			
					item.render();
				}
				else 
				{
					NodesFactory.create(this,item);
				}
			}			
		}
		else if (children instanceof INode) {
			children._parent = this;			
			children.render();
		}
		else if (typeof children === 'object') {
			//if (children._name == 'scroller' || children._name == 'overflowMask') container = this;
			NodesFactory.create(this, children);
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
				/*var border:BorderImage = this.style.borderImage;
				if (border){
					this._canvas = Graphics.drawBorderImage(this._movie, 
								this.width, this.height, border.source, border.borderWidth, border.crop);
				}*/
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
						
						this.scroller = new Scroller(this, container);						
					}else {
						this.scroller.refresh(this.width, this.height);
					}
				}
				return;
		}
	}
    
	
	private function afterChildAppend(child:INode) {
		if (child == null) return;
		
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
		
		//if (this.style.position === 'static') {
			var resized = false;
			if (this._mergedCss.height == null) {
				var h = child.y + child.height + this.style.paddingBottom;
				if (h > this.style.height) {
					this.style.height = h;				
					resized = true;
				}				
			}
			if (this._mergedCss.width == null) {
				var w = child.x + child.width + this.style.paddingRight;
				if (w > this.style.width) {
					this.style.width = w;
					resized = true;					
				}				
			}
			
			if (resized) {
				BackgroundHelper.render2(this);
				
				if (this._mergedCss.x === '50%') {
					this.x = (this.parent.width - this.width) / 2;
				}
				if (this._mergedCss.y === '50%') {
					this.y = (this.parent.height - this.height) / 2;
				}
				if (this._mergedCss.right != null) {
					this.x = this._parent.width - this._mergedCss.right - this._parent.style.paddingRight - this.width;
				}
				if (this._mergedCss.bottom != null) {
					this.y = this._parent.height - this._mergedCss.right - this._parent.style.paddingRight - this.width;
				}
				
				if (this.style.position === 'static'){
					this.parent.asDiv().onChildResized(this);			
				}
			}
			
			
		//}
		
		if (this._id == 'drp') {
			Bada.log('after child append', this.style.width);
		}
		
		if (this._mergedCss.textAlign == 'center') {			
			var width = this.width;
			var childs = this._children.length;
			var cell = width / childs;	
			for (var i = 0; i < childs; i++) {
				this._children[i].x = cell * i + (cell - this._children[i].width) / 2;
			}
		}
		
		if (this._mergedCss.verticalAlign == 'middle') {
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
	
		if (this.style.display == 'inline-block') {			
			/* 
			var width = 0;
			for (var j:Number = 0; j < this._children.length; j++) 
			{
				var node:INode = this._children[j];
				var w = node.width + node.y + node.style.marginRight + this.style.paddingRight;
				if (w > width) width = w;
			}*/
			var w = child.width + child.x + child.style.marginRight + this.style.paddingRight;
			if (this.style.width < w) {				
				this.style.width = w;
			}			
		}
		
		
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