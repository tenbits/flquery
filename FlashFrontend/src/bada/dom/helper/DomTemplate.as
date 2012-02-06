import bada.dom.helper.Template;
import bada.dom.helper.XmlParser;
/**
 * ...
 * @author ...
 */
class bada.dom.helper.DomTemplate
{
	private var _template:Object;	
	/**
	 * { where : what }
	 */
	private var _templated:Object;
	
	public function DomTemplate(template:Object) 
	{
		if (typeof template === 'string') this._template = XmlParser.parseHtml(String(template))[0];
		else this._template = template;		
	}
	
	
	function render(values:Object) {	
		//this._templated = templates;
		
		var _copy:Object = Template.cloneObject(this._template);
		
		/*for (var key in this._templated) {
			var value = Template.getValue(values, key) || '';
			Template.setValue(_copy, this._template[key], value);
		}
		return copy;*/
		
		return deepExtend(_copy, values);
	}
	
	private static function deepExtend(target:Object, source:Object) {
		if (target == null) target = { };
		for (var key in source) {
			if (typeof source[key] == 'object') {
				if (typeof target[key] !== 'object') target[key] = { };
				
				deepExtend(target[key], source[key]);
				continue;
			}
			target[key] = source[key];			
		}
		return target;
	}

}