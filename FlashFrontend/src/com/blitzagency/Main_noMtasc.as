import com.blitzagency.xray.util.XrayLoader;
import com.blitzagency.xray.logger.LogManager;
import com.blitzagency.xray.logger.XrayLog;

class com.blitzagency.Main_noMtasc 
{
	static var app : Main_noMtasc;
	static var logger:Object;
	static var log:XrayLog;

	function Main_noMtasc() 
	{
		LogManager.initialize();
		run();
	}

	// entry point
	public static function main(mc) 
	{
		app = new Main_noMtasc();
	}
	
	private function run(evtObj:Object):Void
	{
		createTextBox();
		
		// create bogus object for tracing
		var obj:Object = {};
		obj["John"] = {};
		obj["John"].phone = "ring";
		
		// create the logger object
		logger = LogManager.getLogger("com.blitzagency.xray.logger.XrayLogger");
		
		// levels: debug=0; info=1; warn=2; error=3; fatal=4;
		logger.setLevel(0);
		
		/*usage
		* 
		* 	logger.debug("testing Logger", obj);
			logger.info("testing Logger", obj);
			logger.warn("testing Logger", obj);
			logger.error("testing Logger", obj);
			logger.fatal("testing Logger", obj);
		* 
		* */
		
		// log it
		logger.debug("testing Logger", obj);
	}
	
	private function createTextBox():Void
	{
		_level0.createTextField("tf",0,0,0,800,600);
		_level0.tf.text = "FLASC ROCKS!@!@##";
	}
}