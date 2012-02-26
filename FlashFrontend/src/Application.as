import bada.dom.animation.CssAnimation;
import bada.dom.Dom;
import bada.dom.element.Div;
import bada.dom.element.INode;
import bada.dom.StyleSheets;
import bada.dom.widgets.Launcher;
import bada.dom.widgets.View;
import bada.views.DebugView;
/**
 * ...
 * @author tenbits
 */
class Application
{
	
	static function startApp() {
		
		
		
		/* #region CSS */ { 
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
			},
			'#mainView', {
				backgroundColor: 0xBADA55,
				backgroundImage: 'noise.png',
				backgroundRepeat: 'repeat'
			},
			'.title', {
				backgroundColor:0xff0000,
				color:0xfafafa,
				fontSize: 29,
				textAlign: 'center'
			});
		}
		
		Dom.body.append("
			<menuView id='viewMenu' background='carbon.png repeat'>
				<div id='subGradient' background='gradient(0xff0000,0x00ff00,0x0000ff)'/>
				<div> 					
					<span><b>Hello</b> <i>world!</i></span>
					</div>
				<div style='height:100;'/>	
				<button id='btnSample'>Sample</button>
			</menuView>
			<mainView id='mainView'><span class='title'>Main View</span></mainView>
			");
		
		Dom.body.find('#btnSample').hover(function(button:INode) {
			button.addClass('active');
		}, function(button:INode) {
			button.removeClass('active');
		}).touchEnd(View.open.bind(View, 'mainView'));
		
		
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
		
		
		var div:Div = (new Div( {
			backgroundColor:0xffffff,
			width:100,
			height:100,
			x: '50%',
			y:40,
			borderRadius:12,
			boxShadow: '0 0 6 6 0xff0000'
		})).appendTo(Dom.body.find('#mainView').asDiv());
		
		var rotation:CssAnimation = new CssAnimation( {
			_0: {
				rotation: 0
			},
			_40: {
				rotation: 45				
			},
			_60: {
				rotation: 90
			},
			_80: {
				rotation: 180
			},
			_100: {
				rotation: 360
			}
		});
		
		rotation.start(div, 10);
		
	}
}