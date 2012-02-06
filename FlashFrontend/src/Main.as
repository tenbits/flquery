import bada.dom.CSS;
import bada.dom.Dom;
import bada.dom.events.EventManager;
import bada.Events;
import bada.Proxy;
import bada.Utils;
import bada.views.BookmarksView;
import bada.views.InfoView;
import bada.views.MainView;
import bada.views.MenuView;
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
		bada.dom.NodesFabric.controls['mainView'] = MainView;
		bada.dom.NodesFabric.controls['menuView'] = MenuView;
		bada.dom.NodesFabric.controls['infoView'] = InfoView;
		
		var start = getTimer();
		bada.Game.startApp();
		Bada.log('AppStart', getTimer() - start);
		
		Events.bind("multitouch", function(event, x, y) {
			x = parseInt(x);
			y = parseInt(y);
			//handle hover
			for (var i:Number = 0; i < EventManager._hovers.length; i++) 
			{
				var movie = EventManager._hovers[i].movie;
				if (event == 'touchStart'){
					if (movie.hitTest(x, y, true)) {
						movie.onPress();
					}
				}
				else if (event == 'touchEnd' && movie.onMouseUp != null) {
					movie.onMouseUp();
				}
			}
			
			EventManager.evaluate(event, x, y);
		});
		
	}
	
	
}