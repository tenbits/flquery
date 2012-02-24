import bada.dom.animation.AnimationProperty;
import bada.views.MainView;
/**
 * ...
 * @author tenbits
 */
class bada.dom.animation.Animation
{
	public var _object: Object;
	public var _movie:MovieClip;
	private var _properties:/*bada.dom.animation.AnimationProperty*/Array;
	
	/**
	 * Used to animate properties in a loop
	 * 1. object:Object, key, minValue, maxValue, speed, startValue
	 * 2. object:Object, AnimationProtperty
	 * 3. object:Object, [AnimationProtperty]
	 * @param	object
	 */
	public function Animation(object:Object) 
	{
		this._object = object;
		
		if (arguments[1] instanceof AnimationProperty) {
			this._properties = [arguments[2]];
		}else if (arguments[1] instanceof Array) {
			this._properties = arguments[2];
		}else if (typeof arguments[1] === 'string') {
			this._properties = [new AnimationProperty(arguments[1], arguments[2], arguments[3], arguments[4], arguments[5])];
		}
	}
	
	/**
	 * 
	 * @param	movie used only form applying onenterframe
	 */
	public function start(movie:MovieClip) {
		this._movie = movie;
		this._movie.onEnterFrame = this.onframe.bind(this);
		
		for (var i:Number = 0; i < this._properties.length; i++) 
		{
			this._properties[i].start(this._object);
		}		
	}
	
	public function stop() {		
		delete this._movie.onEnterFrame;
	}
	
	private static var counter:Number = 0
	private static var skippedFrames:Number;
	public  static function setSkippedFrames(framesToScip:Number) {
		skippedFrames = framesToScip || null;
	}
	
	private function onframe() {
		if (skippedFrames != null) {
			counter++;
			if (counter % skippedFrames != 0) return;		
		}
		
		for (var i:Number = 0; i < this._properties.length; i++) 
		{
			this._properties[i].nextStep(this._object);
		}
		
		this._object.refresh();
	}
}