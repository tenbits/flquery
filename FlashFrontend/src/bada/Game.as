﻿import bada.dom.Dom;
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
		
		
		
		StyleSheets.register(
			'#viewMenu > div', {
				backgroundColor:0xff0000,
				position:'static',
				height:100,
				borderRadius:20,
				margin:20,
				border:[10,0x00ff00, 50]
			},
			'#subGradient', {
				height:200
			},
			'#viewMenu > span',{
				color:0xffffff,
				fontSize:40,
				position:'static',
				textAlign:'center'
			});
		
		Dom.body.append("
			<menuView id='viewMenu' background='carbon.png repeat'>
				<div id='subGradient' background='gradient(0xff0000,0x00ff00,0x0000ff)'/>
				<div/>
				<span>Hello world!</span>
			</menuView>
			");
		
		
		/*GameDialogs.setup();		
		SoundController.setup();*/
		//Events.bind('proxyready', Game.ready);		
		DebugView.setup();
		
		Bada.log('after setup');
		
		
		Game.ready();
	} 
	
	private static function ready() {
		Launcher.remove();	
		
		/***/
			//View.setupMain('viewMain').activate(); return;
		/***/
		View.setupMain('viewMenu');		
		
		Proxy.confirm('some?', function(answer) {
			Bada.log(answer);
		});
	}
	
	
	
	private static function onMenuSelect(name:String):Void {
		var menu:BadaMenu = BadaMenu.Instance;
		
		switch(name) {
				
		}
	}

}