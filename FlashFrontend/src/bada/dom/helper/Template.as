import bada.Helper;
/**
 * ...
 * @author ...
 */
class bada.dom.helper.Template
{
	private var _parts:Array;
	
	/** 
	 * Use for List Rendering, so that we dont need to parse the string each time
	 */
	function Template(template:String) {
		if (typeof template === 'string') {
			var parts:Array = template.split('#{');
			this._parts = [parts[0]];			
			for (var j:Number = 1; j < parts.length; j++) 
			{
				var close:Number = parts[j].indexOf('}');
				var key:String = parts[j].substr(0, close);						
				this._parts.push(key);
				this._parts.push(parts[j].substring(close + 1));				
			}		
		}		
	}
	
	function run(values:Object):String {
		var str:String = '';
		for (var i:Number = 0; i < this._parts.length; i++) 
		{
			str += i % 2 != 0 ? Helper.getValue(values, this._parts[i]) : this._parts[i];
		}
		return str;
	}
	
	/** static helpers */
	static function render(template:String, values:Object) {
		if (!template) return '';
		
		var parts:Array = template.split('#{');		
		var str:String = parts[0];
		for (var j:Number = 1; j < parts.length; j++) 
		{
			str += handleEntry(parts[j], values);
		}
		
		return str;
	}
	
	static function renderListview(template:String, list:Array, delimiter:String):String {
		var listView:Array = [];		
		for (var i:Number = 0; i < list.length; i++) 
		{
			listView.push(Template.render(template, list[i]));
			if (delimiter && i < list.length - 1) listView.push(delimiter);
		}		
		return listView.join('');
	}
	/** array [Object, Object]
	 *  Object.template == Template
	 *  Object./*value1/
	 *  Object./*value1/
	 */
	static function renderMany(list:Array, delimiter:String) {
		var listView:Array = [];
		for (var i:Number = 0; i < list.length; i++) 
		{
			listView.push(Template(list[i].template).run(list[i]));
			if (delimiter && i < list.length - 1) listView.push(delimiter);
		}		
		return listView.join('');
	}
	
	private static function handleEntry(template:String, values:Object, pos:Number) {
		var close:Number = template.indexOf('}');
		if (close > 15) return template;		
		var key:String = template.substr(0, close);
		if (key == 'title') Bada.log('getValue', key, values);
		return Helper.getValue(values, key) + template.substr(close + 1);		
	}
	
}