import bada.dom.element.Div;
import bada.dom.Dom;
import bada.dom.events.Event;
import flash.geom.Rectangle;
/**
 * ...
 * @author tenbits
 */
class bada.dom.helper.Draggable
{
	private static var _current:Div;	
	private static var _currentBounds:Rectangle;
	private static var _lastX:Number;
	private static var _lastY:Number;
	
	private static var _deferredX:Number;
	private static var _deferredY:Number;
	
	public function Draggable() 
	{
		
	}

	
	public static function enable(div:Div, touchContext:Div) {
		
		if (touchContext != null){
			touchContext.data('contextFor', div);
			div = touchContext;
		}
		div.movie.hitArea = touchContext.movie;
		div.bind('touchStart', moveStart);
		div.bind('move', move);
		Dom.body.bind('moveEnd', moveEnd);
	}
	
	private static function move(x:Number, y:Number) {
		if (x == null) {
			x = _root._xmouse;
			y = _root._ymouse;
		}
		
		
		if (_deferredX == null) _deferredX = 0;
		if (_deferredY == null) _deferredY = 0;
		_deferredX += -_lastX + x;
		_deferredY += -_lastY + y;
		
		_lastX = x;
		_lastY = y;
		
	}
	
	private static function refresh() {
		var movie:MovieClip = _current.movie;
		if (_deferredX != null) {
			var x = movie._x + _deferredX;			
			
			if (_currentBounds != null) {
				if (x < _currentBounds.x) x = _currentBounds.x;
				if (x > _currentBounds.x + _currentBounds.width) x = _currentBounds.x + _currentBounds.width;			
			}
			movie._x = x
			
			_deferredX = null;
		}
		if (_deferredY != null) {
			var y = movie._y + _deferredY;		
			
			if (_currentBounds != null) {
				if (y < _currentBounds.y) y = _currentBounds.y;
				if (y > _currentBounds.y + _currentBounds.height) y = _currentBounds.y + _currentBounds.height;			
			}
			movie._y = y
			
			_deferredY = null;
		}
	}
	
	private static function moveStart(event:Event) {	
		var element:Div = event.target.asDiv(),
		iscontextFor:Div = Div(element.data('contextFor'));
		
		_current = iscontextFor || element;
		_currentBounds = _current._css.draggable;
		_current.movie.onEnterFrame = refresh;
		_lastX = event.pageX;
		_lastY = event.pageY;				
	}
	
	private static function moveEnd() {
		_current.trigger('moveEnd');
		delete _current.movie.onEnterFrame;
		_lastX = null;
		_lastY = null;
		_current = null;
		_deferredX = null;
		_deferredY = null;
	}
	
}