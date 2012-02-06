import bada.dom.element.Div;
import caurina.transitions.Tweener;
/**
 * ...
 * @author tenbits
 */
class bada.dom.Scroller
{
	private var containerMovie:MovieClip;
	private var container:Div;
	
	private var containerWidth:Number;
	private var containerHeight:Number;
	
	private var scrollerMovie:MovieClip;
	public var scroller: Div;
	
	private var lastY:Number;
	private var lastX:Number;
	private var lastTime:Number;
	
	private var prevY:Number;
	private var prevX:Number;
	private var prevTime:Number;
	
	private var deferredX:Number;
	private var deferredY:Number;
	
	private var startY:Number;
	private var startTime:Number;
	
	private var isscrolling:Boolean;
	
	
	private var height:Number = 0;
	private var width:Number = 0;
	
	private var activeX:Boolean;
	private var activeY:Boolean;
	
	public function Scroller(c:Div, container:Div) 
	{
		this.container = c;
		this.containerMovie = this.container.movie;
		
		this.scroller = container;//c.first('#scroller').asDiv();
		this.scrollerMovie = this.scroller.movie;
		Bada.log('new Scroller',this.scroller, this.scrollerMovie);
	}
	
	
	public function refresh(width:Number, height:Number) {
		if (this.width < width) this.width = width;
		if (this.height < height) this.height = height;
		
		//Bada.log('scroller:', containerWidth, containerHeight, 'current:', width, height);
		
		this.bind();
		this.activeX = false;// containerWidth < width;
		this.activeY = containerHeight < height;
		
		this.scrollbarsRefresh();
	}
	
	private function bind() {
		//this.active = true;
		this.bind = Bada.doNothing;
		this.containerWidth = this.container.width;
		this.containerHeight = this.container.height;
		container.bind('move', Function.bind(this.move, this));
		container.bind('touchStart', Function.bind(this.moveStart, this));
		container.bind('touchEnd', Function.bind(this.moveEnd, this));
	}
	
	/*public function refreshLast():Boolean {
		
		lastX = this.containerMovie._xmouse;
		lastY = this.containerMovie._ymouse;
		return true;
	}*/
	
	
	private function move() {
		this.isscrolling = true;
		var dy = this.containerMovie._ymouse - this.lastY;
		if (this.activeY && dy != 0) {
			if (this.deferredY == null) {
				this.deferredY = this.scrollerMovie._y;
			}
			var y = this.deferredY +  dy;
			if (y < this.containerHeight - this.height) {
				y = this.containerHeight - this.height
			}else if (y > 0) {
				y = 0
			}
			this.deferredY = y;
		}
		
		var dx = this.scrollerMovie._xmouse - this.lastX;
		if (this.activeX && dx != 0) {
			if (this.deferredX == null) {
				this.deferredX = this.scrollerMovie._x;
			}
			var x = this.deferredX +  dx;
			if (x < this.containerWidth - this.width) {
				x = this.containerWidth - this.width
			}else if (x > 0) {
				x = 0
			}
			this.deferredX = x;
		}
		
		this.prevTime = this.lastTime;
		this.prevY = this.lastY;
		this.lastY = this.containerMovie._ymouse;
		this.prevX = this.lastX;
		this.lastX = this.containerMovie._xmouse;
		
		this.lastTime = getTimer();
	}
	
	private function toggleScrolling(status:Boolean) {
		if (status) {
			this.containerMovie.onEnterFrame = Function.bind(function() {
				if (this.deferredX != null) {
					this.x = this.deferredX;
					this.deferredX = null;
				}
				if (this.deferredY != null) {
					this.y = this.deferredY;
					this.deferredY = null;
				}
				
			}, this);
		}else {
			delete this.containerMovie.onEnterFrame;
			this.containerMovie.onEnterFrame = null;
			
			if (this.deferredX != null) {
				this.x = this.deferredX;
				this.deferredX = null;
			}
			if (this.deferredY != null) {
				this.y = this.deferredY;
				this.deferredY = null;
			}
		}
	}
	
	private function moveStart():Boolean {
		
		this.lastY = this.containerMovie._ymouse;
		this.startY = this.containerMovie._ymouse;
		this.lastX = this.containerMovie._xmouse;
		
		
		
		this.startTime = getTimer();
		Tweener.removeTweens(this);
		
		this.toggleScrolling(true);
		return true;
	}
	
	private function moveEnd():Boolean {
		this.toggleScrolling(false);
		if (!this.isscrolling) return true;
		this.isscrolling = false;
		
		//if (getTimer() - this.lastTime > 200)  return true;
		
		
		
		var duration = this.prevTime - this.lastTime,
		lengthY = this.prevY - this.lastY,
		lengthX = this.prevX - this.lastX;
		
		if (duration == 0) return true;
		if ((this.activeX == false || lengthX == 0) && (this.activeY == false || lengthY == 0)) return true;
		
		
		var speedY = this.activeY ? lengthY / duration : 0,
		speedX = this.activeX ? lengthX / duration : 0;
		
		
		var flickingDurationY = 0,
		flickingLengthY = 0,
		flickingDurationX = 0,
		flickingLengthX = 0;
		
		if (this.activeY) {
			flickingDurationY = this.getFlickingDuration(speedY);
			flickingLengthY = this.getFlickingLength(speedY, flickingDurationY);
		}
		if (this.activeX) {
			flickingDurationX = this.getFlickingDuration(speedX);
			flickingLengthX = this.getFlickingLength(speedX, flickingDurationX);
		}
		
		
		var y = this.y,
		x = this.x;
		
		if (flickingLengthY != 0 && isNaN(flickingLengthY) == false) {
			y += flickingLengthY;
			if (y < this.containerHeight - this.height) {
				y = this.containerHeight - this.height
			}else if (y > 0) {
				y = 0
			}
			
			
		}
		if (flickingLengthX != 0 && isNaN(flickingLengthX) == false) {
			y += flickingLengthX;
			if (y < this.containerWidth - this.width) {
				y = this.containerWidth - this.width
			}else if (y > 0) {
				y = 0
			}
		}
		
		Tweener.addTween(this, {
			y: y,
			x: x,
			time: Math.max(flickingDurationY,flickingDurationX) / 1000,
			transition:'easeOutSine'
		});
		
		
	}
	
	public function get x():Number {
		return this.scrollerMovie._x;
	}
	public function set x(value:Number):Void {
		this.scrollerMovie._x = value;
	}
	public function get y():Number {
		return this.scrollerMovie._y;
	}
	public function set y(value:Number):Void {
		this.scrollerMovie._y = value;
		this.scrollbarsReposition();		
	}
	
	
	
	/* flicking data */
	private var config:Object = {
		minSpeed: 0.15,
		friction: 0.998,
		triggerThreshold: 150,
		timing:[0,.3,.6,1]
	}
	private function getFlickingDuration(speed:Number):Number {
		var duration = Math.log(this.config.minSpeed / Math.abs(speed)) / Math.log(this.config.friction);
		return Math.abs(Math.round(duration));
		//return duration > 0 ? Math.round(duration) : 0;
	}
	
	private function getFlickingLength(speed, duration):Number {
		var factor = (1 - Math.pow(this.config.friction, duration + 1)) / (1 - this.config.friction);
		return speed * factor;
	}
	
	/** scrollbars */	
	private var _scrollbarH:Div;
	private var _scrollbarV:Div;
	
	public function scrollbarsRefresh() {
		if (this.activeY) {
			if (this._scrollbarV == null) {
				this._scrollbarV = (new Div( { 
					right:3,
					width:4, 
					borderRadius:4, 
					height:300,
					backgroundColor:0xffffff,
					opacity:.9
				} )).appendTo(this.scroller)
				
				
			}
			this._scrollbarV._id = 'scrollbar';
			/*this._scrollbarV.css({
				height: this.containerHeight * this.containerHeight / this.height
			});*/
			this._scrollbarV.movie._height =  this.containerHeight * this.containerHeight / this.height;
		}
	}
	public function scrollbarsReposition() {
		var offsetY = this.scrollerMovie._y * -1;
		 var proc = offsetY / this.height;
		 
		 this._scrollbarV.movie._y = this.containerHeight * proc + offsetY
	}

}