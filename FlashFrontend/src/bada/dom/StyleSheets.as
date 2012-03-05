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
		checkbox: {
			backgroundImage: 'view-settings.btn_check.png'
		}
		
	}
	
	private static var ClassCollection:/*bada.dom.css.CssClass*/Array;
	
	/**
	 *  className:String, css:Object,...
	 */
	static function register() {
		if (ClassCollection == null) ClassCollection = [];
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
	
	static function getClasses(node:INode):/*bada.dom.css.CssClass*/Array {
		var array:/*bada.dom.css.CssClass*/Array;
		for (var i:Number = 0; i < ClassCollection.length; i++) 
		{
			var _class:CssClass = ClassCollection[i];
			if (_class.match(node)) {
				if (array == null) array = [];
				array.push(_class);				
			}
		}
		return array;
	}
	
	static function getClassForNode(className:String, node:INode):CssClass {
		for (var i:Number = 0; i < ClassCollection.length; i++) 
		{
			if (ClassCollection[i].className == className) {
				
				if (ClassCollection[i].applyable(node)) {
					return ClassCollection[i];
				}
				
			}
		}
		return null;
	}
	
	static function combineClasses(classes:Array/*bada.dom.css.CssClass*/):Object 
	{
		var css:Object;
		for (var i:Number = 0; i < classes.length; i++) 
		{
			css = Helper.extend(css, classes[i].css);
		}
				
		return css;
	}	
}