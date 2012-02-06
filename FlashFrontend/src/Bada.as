import bada.Events;
import bada.views.DebugView;
import org.flashdevelop.utils.FlashConnect;
class Bada {
	
	public static var resources:Boolean = true;
	public static var debug:Boolean = true;
	public static var smallscreen:Boolean = false;
	public static var multitouchEnabled:Boolean = true;
	
	
	public static function log(){
		if (debug == false) { Bada.log = Bada.doNothing; return;}
		
		var args = Array.prototype.slice.call(arguments),
		message = '';
		for(var i = 0;i< args.length; i++){
			message+=args[i] + ' ';
		}
		
		FlashConnect.trace(message);
		DebugView.log(message);
		
	}
	//log to device
	public static function trace():Void{
		var args = Array.prototype.slice.call(arguments),
		message = '';
		for(var i = 0;i< args.length; i++){
			message+=args[i] + ' ';
		}
		_global.deviceTrace(message);
	}
	public static var screen = {
        width:480,
        height:800
    };
	
	public static function isFlashLite():Boolean {
	   var ver:String = getVersion();
	   isFlashLite = ver.substr(0, 2) == "FL" || ver.substr(1, 2) == "FL" ? function() { return true; } : function() { return false; }
	   ver = null;
	   return isFlashLite();
	}
	
	public static function doNothing(){
		return false;
	}
	
	public static function animate(movie:MovieClip, css:Object,time:Number,timing:String):Void{
		
		if (css.bottom){
			css._y = Stage.height - css.bottom - movie._height;
			delete css.bottom;
		}
		if (css.right){
			css._x = Stage.width - css.right - movie._width;
			delete css.right;
		}
		css.time = time;
		css.transition = timing;
		caurina.transitions.Tweener.addTween(movie, css);
	}
	
	public static function puls(movie:MovieClip,min:Number, max:Number):Void{
		
		var object:Object = {
			time:1.4,
			transition:'linear'
		}
		if (movie._xscale == min){
			object._xscale = max;
			object._yscale = max;
		}
		else if (movie._xscale == max){
			object._xscale = min;
			object._yscale = min;
		}else{
			object._xscale = max;
			object._yscale = max;
		}
		object.onComplete = function(){
			Bada.puls(movie,min,max);
		}
		caurina.transitions.Tweener.addTween(movie, object);
	}
	public static function pulsAbort(movie:MovieClip,css:Object){
		caurina.transitions.Tweener.removeTweens(movie);
		css._xscale = 100;
		css._yscale = 100;
		css.time = .8;
		caurina.transitions.Tweener.addTween(movie,css);
	}
	
	
	
	/*** WAITING **/
	
	private static var _waiters:Array = [];
	private static var _interval:Number;
	
	public static function wait(callback:Function, time:Number){
		Bada._waiters.push({
			handler:callback,
			time:time
		});
		if (Bada._interval == null) Bada._interval = setInterval(Function.bind(waitTick,Bada),200);
	}
	public static function pause() {
		if (Bada._interval != null) {
			clearInterval(Bada._interval);
		}
		Bada._interval = null;
	}
	public static function resume() {
		if (Bada._interval != null) return;
		if (Bada._waiters.length == 0) return;
		Bada._interval = setInterval(Function.bind(Bada.waitTick,Bada),200);
	}
	public static function abort() {
		if (arguments.length == 0) {
			for (var i = 0; i < _waiters.length; i++) {
				if (_waiters[i].handler == arguments[0]) {
					_waiters.splice(i, 1);
					i--;
				}
			}
		}
		if (_interval) clearInterval(_interval);
		_waiters.splice(0);
	}
	
	private static function waitTick() {
		for(var i = 0; i< _waiters.length; i++){
			_waiters[i].time -= 200;
			
			if (_waiters[i].time < 0) {
				_waiters[i].handler();
				_waiters.splice(i,1);
				i--;
			}
		}
		if (_waiters.length == 0) {
			clearInterval(_interval);
			_interval = null;
		}
	}
	
	
	private static var _:Number = (function() {
		if (Bada.smallscreen){
			_root._xscale = 50;
			_root._yscale = 50;
		}
		
		/*_root.createEmptyMovieClip('proxy', _root.getNextHighestDepth());
		var _proxy = _root['proxy'];
		_proxy._y = - 1000;
		_proxy._x = - 1000;
		_proxy.loadMovie('proxy.swf');*/
		
		return 1;
	})();
	
}