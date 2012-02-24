import bada.dom.element.INode;
/**
 * ...
 * @author ...
 */
class bada.dom.css.CssClass
{
	public var css:Object;
	public var selector:Array;
	public var className:String;
	public function CssClass(_selector:String ,css:Object) 
	{
		this.selector = CssClass.parseSelector(_selector);
		this.css = css;
		
		var name = this.selector[this.selector.length - 1].className;
		if (name)  this.className = name;
		
	}
	
	public function toString() {
		var s:String = '[\n';
		for (var i:Number = 0; i < selector.length; i++) 
		{
			s += ' {\n'
			if (typeof selector[i] === 'object'){
				for (var key in selector[i]) {
					s += '   ' + key + ':' + selector[i][key] + '\n'
				}
			}else {
				s += '   ' + selector[i] + '\n';
			}
			s+= ' }\n'
		}
		s += ']';
		return s;
	}
	
	private static function parseSelector(selector:String):Array {
		
		var current:Object = { }, 
		currentType:String, 
		nextType:String,
		parsed:Array = [] , 
		value:String = '',
		flush:Boolean;
		
		for (var i:Number = 0; i < selector.length; i++) 
		{
			var c = selector.charAt(i);
			switch(c) {
				case '>':
					parsed.push(current);
					parsed.push(c);
					flush = true;
					break;
				case '_':
					nextType = 'name';
					flush = true;						
					break;
				case '.':					
					nextType = 'className';
					flush = true;						
					break;
				case '#':
					nextType = 'id';
					flush = true;						
					break;
				case ' ':
					continue;
			}
			
			if (flush) {
				if (value) {					
					if (currentType == 'className') {
						if (current.className == null) {
							current.className = value;						
						}else if (current.className instanceof Array) {
							current.className.push(value);
						}else { // is string
							current.className = [current.className, value];						
						}
					}else {
						if (currentType == null) currentType = 'tag';
						current[currentType] = value;
					}
				}
				if (c == '>') {
					current = { };
				}
				
				flush = false;				
				value = '';
				currentType = nextType;				
				nextType = null;
				continue;
			}
			value += c;			
		}
		if (value) {					
			if (currentType == 'className') {
				if (current.className == null) {
					current.className = value;						
				}else if (current.className instanceof Array) {
					current.className.push(value);
				}else { // is string
					current.className = [current.className, value];						
				}
			}else {
				if (currentType == null) currentType = 'tag';
				current[currentType] = value;
			}
			parsed.push(current);
		}
		
		return parsed;
	}
	
	
	public function match(node:INode):Boolean {
		var current:INode = node;
		for (var i:Number = this.selector.length - 1; i > -1; i--) 
		{
			var item = this.selector[i];			
			if (item === '>') {
				current = current.parent;
				if (!CssClass.doMatch(this.selector[--i], current)) return false;
				continue;
			}
			
			if (!CssClass.doMatch(item, current)) return false;
		}
	
		return true;
	}
	
	public function applyable(node:INode):Boolean {		
		var current:INode = node;
		for (var i:Number = this.selector.length - 2; i > -1; i--) 
		{
			var item = this.selector[i];
			if (item === '>') {
				current = current.parent;
				if (!CssClass.doMatch(this.selector[--i], current)) return false;
				continue;
			}
			
			if (!CssClass.doMatch(item, current)) return false;
		}
		return true;
	}
	
	private static function doMatch(selectors:Object, node:INode):Boolean {
		
		if (selectors.name != null && node._name != selectors.name) return false;
		if (selectors.id != null && node._id != selectors.id) return false;
		if (selectors.tag != null && node._tagName != selectors.tag) return false;
		if (selectors.className != null) {
			if (node._classNames == null) return false;
			if (selectors.className instanceof Array){
				for (var i:Number = 0; i < selectors.className.legth; i++) 
				{
					if (node.hasClass(String(selectors.className[i])) == false) return false;
				}
			}
			else if (typeof selectors.className === 'string') {
				if (node.hasClass(String(selectors.className)) == false) return false;
			}
		}
		return true;		
	}
}