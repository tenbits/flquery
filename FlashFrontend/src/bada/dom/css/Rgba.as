/**
 * ...
 * @author ...
 */
class bada.dom.css.Rgba
{
	public var color:Number;
	public var alpha:Number;
	
	public function Rgba(color:Number, alpha:Number) 
	{
		this.color = color;
		this.alpha = alpha == null ? 100 : alpha;
	}
	
}