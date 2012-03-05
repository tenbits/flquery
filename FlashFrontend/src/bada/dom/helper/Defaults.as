/**
 * ...
 * @author tenbits
 */
class bada.dom.helper.Defaults
{
	
	public static function get(key:String) {
		switch(key) {
			case 'paddingLeft':
			case 'paddingRight':
			case 'paddingTop':
			case 'paddingBottom':
			case 'marginLeft':
			case 'marginRight':
			case 'marginTop':
			case 'marginBottom':
			case 'x':
			case 'y':
				return 0;
			case 'bold':
				return false;
			case 'autoSize':
				return true;
			case 'fontSize':
				return 20;
			case 'scale':
				return 100;
			case 'rotation':
				return 0;
			case 'alpha':
				return 100;
		}
		
		return null;
	}
	
	static function extend(css:Object):Object {
		for (var key in css) {
			if (css[key] == null) {
				css[key] = Defaults.get(key);
			}
		}
		return css;
	}
}