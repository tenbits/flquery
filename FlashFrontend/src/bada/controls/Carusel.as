import bada.dom.element.Div;
import caurina.transitions.Tweener;
import org.flashdevelop.utils.FlashConnect;

/**
 * ...
 * @author tenbits
 */
class bada.controls.Carusel extends Div
{
	private static var itemHeight:Number = 234;
	public static function init() {
		//bada.dom.NodesFabric.controls['carusel'] = Carusel;
	}
	
	private var lastWinkel:Number = 0;
	private var lastY:Number;
	private var lastTime:Number;
	
	private var prevY:Number;
	private var prevTime:Number;
	
	private var isscrolling:Boolean;
	
	private var C:Number;
	private var R:Number;
	private var items:Array = [];
	private var deferredAngle:Number = null;
	
	private var onSelected:Function;
	public function Carusel(parent:Div, data:Object) 
	{
		super(parent, data);
		this.css('overflow', 'hidden');
		for (var i:Number = 0; i < data.items.length; i++) 
		{
			this.append( {
				_name:'item',
				_data: {
					letter: data.items[i].letter,
					animal: data.items[i].animal
				},
				_css:{
					x:0,
					y: i * itemHeight,
					width:400,
					height:234,
					backgroundImage: data.items[i].image
				}
			});
		}
		
		this.C = 70 * 26;
		this.R = this.C / (2 * Math.PI);
		
		this.bind('move', Function.bind(this.move, this));
		this.bind('touchStart', Function.bind(this.moveStart, this));
		this.bind('touchEnd', Function.bind(this.moveEnd, this));
		
		for (var i:Number = 0; i < this._children.length; i++) 
		{
			var child = this._children[i];
			if (child._name != 'item') continue;
			this.items.push(child);
			
			child.bind('touchEnd', Function.bind(this.clicked, this));
		}
		this.angle = 0;
		this.onSelected = data.onSelected;
	}
	
	private function toggleRotation(status:Boolean) {
		if (status) {
			this._movie.onEnterFrame = Function.bind(function() {
				if (this.deferredAngle != null) {
					this.angle = this.deferredAngle;
					this.deferredAngle = null;
				}
			}, this);
		}else {
			delete this._movie.onEnterFrame;
			this._movie.onEnterFrame = null;
			
			if (this.deferredAngle != null) {
				this.angle = this.deferredAngle;
			}
			this.deferredAngle = null;
		}
	}
	
	private function clicked(item:Div){
		if (this.isscrolling) return;
		this.onSelected(item);
	}
	
	private function moveStart():Boolean {
		this.lastY = this._movie._ymouse;
		Tweener.removeTweens(this);
		
		if (Bada.smallscreen || 1) this.toggleRotation(true);
		return true;
	}
	
	private function moveEnd():Boolean {
		if (Bada.smallscreen || 1) this.toggleRotation(false);
		if (!this.isscrolling) return true;
		
		
		var duration = this.prevTime - this.lastTime;
		var length = this.prevY - this.lastY;
		
		if (duration == 0 || length == 0) return true;
		var speed = length / duration;
		
		
		this.isscrolling = false;
		this.lastY =  this.lastTime =  this.prevY =  this.prevTime = null;
		
		if (speed == 0) return true;
		
		var flickingDuration = this.getFlickingDuration(speed);
		var flickingLength = this.getFlickingLength(speed, flickingDuration);
		
		var dangle = 360 * flickingLength / this.C;
		
		
		//Bada.log('speed',speed,'duration', flickingDuration, 'dangle', dangle);
		if (isNaN(dangle)) return true;
		Tweener.addTween(this, {
			angle: this.angle - dangle,
			time: flickingDuration / 1000,
			transition:'easeOutSine'
		});
		
		
	}
	
	private function move() {
		this.isscrolling = true;
		var dy = this._movie._ymouse - this.lastY;
		
		if (dy != 0) {
			dy = 360 * dy / this.C;
			
			if (Bada.smallscreen || 1) {
				if (this.deferredAngle == null) this.deferredAngle = this.angle;
				this.deferredAngle -= dy;
			}
			else this.angle -= dy;
		}
		this.prevTime = this.lastTime;
		this.prevY = this.lastY;
		this.lastY = this._movie._ymouse;
		this.lastTime = getTimer();
	}
	
	private var _angle:Number = 0;
	public function get angle():Number {
		return _angle;
	}
	public function set angle(value:Number) {
		_angle = value;
		
		if (value >= 360) value -= 360 * Math.floor(value / 360);
		else if (value <= -360) value += 360 * Math.floor(value / 360) * -1;
		
		for (var i:Number = 0; i < this.items.length; i++) 
		{
			this.items[i].movie.swapDepths(800-i);
		}
		
		for (var i:Number = 0; i < this.items.length; i++) 
		{
			var child = this.items[i];
			
			var alpha = (360 / 26) * i - value;
			if (alpha > 360) alpha -= 360;
			else if (alpha < 0) alpha = 360 + alpha;
			
			if (alpha < 130)
				child.movie.swapDepths(360 - parseInt(alpha));
			else 
				child.movie.swapDepths(parseInt(alpha) - 130);
			
			
			child.scale = Math.abs(80 - (80 / 180) * (alpha > 180 ? 360 - alpha : alpha));
			child.y = R * Math.sin(alpha* Math.PI / 180) + (670 / 2 - 46); // + offset top
			child.x = 80 - 80 * ((alpha > 180 ? 360 - alpha : alpha) / 180);
			
		}
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
	
}