import bada.dom.Dom;
import bada.dom.element.Div;
import bada.dom.LocalStorage;
import bada.dom.StyleSheets;
import bada.dom.widgets.BadaMenu;
import bada.dom.widgets.Launcher;
import bada.dom.widgets.View;
import bada.Events;
import bada.GameDialogs;
import bada.Helper;
import bada.Highscore;
import bada.Proxy;
import bada.SoundController;
import bada.Spruche;
import bada.views.DebugView;
import bada.views.InfoView;
import bada.views.MainView;

class bada.Game {
	
	
	public static function startApp() : Void {			
		
		
		Game.ready();
	} 
	
	private static function ready() {
		
		
		
	}
	
	
	
	private static function onMenuSelect(name:String):Void {
		var menu:BadaMenu = BadaMenu.Instance;
		
		switch(name) {
				
		}
	}

}