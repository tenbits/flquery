import flash.geom.Point;

class caurina.Rotator {

    private
    var target: Object;

    private
    var offset: Number;

    /**
                 * Registration point - the point around which the rotation takse place
                 */
    private
    var point: Point;

    /**
                 * Distance between the registration point of the display object and the registration 
                 * point of the rotator
                 */
    private
    var dist: Number;

    public
    function Rotator(target: MovieClip, registrationPoint: Point) {
        this.target = target;
        setRegistrationPoint(registrationPoint);
    }

    public
    function setRegistrationPoint(registrationPoint: Point) : Void {
        if (registrationPoint == null) point = new Point(target._x, target._y);
        else point = registrationPoint;

        var dx: Number = point.x - target._x;
        var dy: Number = point.y - target._y;
        dist = Math.sqrt(dx * dx + dy * dy);

        var a: Number = Math.atan2(dy, dx) * 180 / Math.PI;
        offset = 180 - a + target._rotation;
    }

    /**
                 * Sets the rotation to the angle passed as parameter.
                 * 
                 * Since it uses a getter/setter Rotator can easily be used with Tween or Tweener classes.
                 */
    public
    function set rotation(angle: Number) : Void {
        var tp: Point = new Point(target._x, target._y);

        var ra: Number = (angle - offset) * Math.PI / 180;

        target._x = point.x + Math.cos(ra) * dist;
        target._y = point.y + Math.sin(ra) * dist;

        target._rotation = angle;
    }
    
	/**
	 * 
	 * @param	target MovieClip or TextField
	 * @param	angle
	 * @param	x
	 * @param	y
	 */
	public static function rotate(target:Object,angle:Number, x:Number, y:Number, width:Number, height:Number){
		
		if (x == null) x = (width || target._width) / 2;
		if (y == null) y = (height || target._height) / 2;
		
		
		if (x == 0 && y == 0) {
			target._rotation = angle;
			return;
		}
		
		x += target._x;
		y += target._y;
		
		var dx:Number = x - target._x;
		var dy:Number = y - target._y;
		
	   
		
		var dist:Number = Math.sqrt(dx * dx + dy * dy);

		
		var a = Math.atan2(dy, dx) * 180 / Math.PI;
		
		
		var offset = 180 - a + target._rotation;
		
		var ra: Number = (angle - offset) * Math.PI / 180;

		target._x = x + Math.cos(ra) * dist;
		target._y = y + Math.sin(ra) * dist;
		
		
		target._rotation = angle;
	}

    public
    function get rotation() : Number {
        return target._rotation;
    }

    public
    function rotateBy(angle: Number) : Void {
        var tp: Point = new Point(target._x, target._y);
        var ra: Number = (target._rotation + angle - offset) * Math.PI / 180;
        target._x = point.x + Math.cos(ra) * dist;
        target._y = point.y + Math.sin(ra) * dist;
        target._rotation = target._rotation + angle;
    }
}