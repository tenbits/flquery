import bada.dom.Dom;
import bada.dom.element.Div;
import bada.dom.element.INode;
import bada.dom.LocalStorage;
import bada.dom.StyleSheets;
import bada.dom.widgets.View;
import bada.views.DebugView;
import bada.dom.widgets.Launcher;
/**
 * ...
 * @author tenbits
 */
class Application
{
	
	static function startApp() {
		
		StyleSheets.register(
			'#viewMenu > div', {
				backgroundColor:0xff0000,
				position:'static',
				borderRadius:20,
				margin:20,
				padding:10,
				border:[2,0x00ff00, 90]
			},
			'#subGradient', {
				height:200
			},
			'#viewMenu > div > span',{
				color:0xffffff,
				fontSize:40,
				position:'static',
				textAlign:'center'
			},
			'button', {
				width: 150,
				height: 64,
				color:0xffffff,
				fontSize: 20,
				x: '50%',
				position:'static',
				backgroundGradient: {
					colors: [0x555555, 0x303030],
					radius: Math.PI / 2
				},
				borderRadius: 12,
				border: [1, 0]
			},
			'button.active', {
				backgroundGradient: {
					colors: [0x111111, 0x444444],
					radius: Math.PI / 2
				}
			});
		
		Dom.body.append("
			<menuView id='viewMenu' background='carbon.png repeat'>
				<div id='subGradient' background='gradient(0xff0000,0x00ff00,0x0000ff)'/>
				<div> 
					<span><b>Hello</b> <i>world!</i></span>
					</div>
				<div style='height:100;'/>	
				<button id='btnSample'>Sample</button>
			</menuView>
			");
		
		Dom.body.find('#btnSample').hover(function(button:INode) {
			button.addClass('active');
		}, function(button:INode) {
			button.removeClass('active');
		});
		
		
		DebugView.setup();		
		setTimeout(function() {
			Dom.body.find('#viewMenu').find('span').asSpan().html('Hello <br/> world!');						
			setTimeout(function() {
				Dom.body.find('#viewMenu').children().get(1).append(new Div( {
					_css: {
						position:'static',
						height:100,
						width:200,
						backgroundColor:0x000000
					}
				}));
			}, 1000);
			
		}, 1000);
		
		Launcher.remove();	
		View.setupMain('viewMenu');
	}
	
}