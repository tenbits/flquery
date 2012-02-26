import bada.dom.element.Span;
/**
 * TODO;
 * @author tenbits
 */
class bada.dom.css.Shadow
{
	
	public var dx:Number;
	public var dy:Number;
	public var blur:Number;
	public var size:Number;
	public var color:Number;
	public function Shadow(value) 
	{
		/*'dx dy blur size color'*/
		if (typeof value === 'string') {
			value = value.split(' ');
			
			this.dx = parseInt(value[0]);
			this.dy = parseInt(value[1]);
			this.blur = parseInt(value[2]);
			this.size = value.length > 4 ? parseInt(value[3]) : this.blur / 2;			
			this.color = value.length > 4 ? parseInt(value[4]) : parseInt(value[3]);
		}
	}
	
	
	static function renderTextShadow(span:Span, text:String):TextField {
		var shadow:Shadow = span.style.textShadow;
		if ( shadow == null) return null;
		
		var depth = span.parent.movie.getNextHighestDepth();
		span.parent.movie.createTextField('text' + depth, depth, span.style.x + shadow.dx, span.style.y + shadow.dy, span.style.width, span.style.height);
		
		var shadowText:TextField = span.parent.movie['text' + depth];
		
		shadowText.text = text;
		shadowText.textColor = shadow.color;
		//shadowText._alpha = shadow._blur;
		
		
		return shadowText;
	}
}