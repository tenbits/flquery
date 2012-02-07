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
		if (css == null) css = node._css;
		
		if (nobackgroundHandling != true && css.backgroundImage != null) {
			/** apply backgroundImage first, for correct width/height calculation */
			CSSEngine.backgroundImage(node);			
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
					movie._y = node.style.y;
					continue;
				case 'right':
				case 'left':
				case 'x':	
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
		
		if (css.backgroundColor != null || css.backgroundGradient != null || css.border != null) {
			if (node.style.height != null){
				BackgroundHelper.render2(Div(node));
			}
		}	
		
		/** transformations */
		if (css.scale)  node.scale = node.style.scale;
		if (css.rotation) node.rotation = node.style.rotation;
		
	}
	
	static function reposition(node:INode, last:INode) {
		if (node.style.position == 'absolute') return;
		
		if (last == null) last = node.prev('style[position=static]');
		//Bada.log('prev', last);
		if (last == null) {
			if (node._css.x == null) node.x = node.parent.style.paddingLeft  + node.style.marginLeft;
			if (node._css.y == null) node.y = node.parent.style.paddingTop  + node.style.marginTop;
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
				node.parent.style.paddingRight > -1) {
					
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
		
		
		if (node._css.x == null) {
			node.x = node.parent.style.paddingLeft + node.style.marginLeft;
		}
		if (node._css.y == null) {
			node.y = last.y + last.height + last.style.marginBottom + node.style.marginTop;					
		}
	}
	
	public static function backgroundImage(node: INode) :Void {	
		
		var movie = node.movie,
		img:MovieClip = Utils.attachMovie(movie, node._css.backgroundImage, 'backgroundImage' , 1);
		
		//Bada.log('BG:', node._css.backgroundImage, node.style.backgroundImage);
		if (img == null)  return null;
		
		if (node._css.backgroundPosition != null) {            
			img._x = node._css.backgroundPosition.x;
			img._y = node._css.backgroundPosition.y;
		}
		
		if (node._css.backgroundRepeat === 'repeat') {			
			Bada.log(node._tagName, node.width, node.height);
			node._canvas = Graphics.repeatCanvas(movie, img, node.width, node.height);
		}
		
		if (node._css.backgroundSize === 'stretch') {
			img._width = node.width;
			img._height = node.height;	
		}
		
		if (node._css.width == null) node._css.width = img._width;
		if (node._css.height == null) node._css.height = img._height;
	}
	
	
	static function parseClass(node:INode):Object {
		
		var class_ = StyleSheets.getCss(node);
		//Bada.log('Css.parseClass',class_.position, class_.backgroundColor, class_.height);
		node._css = Helper.extend(class_,node._css);
		break;
		
		var classes:Array = null, css:Object = node._css;
		
		if (typeof node._class === 'string') {
			classes = node._class.split(' ');
		}
		
		if (typeof node._name === 'string') {
			if (classes == null) classes = [];
			classes.unshift(node._name);
		}
		if (typeof node._id === 'string') {
			if (classes == null) classes = [];
			classes.unshift(node._id);
		}
		
		
		if (classes != null){
			for (var i:Number = 0; i < classes.length; i++) 
			{
				css = Helper.extendDefaults(css, StyleSheets.Classes[classes[i]]);
			}
		}
		
		if (StyleSheets.Classes[node._tagName] != null) {
			css = Helper.extendDefaults(css, StyleSheets.Classes[node._tagName]);			
		}
		
		return css;
	}
	
	static function calculateCss(node:INode, css:Object) {
		
		if (css.width != null) {
			if (typeof css.width === 'string' && css.width.charAt(css.width.length - 1) == '%') {
				var percent = parseInt(css.width.substring(0, css.width.length - 1), 10);
				var parents = node.parent.width;
				if (typeof parents !== 'number') continue;			
				node.width = parents * percent / 100;			
			}else {
				node.width = css.width;
			}
		}
		
		if (css.height != null){
			if (typeof css.height === 'string' && css.height.charAt(css.height.length - 1) == '%') {
				var percent = parseInt(css.height.substring(0, css.height.length - 1), 10);
				var parents = node.parent.height;
				if (typeof parents !== 'number') continue;
				node.height = parents * percent / 100;
			}else {
				node.height = css.height;
			}
		}
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
			CSSEngine.reposition(node);
		}
	}
	
}