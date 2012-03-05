import bada.dom.CSS;
import bada.dom.Dom;
import bada.dom.events.EventManager;
import bada.dom.NodesFactory;
import bada.Events;
import bada.Proxy;
import bada.Utils;
import css.ApplicationCSS;
import views.MainView;
import views.MenuView;
import org.flashdevelop.utils.FlashConnect;
/**
 * ...
 * @author tenbits
 */
class Main 
{
	
	public static function main(swfRoot:MovieClip):Void 
	{
		
		Utils.extend();
		Dom.setup();
		Proxy.setup();
		
		///** register custom widgets */
		NodesFactory.controls['mainView'] = MainView;
		NodesFactory.controls['menuView'] = MenuView;
		//NodesFactory.controls['infoView'] = InfoView;
		
		var start = getTimer();
		
		ApplicationCSS.setup();		
		Application.startApp();
		
		Bada.log('AppStart', getTimer() - start);		
		
	}
	
	
}