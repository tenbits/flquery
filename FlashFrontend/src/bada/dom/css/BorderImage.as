import flash.geom.Rectangle;
/**
 * ...
 * @author ...
 */
class bada.dom.css.BorderImage
{

	public var source:String;
	public var borderWidth:Number;
	public var crop:Rectangle;
	
	public function BorderImage(value:Array) 
	{
		this.source = value[0];
		this.borderWidth = value[1];
		this.crop = value[2];
	}
	
}