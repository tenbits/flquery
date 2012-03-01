import bada.dom.CSS;
import bada.dom.css.Border;
import bada.dom.css.Gradient;
import bada.dom.css.Shadow;
import bada.dom.element.Div;
import bada.Graphics;
import flash.geom.Rectangle;
/**
 * ...
 * @author tenbits
 */
class bada.dom.css.BackgroundHelper
{
	public static function render2(div:Div):Void 
	{
		if (div == null) return;
		
		var backgroundColor:Number = div.style.backgroundColor,
		gradient:Gradient = div.style.backgroundGradient,
		border:Border = div.style.border,
		boxShadow:Shadow = div.style.boxShadow,
		movie:MovieClip = div.movie,
		width:Number = div.width,
		height:Number = div.height;
		
		movie.clear();
		if (width < 1 || height < 1) return;
		
		if (boxShadow != null) {
			BackgroundHelper.drawShadow(div, boxShadow);
		}
		
		if (backgroundColor != null || gradient != null || border != null) {
			
			var hasBorder:Boolean = border.hasBorder;				
			if (backgroundColor != null && gradient == null) {
				movie.beginFill(backgroundColor, div.style.backgroundOpacity);
			}
			if (gradient != null) {
				movie.beginGradientFill('linear', gradient.colors, gradient.alphas, gradient.ratios, {
					matrixType: "box",
					x: gradient.x,
					y: gradient.y,
					w: width,
					h: height,
					r: gradient.radius
				});
			}
			
			/**
			 * FlashLite on Wave device always renders line joins as 'round', 
			 * so that semi transparent border looks ugly, due to overlapping.
			 * Maybe find workaround?
			 */
			if (hasBorder) movie.lineStyle(border.topWidth, border.topColor, border.topOpacity, true, 'none','none','none');
			
			movie.moveTo(div.style.borderRadiusTopLeft, 0);	  
			movie.lineTo(width - div.style.borderRadiusTopRight, 0);
			if (div.style.borderRadiusTopRight > 0){
				movie.curveTo(width, 0, width, div.style.borderRadiusTopRight);			  
			}
			
			//if (hasBorder) movie.lineStyle(border.rightWidth, border.rightColor, border.rightOpacity,true, 'normal','none');
			
			
			movie.lineTo(width, height - div.style.borderRadiusBottomRight);
			if (div.style.borderRadiusBottomRight > 0){
				movie.curveTo(width, height, width - div.style.borderRadiusBottomRight, height);		  
			}
			
			
			//if (hasBorder) movie.lineStyle(border.bottomWidth, border.bottomColor, border.bottomOpacity,true, 'normal','none');		
			movie.lineTo(div.style.borderRadiusBottomLeft, height);
			
			
			//if (hasBorder) movie.lineStyle(border.leftWidth, border.leftColor, border.leftOpacity,true, 'normal','none');
			if (div.style.borderRadiusBottomLeft > 0){
				movie.curveTo(0, height, 0, height - div.style.borderRadiusBottomLeft);		  
			}
		  
			
			movie.lineTo(0, div.style.borderRadiusTopLeft);
			if (div.style.borderRadiusTopLeft > 0){
				movie.curveTo(0, 0, div.style.borderRadiusTopLeft, 0);			
			}
			movie.endFill();
		}		
	}
	
	
	public static function	fillBackground(movie:MovieClip, 
					color:Number, 
					width:Number, 
					height:Number, 
					borderRadius:Number, 
					opacity:Number) {
		
		movie.clear();		
		movie.beginFill(color, opacity || 100);
		
		
		//if (hasBorder) movie.lineStyle(div.borderTopWidth, div.borderTopColor, div.borderTopOpacity, false, 'normal','none');
		
	  
		movie.moveTo(borderRadius, 0);
	  
		movie.lineTo(width - borderRadius, 0);
		if (borderRadius > 0){
			  movie.curveTo(width, 0, width, borderRadius);
			  movie.lineTo(width, borderRadius);
		}
		
		//if (hasBorder) movie.lineStyle(div.borderRightWidth, div.borderRightColor, div.borderRightOpacity,false, 'normal','none');
		movie.lineTo(width, height - borderRadius);
		if (borderRadius > 0){
		  movie.curveTo(width, height, width - borderRadius, height);
		  movie.lineTo(width - borderRadius, height);
		}
		
		
		//if (hasBorder) movie.lineStyle(div.borderBottomWidth, div.borderBottomColor, div.borderBottomOpacity,false, 'normal','round');
		movie.lineTo(borderRadius, height);
		
		
		//if (hasBorder) movie.lineStyle(div.borderLeftWidth, div.borderLeftColor, div.borderLeftOpacity,false, 'normal','none');
		if (borderRadius > 0){
		  movie.curveTo(0, height, 0, height - borderRadius);
		  movie.lineTo(0, height - borderRadius);
		}
	  
		
		movie.lineTo(0, borderRadius);
		if (borderRadius > 0){
		  movie.curveTo(0, 0, borderRadius, 0);
		  movie.lineTo(borderRadius, 0);
		}
		movie.endFill();
	}
	
	
	private static function drawShadow(div:Div, shadow:Shadow) {
		var size:Number = shadow.size,
		blur:Number = shadow.blur,
		dx = shadow.dx,
		dy = shadow.dy,
		movie = div.movie,
		drawer = div.style.borderRadius > 0 ? Graphics.outlineRoundedRectangle : Graphics.outlineRectangle,
		color = shadow.color,
		width = div.width,
		step = 1;
		
		for (var i:Number = 0; i < size; i+= step) 
		{
			movie.beginFill(color, 100 - (size * blur) - i * blur);	
			drawer(movie, new Rectangle(0 - i + dx, 0 - i + dy, width + i * 2, width + i * 2), div.style.borderRadius);
			if (i != 0) 
			{
				drawer(movie, new Rectangle(0 - i + step + dx, 0 - i + step + dy, width + i * 2 - 2 * step, width + i * 2 - 2 * step), div.style.borderRadius);
			}				
			movie.endFill();
		}
	}
}