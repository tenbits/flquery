/**
 * ...
 * @author tenbits
 */
class bada.dom.helper.StyleParser
{
	
	public static function parseStyle_depr(node:Object, style:String):Object {
		var styles:Array = style.split(';');
		
		for (var i:Number = 0; i < styles.length; i++) 
		{
			var keyvalue:Array = styles[i].split(':');
			if (keyvalue.length != 2) continue;			
			
			node._css[keyvalue[0]] = keyvalue[1];			
		}
		
		return node._css;
	}
	
	
	public static function parseStyle(node:Object, style:String):Object {
		var key:String = '', value:String;
		for (var i:Number = 0; i < style.length; i++) 
		{
			
			var c:String = style.charAt(i);
			
			switch(c) {
				case ':':
					value = '';
					continue;
				case ';':
					//-handleStyle(node, key, value);
					node._css[key] = value;
					key = '';
					value = null;
					continue;
				case ' ':
				case '\t':
				case '\n':
					if (c == ' ' && value != null && value.length > 0) {
						//isarray = true;
						break;
					}
					continue;
			}
			
			if (value == null) key += c;
			else value += c;
		}
		if (key && value) {
			//-handleStyle(node, key, value);			
			node._css[key] = value;
		}
		
		return node._css;
	}
	
	/**
	 * @deprecated 
	 * @param	node
	 * @param	key
	 * @param	value
	 */
	private static function handleStyle(node:Object, key:String, value:String) {
		switch(key) {			
			case 'top':
			case 'left':
			case 'bottom':
			case 'right':
				//if (value.charAt(value.length - 1) == '%') break;
				
				node._css[key] = parseInt(value);					
				return;
		}
		node._css[key] = value;	
	
	}
	
}