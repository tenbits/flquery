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
	
	public function BorderImage(value) 
	{
		if (typeof value === 'string') {
			/** source width cropX cropY cropWidth cropHeight */				
			value = value.split(' ');
			value[1] = parseInt(value[1]);
			if (value[5] != null) {
				value[2] = new Rectangle(parseInt(value[2]), parseInt(value[3]), parseInt(value[4]), parseInt(value[5]));				
			}
		}
		this.source = value[0];
		this.borderWidth = value[1];
		
		this.crop = value[2];
	}
	
}