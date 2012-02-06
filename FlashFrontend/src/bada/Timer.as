import bada.dom.element.Span;
class bada.Timer{
    
    private static var $text:Span;
    private static var timer:Number = null;
    public static var seconds:Number = null;
    private static var isPaused:Boolean = null;
    
    public static function setup($span:Span){
        setup = Bada.doNothing;
		$text = $span;
        
		isPaused = false;
        seconds = 0;
    }
    
    public static function start():Void{
        if (timer) return;
        timer = setInterval(onsecond,1000)
    }
	
	private static function onsecond() {
		Timer.seconds++;            
		var min = Math.floor(Timer.seconds / 60);
		var sec = Timer.seconds - 60 * min;
		
		if (min < 10){
			min = '0' + min;
		}
		if (sec < 10){
			sec = '0' + sec;
		}
		
		Timer.$text.text(min + ':' + sec);
	}
    
    public static function stop():Void{
		if (timer){
			clearInterval(timer);
			timer = null;
			isPaused = false;
		}
    }
    public static function reset():Void{
        if (timer) clearInterval(timer);
		timer = null;
        seconds = 0;
        isPaused = false;
		Timer.$text.text('00:00');
    }
}