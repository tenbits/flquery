/*
Copyright (c) 2006, 2007 Nicholas Bilyk
 */


	
	import flash.geom.Point;

	class com.nbilyk.utils.CoordMath {
		public static function convertCoords(point:Point, from_mc:MovieClip, to_mc:MovieClip):Point {
			if (to_mc == null || from_mc == null) return point.clone();
			from_mc.localToGlobal(point);
			to_mc.globalToLocal(point);
			return point;
		}
		public static function convertDistance(distance:Point, from_mc:MovieClip, to_mc:MovieClip):Point {
			if (to_mc == null || from_mc == null) return distance.clone();
			var topLeft:Point = new Point(0, 0);
			topLeft = CoordMath.convertCoords(topLeft, from_mc, to_mc);
			distance = CoordMath.convertCoords(distance, from_mc, to_mc);
			distance.x -= topLeft.x;
			distance.y -= topLeft.y;	
			return distance;
		}
	}
