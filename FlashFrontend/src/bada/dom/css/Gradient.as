/**
 * ...
 * @author ...
 */
class bada.dom.css.Gradient
{
	public var colors:Array;
	public var ratios:Array;
	public var alphas:Array;
	public var radius:Number;
	
	public var x:Number;
	public var y:Number;
	public var type:String;
	
	public var width:Number;
	public var height:Number;
	
	public function Gradient(gradient:Object) 
	{
		if (typeof gradient === 'string') {
			gradient = Gradient.parseString(String(gradient));
		}
		
		this.colors = gradient.colors;
		this.ratios = gradient.ratios;
		this.alphas = gradient.alphas;
		this.radius = gradient.radius;
		this.type = gradient.type || 'linear';
		
		if (gradient.width)  this.width = gradient.width;
		if (gradient.height)  this.height = gradient.height;
		
		if (this.ratios == null) {
			var step = 255 / (this.colors.length - 1), ratio = 0;
			this.ratios = [];
			for (var i:Number = 0; i < this.colors.length; i++) 
			{
				this.ratios.push(ratio);
				ratio += step;
			}
		}
		
		if (this.alphas == null) {
			this.alphas = [];
			for (var i:Number = 0; i < this.colors.length; i++) 
			{
				this.alphas.push(100);
			}
		}
		
		if (this.radius == null) this.radius = 0;
		
		
		this.x = gradient.x || 0; 
		this.y = gradient.y || 0;		
	}
	
	private static function parseString(value:String):Object {
		var infos:Array = value.split(' ');
			
		var backgroundGradient:Object = { };
		
		if (infos[0] != null) {
			backgroundGradient.colors = infos[0].split(',');
			var array:Array = backgroundGradient.colors;
			for (var i:Number = 0; i < array.length; i++) 
			{
				array[i] = parseInt(array[i]);
			}
		}
		if (infos[1] != null) {
			backgroundGradient.ratios = infos[1].split(',');
			var array:Array = backgroundGradient.ratios;
			for (var i:Number = 0; i < array.length; i++) 
			{
				array[i] = parseInt(array[i]);
			}
		}
		if (infos[2] != null) {
			backgroundGradient.radius = (Math.PI * parseInt(infos[2])) / 180;
		}
		if (infos[3] != null) {
			backgroundGradient.alphas = infos[3].split(',');
			var array:Array = backgroundGradient.alphas;
			for (var i:Number = 0; i < array.length; i++) 
			{
				array[i] = parseInt(array[i]);
			}
		}
		return backgroundGradient;
	}
	
	/*public function getMatrix(width:Number, height:Number):Object {
		if (this.type == 'linear') {
			return {
				matrixType: "box",
				x: gradient.x,
				y: gradient.y,
				w: gradient.width || width,
				h: gradient.height || height,
				r: gradient.radius
			};
		}
	}*/
}