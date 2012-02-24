import bada.dom.Dom;
import bada.dom.element.Div;
import bada.dom.LocalStorage;
import bada.dom.StyleSheets;
import bada.dom.widgets.BadaMenu;
import bada.dom.widgets.Dialog;
import bada.dom.widgets.Launcher;
import bada.dom.widgets.View;
import bada.Events;
import bada.GameDialogs;
import bada.Helper;
import bada.Highscore;
import bada.Proxy;
import bada.Spruche;
import bada.views.DebugView;
import bada.views.InfoView;
import bada.views.MainView;
import maze.Settings;

class bada.Game {
	
	
	public static function startApp() : Void {			
		
		var a = new Settings();
		
		Dom.body.append("
			<mainView id='mainView' background='background.png'/>
			<menuView id='menuView' background='view-menu.background.png'/>
			<infoView id='infoView' background='view-menu.background.png'/>
			<levelsView id='levelsView' background='view-menu.background.png'/>
			");
		
		
		GameDialogs.setup();		
		
		//SoundController.setup();
		
		DebugView.setup();
		
		
		Launcher.remove();	
		
		Settings.Instance().restore(function() {
			View.setupMain('menuView');
			Bada.log('openedLevel', Settings.Instance().openedLevel);
			//View.setupMain('mainView').activate(0);
		});
		
		//
		
		//Dialog.show('gameOver');
		//MainView.Instance.pause();
	} 
	
	
	
	
	private static function onMenuSelect(name:String):Void {
		var menu:BadaMenu = BadaMenu.Instance;
		
		switch(name) {
				
		}
	}

}