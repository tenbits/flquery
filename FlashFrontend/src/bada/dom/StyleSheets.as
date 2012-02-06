import bada.dom.css.CssClass;
import bada.dom.element.INode;
import bada.Helper;
/**
 * ...
 * @author tenbits
 */
class bada.dom.StyleSheets
{
	public static var Classes:Object = {
		span: {
			color:0xffffff,
			fontSize:30
		},
		checkbox: {
			backgroundImage: 'view-settings.btn_check.png'
		}
		
	}
	
	public static var ClassCollection:Array = [];
	
	static function register() {
		for (var i:Number = 0; i < arguments.length; i++) 
		{
			var _class = new CssClass(arguments[i],arguments[i+1]);
			ClassCollection.push(_class);
			i++;
		}
	}
	
	static function getCss(node:INode):Object {
		var array:Object, var css:Object = { };
		for (var i:Number = 0; i < ClassCollection.length; i++) 
		{
			var _class:CssClass = ClassCollection[i];
			if (_class.match(node)) {
				Helper.extend(css, _class.css);
			}
		}
		return css;
	}
}