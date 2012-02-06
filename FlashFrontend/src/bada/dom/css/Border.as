/**
 * ...
 * @author ...
 */
class bada.dom.css.Border
{
	private var _topWidth:Number;
	private var _topColor:Number;
	private var _topOpacity:Number;
	
	private var _rightWidth:Number;
	private var _rightColor:Number;
	private var _rightOpacity:Number;
	
	private var _bottomWidth:Number;
	private var _bottomColor:Number;
	private var _bottomOpacity:Number;
	
	private var _leftWidth:Number;
	private var _leftColor:Number;
	private var _leftOpacity:Number;
	
	public function Border(border:Object) 
	{
		if (typeof border === 'string') {
			border = String(border).split(' ');
		}
		if (border instanceof Array) {
				/** [width, color, opacity]*/
				this._bottomWidth = this._topWidth = this._leftWidth = this._rightWidth = border[0];
				this._bottomColor = this._topColor = this._leftColor = this._rightColor = border[1] || 0x000000;
				this._bottomOpacity = this._topOpacity = this._leftOpacity = this._rightOpacity = border[2] || 100;
			}
		if (border instanceof Object) {
			if (border.top instanceof Array) {
				this._topWidth = border.top[0];
				this._topColor = border.top[1] || 0x000000;
				this._topOpacity = border.top[2] || 100;
			}
			if (border.left instanceof Array) {
				this._leftWidth = border.left[0];
				this._leftColor = border.left[1] || 0x000000;
				this._leftOpacity = border.left[2] || 100;
			}
			if (border.bottom instanceof Array) {
				this._bottomWidth = border.bottom[0];
				this._bottomColor = border.bottom[1] || 0x000000;
				this._bottomOpacity = border.bottom[2] || 100;
			}
			if (border.right instanceof Array) {
				this._rightWidth = border.right[0];
				this._rightColor = border.right[1] || 0x000000;
				this._rightOpacity = border.right[2] || 100;
			}
		}
	}
	
	public function get hasBorder():Boolean {
		return this._topWidth > 0 || this._rightWidth > 0 || this._bottomWidth > 0 || this._leftWidth > 0;
	}
	
	/** setters / getters */
	public function get topWidth():Number 
	{
		return _topWidth;
	}
	public function set topWidth(value:Number):Void 
	{
		_topWidth = value;
	}
	public function get topColor():Number 
	{
		return _topColor;
	}
	public function set topColor(value:Number):Void 
	{
		_topColor = value;
	}
	public function get topOpacity():Number 
	{
		return _topOpacity;
	}
	public function set topOpacity(value:Number):Void 
	{
		_topOpacity = value;
	}
	public function get rightWidth():Number 
	{
		return _rightWidth;
	}
	public function set rightWidth(value:Number):Void 
	{
		_rightWidth = value;
	}
	
	public function get rightColor():Number 
	{
		return _rightColor;
	}
	public function set rightColor(value:Number):Void 
	{
		_rightColor = value;
	}
	public function get rightOpacity():Number 
	{
		return _rightOpacity;
	}
	public function set rightOpacity(value:Number):Void 
	{
		_rightOpacity = value;
	}
	public function get bottomWidth():Number 
	{
		return _bottomWidth;
	}
	public function set bottomWidth(value:Number):Void 
	{
		_bottomWidth = value;
	}
	public function get bottomColor():Number 
	{
		return _bottomColor;
	}
	public function set bottomColor(value:Number):Void 
	{
		_bottomColor = value;
	}
	public function get bottomOpacity():Number 
	{
		return _bottomOpacity;
	}
	public function set bottomOpacity(value:Number):Void 
	{
		_bottomOpacity = value;
	}
	public function get leftWidth():Number 
	{
		return _leftWidth;
	}
	public function set leftWidth(value:Number):Void 
	{
		_leftWidth = value;
	}
	public function get leftColor():Number 
	{
		return _leftColor;
	}
	public function set leftColor(value:Number):Void 
	{
		_leftColor = value;
	}
	public function get leftOpacity():Number 
	{
		return _leftOpacity;
	}
	public function set leftOpacity(value:Number):Void 
	{
		_leftOpacity = value;
	}
	
	
}