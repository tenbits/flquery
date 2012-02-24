import bada.dom.css.StyleSheet;
import bada.dom.element.Div;
import bada.dom.helper.XmlParser;
import bada.dom.StyleSheets;
import bada.dom.widgets.Dialog;
import bada.dom.widgets.View;
import bada.Events;
import bada.Game;
import views.MainView;
import flash.geom.Point;
import flash.geom.Rectangle;
import maze.Settings;
/**
 * ...
 * @author tenbits
 */
class bada.GameDialogs
{
	
	public static function setup() {
		
			
		
		var gameOver:Div = Dialog.register('gameOver', {
			_css: {
				width:400,				
				height:300,
				y:180,
				x: 40,
				backgroundGradient: {
					colors: [0x555555, 0x333333, 0x111111],
					ratios: [0, 50, 255],
					radius: Math.PI / 2,
					alphas: [90,90,90]
				},
				borderRadius:12,
				border: [1,0xffffff,70],				
				color:0xffffff,
				fontSize:20
			},
			_children:XmlParser.parseHtml("
				<span style='width:100%;textAlign:center; height:80%; verticalAlign:middle;' class='title'>Verloren</span>
				<button 
					id='btnTry'
					border = 'borderImage(view-main.button.png 30 0 0 80 80)' 
					style = 'width:150; height:75; bottom:10; left:10;'>Neu Starten</button>
				<button 
					id='btnMenu'
					border = 'borderImage(view-main.button.png 30 0 0 80 80)' 
					style='width:150; height:75; bottom:10; right:10;'>Menu</button>
				")
		});
		
		StyleSheets.register('.dialogButtonHover', {
			borderImage: ['view-main.button.png', 30, new Rectangle(0,80,80,80)]
		});
		
		gameOver.find('#btnTry').bind('touchEnd', function() {
			Dialog.close();
			MainView.Instance.restart();
		}).hover(hoverOn, hoverOff);
		gameOver.find('#btnMenu').bind('touchEnd', function() {
			Dialog.close();
			View.open('menuView');
		}).hover(hoverOn, hoverOff);
		
		
		
		/** level Completed */
		var levelCompleted :Div = Dialog.register('levelCompleted', {
			_css: {
				width:400,				
				height:300,
				y:180,
				x: 40,
				backgroundGradient: {
					colors: [0x555555, 0x333333, 0x111111],
					ratios: [0, 50, 255],
					radius: Math.PI / 2,
					alphas: [90,90,90]
				},
				borderRadius:12,
				border: [1,0xffffff,70],				
				color:0xffffff,
				fontSize:20
			},
			_children:XmlParser.parseHtml("
				<span style='width:100%;textAlign:center; height:80%; verticalAlign:middle; fontSize: 30;'>Level beendet!</span>
				<button 
					id='btnNext'
					border = 'borderImage(view-main.button.png 30 0 0 80 80)' 
					style = 'width:150; height:75; bottom:10; left:10;'>Weiter</button>
				<button 
					id='btnMenu'
					border = 'borderImage(view-main.button.png 30 0 0 80 80)' 
					style='width:150; height:75; bottom:10; right:10;'>Menu</button>
				")
		});
		
		levelCompleted.find('#btnNext').bind('touchEnd', function() {
			Dialog.close();			
			MainView.Instance.activate(++Settings.Instance().currentLevel);
		}).hover(hoverOn, hoverOff);
		levelCompleted.find('#btnMenu').bind('touchEnd', function() {
			Dialog.close();		
			View.open('menuView');
		}).hover(hoverOn, hoverOff);
		
		
		/** game Completed */
		var gameCompleted :Div = Dialog.register('gameCompleted', {
			_css: {
				width:400,				
				height:300,
				y:180,
				x: 40,
				backgroundGradient: {
					colors: [0x555555, 0x333333, 0x111111],
					ratios: [0, 50, 255],
					radius: Math.PI / 2,
					alphas: [90,90,90]
				},
				borderRadius:12,
				border: [1,0xffffff,70],				
				color:0xffffff,
				fontSize:20
			},
			_children:XmlParser.parseHtml("
				<span style='width:100%;textAlign:center; height:80%; verticalAlign:middle; fontSize: 30;'>Glückwunsch!<br/>Du hast alle Levels gelöst!</span>
				<button 
					id='btnMenu'
					border = 'borderImage(view-main.button.png 30 0 0 80 80)' 
					style='width:150; height:75; bottom:10; right:10;'>Menu</button>
				")
		});
		
		gameCompleted.find('#btnMenu').bind('touchEnd', function() {
			Dialog.close();		
			View.open('menuView');
		}).hover(hoverOn, hoverOff);
	}
	
	private static function hoverOn(button:Div) {
		Bada.log('hoverOn');
		button.addClass('dialogButtonHover');
	}
	private static function hoverOff(button:Div) {
		button.removeClass('dialogButtonHover');
	}
}