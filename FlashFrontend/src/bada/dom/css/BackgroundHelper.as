import bada.dom.CSS;
import bada.dom.css.Border;
import bada.dom.css.Gradient;
import bada.dom.element.Div;
/**
 * ...
 * @author tenbits
 */
class bada.dom.css.BackgroundHelper
{
	
	/**
	 * @param	force - refresh/clean background/borders
	 */
	public static function render(div: Div, width:Number, height:Number, force:Boolean) {
		
		if (div != null && div._css.backgroundColor == null && div._css.backgroundGradient == null && div._css.border == null) {
			if (div != null && force != true) return;
		}
		
		var hasBorder = div.borderTopWidth > 0 || div.borderRightWidth > 0 || div.borderBottomWidth > 0 || div.borderLeftWidth > 0;
		
		
		if (typeof width !== 'number' || typeof height !== 'number') {
			Bada.log('Error # Background.render, size undefined', width, 'x', height, 'id', div._id || div._name);
		}
		
		var movie:MovieClip = div.movie;
		movie.clear();
		
		if (div._css.backgroundColor != null) {			
			movie.beginFill(div._css.backgroundColor, (div._css.opacity == null ? 1 : div._css.opacity) * 100);
		}
		if (div._css.backgroundGradient != null) {
			var info = div._css.backgroundGradient;
			
			if (info.width != null) width = info.width;
			if (info.height != null) height = info.height;
			
			movie.beginGradientFill('linear', info.colors, info.alphas || [100, 100], info.ratios || [0, 255], {
				matrixType: "box",
				x: info.x || 0,
				y: info.y || 0,
				w: info.width || width,
				h: info.height || height,
				r:info.radius || 0
			});
		}
		
		
		if (hasBorder) movie.lineStyle(div.borderTopWidth, div.borderTopColor, div.borderTopOpacity, false, 'normal','none');
		
	  
		movie.moveTo(div.borderRadiusTopLeft, 0);
	  
		movie.lineTo(width - div.borderRadiusTopRight, 0);
		if (div.borderRadiusTopRight > 0){
			  movie.curveTo(width, 0, width, div.borderRadiusTopRight);
			  movie.lineTo(width, div.borderRadiusTopRight);
		}
		
		if (hasBorder) movie.lineStyle(div.borderRightWidth, div.borderRightColor, div.borderRightOpacity,false, 'normal','none');
		movie.lineTo(width, height - div.borderRadiusBottomRight);
		if (div.borderRadiusBottomRight > 0){
		  movie.curveTo(width, height, width - div.borderRadiusBottomRight, height);
		  movie.lineTo(width - div.borderRadiusBottomRight, height);
		}
		
		
		if (hasBorder) movie.lineStyle(div.borderBottomWidth, div.borderBottomColor, div.borderBottomOpacity,false, 'normal','round');
		movie.lineTo(div.borderRadiusBottomLeft, height);
		
		
		if (hasBorder) movie.lineStyle(div.borderLeftWidth, div.borderLeftColor, div.borderLeftOpacity,false, 'normal','none');
		if (div.borderRadiusBottomLeft > 0){
		  movie.curveTo(0, height, 0, height - div.borderRadiusBottomLeft);
		  movie.lineTo(0, height - div.borderRadiusBottomLeft);
		}
	  
		
		movie.lineTo(0, div.borderRadiusTopLeft);
		if (div.borderRadiusTopLeft > 0){
		  movie.curveTo(0, 0, div.borderRadiusTopLeft, 0);
		  movie.lineTo(div.borderRadiusTopLeft, 0);
		}
		movie.endFill();
	}
	
	
	public static function render2(div:Div):Void 
	{
		if (div == null) return;
		
		var backgroundColor:Number = div.style.backgroundColor,
		gradient:Gradient = div.style.backgroundGradient,
		border:Border = div.style.border;
		if (backgroundColor == null && gradient == null && border == null) {
			return;
		}
		
		var hasBorder:Boolean = border.hasBorder,
		width:Number = div.width,
		height:Number = div.height,
		movie:MovieClip = div.movie;
		
		//Bada.log(width, 'x', height, typeof div.style.backgroundOpacity);
		movie.clear();
		
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
		//if (hasBorder) movie.lineStyle(border.topWidth, border.topColor, border.topOpacity, true, 'none','square','square',0,'none');
		if (div.style.borderRadiusBottomLeft > 0){
			movie.curveTo(0, height, 0, height - div.style.borderRadiusBottomLeft);		  
		}
	  
		
		movie.lineTo(0, div.style.borderRadiusTopLeft);
		if (div.style.borderRadiusTopLeft > 0){
			movie.curveTo(0, 0, div.style.borderRadiusTopLeft, 0);			
		}
		movie.endFill();
	}
	
	public static function doDraw(div:Div, _css:Object, width:Number, height:Number) {
		
		var hasBorder = div.borderTopWidth > 0 || div.borderRightWidth > 0 || div.borderBottomWidth > 0 || div.borderLeftWidth > 0;
		
		
		
		var movie = div.movie;
		if (_css.backgroundColor != null) {
			movie.beginFill(_css.backgroundColor, (_css.opacity == null ? 1 : _css.opacity) * 100);
		}
		if (_css.backgroundGradient != null) {
			var info = _css.backgroundGradient;
			movie.beginGradientFill('linear', info.colors, info.alphas || [100, 100], info.ratios || [0, 255], {
				matrixType: "box",
				x: info.x || 0,
				y: info.y || 0,
				w: info.width || width,
				h: info.height || height,
				r:info.radius || 0
			});
		}
		
		
		if (hasBorder) movie.lineStyle(div.borderTopWidth, div.borderTopColor, div.borderTopOpacity, false, 'normal','none');
		
	  
		movie.moveTo(div.borderRadiusTopLeft, 0);
	  
		movie.lineTo(width - div.borderRadiusTopRight, 0);
		if (div.borderRadiusTopRight > 0){
			  movie.curveTo(width, 0, width, div.borderRadiusTopRight);
			  movie.lineTo(width, div.borderRadiusTopRight);
		}
		
		if (hasBorder) movie.lineStyle(div.borderRightWidth, div.borderRightColor, div.borderRightOpacity,false, 'normal','none');
		movie.lineTo(width, height - div.borderRadiusBottomRight);
		if (div.borderRadiusBottomRight > 0){
		  movie.curveTo(width, height, width - div.borderRadiusBottomRight, height);
		  movie.lineTo(width - div.borderRadiusBottomRight, height);
		}
		
		
		if (hasBorder) movie.lineStyle(div.borderBottomWidth, div.borderBottomColor, div.borderBottomOpacity,false, 'normal','round');
		movie.lineTo(div.borderRadiusBottomLeft, height);
		
		
		if (hasBorder) movie.lineStyle(div.borderLeftWidth, div.borderLeftColor, div.borderLeftOpacity,false, 'normal','none');
		if (div.borderRadiusBottomLeft > 0){
		  movie.curveTo(0, height, 0, height - div.borderRadiusBottomLeft);
		  movie.lineTo(0, height - div.borderRadiusBottomLeft);
		}
	  
		
		movie.lineTo(0, div.borderRadiusTopLeft);
		if (div.borderRadiusTopLeft > 0){
		  movie.curveTo(0, 0, div.borderRadiusTopLeft, 0);
		  movie.lineTo(div.borderRadiusTopLeft, 0);
		}

		movie.endFill();
	}
	
	
}