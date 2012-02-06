import com.blitzagency.xray.util.XrayLoader;
import com.blitzagency.xray.logger.LogManager;
import com.blitzagency.xray.logger.XrayLog;

class com.blitzagency.Main 
{
	static var app : Main;
	static var log:XrayLog;

	function Main() 
	{
		LogManager.initialize();
		run();
	}

	// entry point
	public static function main(mc) 
	{
		app = new Main();
	}
	
	private function run(evtObj:Object):Void
	{
		createTextBox();
		
		var obj:Object = {};
		obj["John"] = {};
		obj["John"].phone = "ring";
		
		// reate the logger object
		log = new XrayLog();
		
		/*
		* usage:
		* 
		* 	trace(log.debug("stringMessage"[, object]));
			trace(log.info("stringMessage"[, object]));
			trace(log.warn("stringMessage"[, object]));
			trace(log.error("stringMessage"[, object]));
			trace(log.fatal("stringMessage"[, object]));
			trace("What's obj got!?");
		* */
		trace(log.debug("what's my obj?!", obj));
	}
	
	private function createTextBox():Void
	{
		_level0.createTextField("tf",0,0,0,800,600);
		_level0.tf.text = "FLASC ROCKS!@!@##";
	}
}