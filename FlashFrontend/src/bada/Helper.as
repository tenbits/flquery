class bada.Helper {

	public static function extend(target: Object, source: Object) : Object {
		if (source == null) return target;
		
		if (target == null) target = {};
		for (var key in source) target[key] = source[key];
		return target;
	}
	
	/**
	 *  Extending target object, if this doesnt contain default properties
	 */
	public static function extendDefaults(target:Object, defaults: Object): Object {
		if (target == null) return Helper.extend(new Object(), defaults);
		for (var key in defaults) {
			if (typeof target[key] === 'undefined') target[key] = defaults[key];
		}
		return target;
	}
	
	public static function extendOnly(target:Object, source:Object, onlyKeys:Object):Object {
		for (var key in onlyKeys) {
			if (target.hasOwnProperty(key) == false) target[key] = source[key];
			else if (source[key] != null) target[key] = source[key];
			
		}
		return target;
	}

	public static function colorToHex(r: Number, g: Number, b: Number) : Number {
		return (r << 16 | g << 8 | b);
	}
	public static function colorToRGB(hex: Number) : Object {
		var red = hex >> 16;
		var greenBlue = hex - (red << 16);
		var green = greenBlue >> 8;
		var blue = greenBlue - (green << 8);
		return ({
			r: red,
			g: green,
			b: blue
		});
	}
    
	static function random(min:Number, max:Number):Number {
		Math.random();
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}
	static function randomSort(array:Array):Array {
		return array.sort(function() {
			return 0.5 - Math.random()
		}).sort(function() {
			return 0.4 - Math.random()
		}).sort(function() {
			return 0.6 - Math.random()
		});
	}
	
	/**
	 * @param	values - where insert value
	 * @param	key - /string or array/ expl.: 'someNestedObject.key'
	 * @param	value // value to insert
	 */
	static function setValue(values:Object, key:Object, value:Object) {
		if (typeof key === 'string'){
			if (key.indexOf('.') > -1) {
				setValue(values, key.split('.'), value);
			}
			values[key] = value;
			return;
		}
		if (key instanceof Array) {
			if (key.length == 1) {
				values[key[0]] = value;
				return;
			}
			
			var _k = Array(key).shift();
			if (values[_k] == null) values[_k] = { };
			setValue(values[_k], key, value);			
		}
	}
}