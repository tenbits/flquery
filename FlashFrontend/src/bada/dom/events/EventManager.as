import bada.dom.element.Button;
import bada.dom.element.Div;
import bada.dom.Dom;
import bada.dom.events.Event;
import bada.dom.element.INode;
import bada.dom.element.Span;
import bada.dom.widgets.BadaMenu;
import bada.dom.widgets.DebugView;
import bada.views.MainView;
import mx.data.encoders.Num;
/**
 * ...
 * @author tenbits
 */
class bada.dom.events.EventManager
{
	public static function setup() {
		setup = Bada.doNothing;
		
		_root.onMouseDown = function(){
			EventManager.evaluate('touchStart', _root._xmouse, _root._ymouse);
		}
		_root.onMouseUp = function(){
			EventManager.evaluate('touchEnd', _root._xmouse, _root._ymouse);
		}
	}
	
	private static function hover2() : Function {
        return function($div: MovieClip) : Void {
            $div['img2']._y = 1;
            $div.onMouseUp = function() {
                $div['img2']._y = $div._height / -2;
                delete $div.onMouseUp;
            }
        }

    }
	
	public static var _hovers:Array = [];
	public static function hover(node:INode, start:Function, end:Function):Void {
		
		/*node.movie.onPress = function() {
			start(node);
			
			node.movie.onMouseUp = function() {
				end(node);
				delete node.movie.onMouseUp;
			}
		}*/
		
		node.bind('touchStart', function() {
			start(node);
			node.movie.onMouseUp = function() {
				end(node);
				delete node.movie.onMouseUp;
			}
		});
		
		_hovers.push(node);
	}
	
	
	public static var _events:Array = [];
	public static function bind(node:INode, event:String, handler:Function):Void {
		if (typeof node.movie != 'movieclip') Bada.log('Error: binding event, but movieclip is undefined');
		
		_events.push({
			node:node,
			event:event,
			handler:handler
		});
		if (event == 'move') {
			node.bind('touchStart', EventManager.startMove);
		}
		
		if (event == 'click') {
			node.movie.onRelease = EventManager.onPress();
		}        
	}
	
	public static function bindAll(node:INode) {
		var touchStarts:Array = node._events.get('touchStart');
		if (touchStarts) {
			for (var i:Number = 0; i < touchStarts.length; i++) 
			{
				EventManager.bind(node, 'touchStart', touchStarts[i]);
			}
		}
		var touchEnds:Array = node._events.get('touchEnd');
		if (touchEnds) {
			for (var i:Number = 0; i < touchEnds.length; i++) 
			{
				EventManager.bind(node, 'touchEnd', touchEnds[i]);
			}
		}
		var moves:Array = node._events.get('move');
		if (moves) {
			for (var i:Number = 0; i < moves.length; i++) 
			{
				EventManager.bind(node, 'move', moves[i]);
			}
		}
	}
	
	/**
	 * @param	node - INode with event
	 * @param	arg - {Function (function reference to unbind) | String (event name to unbind)}
	 */
	public static function unbind(node:INode, arg:Object):Void {
		var valueToCheck:String = null;
		
		
        switch(typeof arg){
            case 'function': valueToCheck = 'handler';break;
            case 'string': valueToCheck = 'event';break;
        }
        
        for(var i = 0; i< _events.length; i++){
            if (_events[i].node != node) continue;
            
			if (valueToCheck == null || _events[i][valueToCheck] == arg){
                _events.splice(i,1);
                i--;
            }
        }
		
		if (arg == 'move') {
			node.movie.onMouseMove = null;
			node.unbind(EventManager.startMove);
		}
		
		if (arg == null){
			for (var j:Number = 0; j < _hovers.length; j++) 
			{
				if (_hovers[j] == node) {
					_hovers.splice(j, 1);
					j--;
				}
			}
		}
	}
	
	public static function evaluate(event:String, x:Number, y: Number) {
		
		if (x == null) x = _root._xmouse;
		if (y == null) y = _root._ymouse;
		
		var _do:Array = null;
		
		if (event == 'move') {
			Dom.body.movie.onMouseMove(x, y);
			return;
		}
		
		if (event == 'touchEnd' && Dom.body.dragging){
			/*for (var i = 0; i < _events.length; i++) {
				if (_events[i].event == 'move')  _events[i].node.movie.onMouseMove = null;
			}*/
			delete Dom.body.movie.onMouseMove;
			Dom.body.dragging = false;
			Dom.body.trigger('moveEnd');
			return;
		}
		
		var top:Object = EventManager.topElement(event, x, y);
		
		if (top != null) {
			//EventManager.bubble(top.node, top.event);
			INode(top.node).trigger(event, new Event(top.node, x, y));
		}
	}
	
	private static function topElement(event:String, x:Number, y:Number) {
		var top:Object = null;
		
		for (var i = 0; i < _events.length; i++) {
			if (_events[i].event != event) continue;			
			if (_events[i].node._movie._visible && _events[i].node._movie.hitTest(x, y, true)) {
				
				if (EventManager.isOver(top, _events[i])) {					
					top = _events[i];
				}
			}
		}		
		return top;
	}
	
	private static function bubble(node:INode, event:String, counter:Number) {
		if (node == null) return;
		
		for (var i = 0; i < _events.length; i++) {
			if (_events[i].node == node && _events[i].event == event) {
				if (_events[i].handler(node) == false) {
					Bada.log('stop bubbling');
					return;
				}
			}
		}
		EventManager.bubble(node._parent, event);
	}
	
	private static function isOver(current:Object,value:Object):Boolean {
		if (current == null) return true;
		if (value == null) return false;
		if (current.node == value.node) return true;
		
		
		
		var valuePath = EventManager.getDepthPath(value.node.movie);
		if (valuePath == null) return false;
		
		
		var currentPath = EventManager.getDepthPath(current.node.movie);
		
		
		for (var i = 0, length = Math.max(currentPath.length, valuePath.length); i < length; i++) {
			if (currentPath[i] === valuePath[i]) continue;
			return (currentPath[i] == null ? -1 : currentPath[i]) < (valuePath[i] == null ? -1 : valuePath[i]);
		}
	}
	
	/**
	 * return NULL if movie or parents are invisible
	 * @param	movie
	 * @return
	 */
	private static function getDepthPath(movie:MovieClip):Array {
		
		if (movie._visible == false) return null;
		
		var path:Array = [];
		path.unshift(movie.getDepth());
		
		var parent: MovieClip = movie._parent;
		if (parent._visible == false) return null;
		var parentsDepth: Number = parent.getDepth();
		var counter = 0;
		
		while (parent && parentsDepth > -1) {
			path.unshift(parentsDepth);
			parent = parent._parent;
			if (parent._visible == false) return null;
			
			parentsDepth = parent.getDepth();
			counter++;
		}
		
		return path;
	}
	

	
	private static function startMove(event:Event):Boolean {
		
		var node:INode = event.target;
		for (var i:Number = 0; i < _events.length; i++) 
		{
			if (_events[i].node == node && _events[i].event == 'move') {
				if (_events[i].node.enabled == false) {
					return true;
				}
				
				Dom.body.movie.onMouseMove = _events[i].handler;//_events[i].handler;
				//node.movie.onMouseMove = _events[i].handler;
				Dom.body.dragging = true;
			}
		}
		
		return true;
	}
	
	private static function onPress():Function {
		
		return function() {
			for (var i:Number = 0; i < EventManager._events.length; i++) 
			{
				if (EventManager._events[i].node.movie == this && EventManager._events[i].event == 'click') {
					EventManager._events[i].handler(EventManager._events[i].node);
				}
			}
		}
	}
}