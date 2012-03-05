import bada.dom.CSS;
import bada.dom.css.BackgroundHelper;
import bada.dom.css.CssClass;
import bada.dom.css.StyleSheet;
import bada.dom.element.Div;
import bada.dom.element.INode;
import bada.dom.StyleSheets;
import bada.Graphics;
import bada.Helper;
import bada.Utils;
/**
 * ...
 * @author ...
 */
class bada.dom.css.CSSEngine
{
	
	static function render(node:INode, css:Object, nobackgroundHandling:Boolean) {
		if (css == null) css = node._mergedCss;
		
		
		
		if (nobackgroundHandling != true && css.backgroundImage != null) {
			/** apply backgroundImage first, for correct width/height calculation */
			CSSEngine.backgroundImage(node, css);			
		}
		
		var width:Number = node.width,
		height:Number = node.height,
		movie:Object = node.movie || node.textField;
		
		for (var prop in css) {
			if (prop == 'width' || prop == 'height') continue;
			
			switch (prop) {
				case 'bottom':
				case 'top':
				case 'y':
					if (css[prop] === '50%')  node.style.y = css[prop];
					movie._y = node.style.y;
					continue;
				case 'right':
				case 'left':
				case 'x':	
					if (css[prop] === '50%') node.style.x = css[prop];
					movie._x = node.style.x;
					continue;				
				case 'display':				
					if (node.style[prop] == 'none') node.toggle(false);
					continue;
				
				case 'scale':					
				case 'opacity':
				case 'rotation':
					continue;
			}
			
			if (typeof movie['_' + prop] !== 'undefined') {				
				movie['_' + prop] = css[prop];
				continue;
			}
			
			node.applyCss(prop, node.style[prop]);
		}
		
		if (css.hasOwnProperty('backgroundColor') ||
			css.hasOwnProperty('backgroundGradient') || 
			css.hasOwnProperty('border') || 
			css.hasOwnProperty('boxShadow') ||
			css.hasOwnProperty('borderImage')) {
				
			
			BackgroundHelper.render2(node.asDiv());			
		}	
		
		/** transformations */
		if (css.scale)  node.scale = node.style.scale;
		if (css.rotation) node.rotation = node.style.rotation;
		
	}
	
	static function reposition(node:INode, last:INode) {
		if (node.style.position == 'absolute') return;
		
		if (last == null) last = node.prev('style[position=static]');
		
		
		
		if (last == null) {
			if (node._mergedCss.x == null) node.x = node.parent.style.paddingLeft  + node.style.marginLeft;
			if (node._mergedCss.y == null) node.y = node.parent.style.paddingTop  + node.style.marginTop;
			return;
		}
		
		if (isNaN(last.width) || isNaN(last.height)) {
			Bada.log('Error # CSS.position, last size undefined:', last.width, last.height);
			return;
		}
		
		
		if (node.style.display == 'inline-block') {
			if (node.parent.width - 
				last.x - 
				last.width - 
				last.style.marginRight - 
				node.style.marginLeft - 
				node.width  - 
				node.parent.style.paddingLeft - 
				node.parent.style.paddingRight > 0) {
					
					node.x = last.x + last.width + last.style.marginLeft + node.style.marginLeft;
					node.y = last.y + node.style.marginTop;
					
					/**
					 * so that, next block that comes on next row has correct y-position
					 */
					if (last.height > node.height) {
						node.height = last.height;						
					}					
					return;
			}
			
		}
		
		
		if (node._mergedCss.x == null) {
			node.x = node.parent.style.paddingLeft + node.style.marginLeft;
		}
		if (node._mergedCss.y == null) {
			node.y = last.y + last.height + last.style.marginBottom + node.style.marginTop;					
		}
	}
	
	public static function backgroundImage(node: INode, css:Object) :Void {	
		
		var movie = node.movie,
		img:MovieClip = Utils.attachMovie(movie, css.backgroundImage, 'backgroundImage' , 1);
		
		if (img == null)  return null;
		
		if (css.backgroundPosition != null) {
			var x = css.backgroundPosition.x,
			y = css.backgroundPosition.y;
			if (typeof  x === 'string' && x == 'center') {
				x = (node.parent.width - img._width) / 2;			
			}
			if (typeof  y === 'string' && y == 'center') {
				y = (node.parent.height - img._height) / 2;			
			}
			if (typeof x === 'number') img._x = x;
			if (typeof y === 'number') img._y = y;
		}
		
		if (css.backgroundRepeat === 'repeat') {			
			node._canvas = Graphics.repeatCanvas(movie, img, node.width, node.height);
		}
		
		if (css.backgroundSize === 'stretch') {
			img._width = node.width;
			img._height = node.height;	
		}
		
		if (css.width == null)  css.width = (node.style.width  = img._width);			
		if (css.height == null) css.height = (node.style.height = img._height);
	}
	
	
	/** obsolete */
	static function parseClass(node:INode):Object {		
		return StyleSheets.getCss(node);		
	}
	
	static function calculateDimension(node:INode, css:Object) {
		if (css.width != null) {
			if (typeof css.width === 'string' && css.width.charAt(css.width.length - 1) == '%') {
				var percent = parseInt(css.width.substring(0, css.width.length - 1), 10);
				var parents = node.parent.width;
				if (typeof parents !== 'number') continue;			
				node.style.width = parents * percent / 100;			
			}else {
				node.style.width = css.width;
			}
			
			if (node.style.backgroundColor != null && css.backgroundColor == null) {
				css.backgroundColor = node.style.backgroundColor;
			}
			if (node.style.backgroundGradient != null && css.backgroundGradient == null) {
				css.backgroundGradient = node.style.backgroundGradient;
			}
		}
		
		if (css.height != null) {
			
			if (typeof css.height === 'string' && css.height.charAt(css.height.length - 1) == '%') {
				var percent = parseInt(css.height.substring(0, css.height.length - 1), 10);
				var parents = node.parent.height;
				if (typeof parents !== 'number') continue;
				node.style.height = parents * percent / 100;
			}else {
				node.style.height = css.height;
			}
		}
	}
	
	static function calculateCss(node:INode, css:Object) {
		for (var key in css) {			
			switch(key) {
				case 'width':
				case 'height':
					break;
				case 'bottom':
					node.style.y = node.parent.height - css[key] - node.height;
					break;
				case 'right':
					node.style.x = node.parent.width - css[key] - node.width;
					break;
				case 'top':
					node.style.y = css[key];
					break;
				case 'left':
					node.style.x = css[key];
					break;	
				default:					
					if (StyleSheet.styles.hasOwnProperty(key)) {		
						node.style[key] = css[key];								
					}else {
						if (typeof node.movie['_' + key] === 'undefined')
							Bada.log('Error # no property in styles', key, css[key]);
					}
					break;
			}
		}
		
		if (node.style.position == 'static') {
			CSSEngine.reposition(node, null, css);
		}
		
	}
	
}