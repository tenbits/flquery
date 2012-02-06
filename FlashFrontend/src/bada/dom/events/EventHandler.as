import bada.dom.element.Div;
/**
 * ...
 * @author tenbits
 */
class bada.dom.events.EventHandler
{

	private var _events: Object;
	public function EventHandler() 
	{
		
	}
	
	public function bind(event:String, callback:Function) {
		if (this._events == null) this._events = { };
		if (this._events[event] == null) this._events[event] = [];
		
		this._events[event].push(callback);
		//if (event == 'touchStart') Bada.log('touchStart bind',this._events[event].length);
	}
	
	public function trigger():Boolean {
		var args = Array.prototype.slice.call(arguments),
			event = args.shift();
			var r:Boolean = true;
			if (typeof this._events[event] != undefined) {
				for (var item, i = 0; item = this._events[event][i], i < this._events[event].length; i++) {
					//if (event == 'touchStart') Bada.log('touchStart trigger',this._events[event].length);
					r = item.apply(this, args);
				}
			}
		return r;
	}
	
	public function unbind(arg:Object) {
		
		switch(typeof arg){
			case 'function': {
				for ( var event in this._events) {
					for (var j:Number = 0; j < this._events[event].length; j++) 
					{
						if (this._events[event][j] == arg) {
							this._events[event].splice(j, 1);
							j--;
						}
					}
				}
			}
			break;
			case 'string': delete this._events[arg]; break;
		}			
	}
	
	public function length(event:String):Number {
		return this._events == null ? 0 : (this._events[event] == null ? 0 : this._events[event].length);
	}
	public function get(event:String):Array {
		return this._events[event];
	}
}