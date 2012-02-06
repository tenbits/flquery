import bada.dom.helper.StyleParser;
/**
 * ...
 * @author tenbits
 */
class bada.dom.helper.XmlParser
{
	
	public static function parseHtml(html:String):Array {	
		var xml:XML = new XML(html);
		var array:Array = [];
		for (var i:Number = 0; i < xml.childNodes.length; i++) 
		{
			var value = parseNode(xml.childNodes[i]);
			if (typeof value == 'object') array.push(value);
		}		
		return array;
	}
	
	private static function parseNode(xml:XMLNode):Object {
		var node:Object = { _css: { }};
		if (xml.nodeType == 3) return xml.nodeValue;
		node.tag = xml.nodeName;
		
		switch(node.tag) {
			case 'span':
				node._html = '';
				break;
		}
		
		
		for (var key in xml.attributes) {
			handleAttribute(node, key, xml.attributes[key]);
		}
		
		if (xml.hasChildNodes()) {
			node._children = [];
			
			for (var i:Number = 0; i < xml.childNodes.length; i++) 
			{
				var value = parseNode(xml.childNodes[i]);
				if (typeof value == 'string') node._html = value;
				else if (typeof value == 'object') node._children.push(value);				
			}
		}
		
		
		return node;
	}
	
	private static function handleAttribute(node:Object, key:String, value:String):Boolean {
		switch(key) {
			case 'style':
				StyleParser.parseStyle(node, value);
				return true;
			case 'id':
				node._id = value;
				return true;
			case 'name':
				node._name = value;
				return true;
			case 'background':
				/** 
				 *  gradient(colors,colors ratios,ratios radiusGrad alphas,alphas)
				 *  color,opacity?
				 *  {resourcePath to bg image}
				 */
				parseStyleBackground(node, value);
				return true;
			case 'border':
				/**
				 *  width color opacity
				 */
				//-parseStyleBorder(node, value);
				node._css.border = value;		
				return true;
		}
		return true;
		if (key.indexOf('data-') == 0) {
			key = key.substring(5, key.length - 1);
			if (node._data == null) node._data = { };
			node._data[key] = value;
			return true;
		}
		
		
		if (value == 'true') {
			node[key] = true;
			return true;
		}
		if (value == 'false') {
			node[key] = false;
			return true;
		}
		
		return false;
	}
	
	
	
	static function parseStyleBackground(node:Object, value:String):Object {
		
		if (value.indexOf('gradient', 0) == 0) {
			node._css.backgroundGradient = value.substring(9, value.length - 1);			
		}else if (value.indexOf('0x',0) == 0) {
			var values = value.split(',');
			node._css.backgroundColor = values[0];
			if (values[1] != null) node._css.backgroundOpacity = values[1];
		}else {
			if (value.indexOf(' ') > 0) {
				var _parts = value.split(' ');
				node._css.backgroundImage = _parts[0];
				node._css.backgroundRepeat = _parts[1];
			}
			else {
				node._css.backgroundImage = value;
			}
		}
		
		return null;
	}
	
	private static function parseStyleBorder(div:Object, value:String ) {
		var border:Array = value.split(' ');
		border[0] = parseInt(border[0]);
		border[1] = parseInt(border[1] || 0x000000);
		border[2] = parseInt(border[2] || 100);
		div._css.border = border;		
	}
}