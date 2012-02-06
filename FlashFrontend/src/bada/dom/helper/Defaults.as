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
		}
		
		return null;
	}
	
}