import bada.dom.animation.IAnimation;
import bada.dom.element.Div;
/**
 * ...
 * @author tenbits
 */
class bada.dom.animation.SinAnimation
{
	
	private var _target:Div;
	
	private var _x:Number;
	private var _width:Number;
	private var _height:Number;
	public function SinAnimation(target:Div) 
	{
		this._target = target;		
		this._x = target.x;
		
		this.dx = 0;
		
		this._width = target.width;
		this._height = target.height;
	}
	
	
	public var dx: Number;
	public function refresh() {
		var movie:MovieClip = this._target.movie;
		movie.clear();		
		movie.lineStyle(Bada.smallscreen ? 5 : 10, this._target.style.backgroundColor, 255, true, 'none');
		if (this._height > this._width){
			movie.moveTo(this._width / 2, 0);
			movie.curveTo(dx, this._height / 2, this._width / 2, this._height);
		}else {
			movie.moveTo(0, this._height / 2);
			movie.curveTo(this._width / 2, dx, this._width, this._height / 2);
			//movie.lineTo(this._width, this._height / 2);
		}
		movie.endFill();
	}
}