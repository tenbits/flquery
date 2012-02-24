import bada.dom.element.Div;
import caurina.Rotator;
import caurina.transitions.Tweener;
import flash.geom.Point;
/**
 * ...
 * @author tenbits
 */
class bada.dom.animation.CssAnimation
{
	private var _index:Number;
	private var _current:Div;
	public var loop:Boolean;
	public var onEnd:Function;
	
	public var infos:Array;
	public var time:Number;
	
	public function CssAnimation(info:Object) 
	{
		this.infos = [];
		this.loop = true;
		
		var lastPercent:Number = 0;
		for (var frame in info) {
			var percent:Number = parseInt(frame.substring(1));
			this.infos.push( {
				css: info[frame],
				time: percent - lastPercent
			});
			lastPercent = percent;
		}
		
	}
	
	
	public function start(target:Div, time:Number, loop:Boolean) {
		this.time = time;
		
		this._current = target;		
		this._index = -1;
		this.onframe();
	}
	
	private function onframe() {
		this._index++;
		if (this._index > this.infos.length - 1) {
			if (this.loop == false) {
				if (this.onEnd instanceof Function) this.onEnd(this);
				return;
			}
			this._index = 0;
		}
		var frame = this.infos[this._index],
		css = frame.css;
		
		css.time = this.time * (frame.time / 100);
		css.onComplete = this.onframe.bind(this);
		this._current.animate(css);
		
	}
}