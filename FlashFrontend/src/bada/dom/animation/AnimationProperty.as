/**
 * ...
 * @author tenbits
 */
class bada.dom.animation.AnimationProperty
{
	public var key:String;
	public var minValue:Number;
	public var maxValue:Number;
	public var speed:Number;
	public var startProperty:Number;
	public function AnimationProperty(key:String, minValue:Number, maxValue:Number, speed:Number, start:Number) 
	{
		this.key = key;
		this.minValue = minValue;
		this.maxValue = maxValue;
		this.speed = speed;
		this.startProperty = start;
	}
	
	public function nextStep(object:Object) {
		var value = object[key];
		if (value <= minValue && speed < 0) {
			speed *= -1;
		}
		else if (value >= maxValue && speed > 0) {
			speed *= -1;
		}
		
		value += speed;
		
		if (value < minValue) value = minValue;
		if (value > maxValue) value = maxValue;
		
		object[key] = value;
	}
	
	public function start(object:Object) {
		if (this.startProperty == null) return;
		object[key] = this.startProperty;
	}
}