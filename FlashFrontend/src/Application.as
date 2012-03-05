import bada.dom.Dom;
import bada.dom.StyleSheets;
import bada.dom.widgets.BadaMenu;
import bada.dom.widgets.Launcher;
import bada.dom.widgets.View;
/**
 * ...
 * @author tenbits
 */
class Application
{
	
	static function startApp() {
		/* #region CSS */ { 
		StyleSheets.register(
			'#menuView', {
				padding: [70, 30, 10, 30]
			},			
			'#mainView', {
				backgroundColor: 0xBADA55,
				backgroundImage: 'ex.background.noise.png',
				backgroundRepeat: 'repeat'
			});
		}
		
		Dom.body.append("
			<menuView id='menuView' background='ex.background.test.png repeat'>
				<div class='header'>Sample Application</div>
				<div	style = 'height:40; position:static; borderRadius:15;' 
					border = '1 0x555555' 
					background = 'gradient(0xff0000,0x00ff00,0x0000ff)' />
					
				<div class='group'>
					<div class='group-header'>Grouped List</div>
					<div name='listview'>
						<div class='item' hover='hover' id='tr'>
							<span style='x:50; y:50%;'>CheckBox</span>
							<checkbox background='ex.checkbox.png' style='right:50; y:50%;'/>
							</div>
						<div class='divider'/>
						<div class='item' hover='hover'>
							<span style='x:50; y:50%;'>ComboBox</span>
							<combobox style='right:50; y:50%;'>
								<item active='true' value='1' action='1'/>
								<item value='2' action='2'/>
								<item value='3' action='3'/>
							</combobox>
							</div>
						<div class='divider' />
						<div class='item'>
							<span style='x:50; y:50%;'>Button</span>
							<button hover='hover' style='right:50; y:50%;'>Sample</button>
						</div>
						<div class='divider' />
						<div class='item'>
							<slideSelect style='position:static;y:50%; height: 60; margin:0 50 0 50;'>
								<item value='One'/>
								<item value='Two'/>
								<item value='Three'/>
							</slideSelect>
						</div>
						<div class='divider' />
						<div class='item'>
							<span style='x:50; y:50%;'>ToggleSlide</span>
							<toggleSlide style='right:50; y:50%;' />
						</div>
						<div class='divider' />
						<div class='item'>
							<span style='x:50; y:50%;'>Input</span>
							<input _text = 'Input' style='color:0xffffff; width: 50%; right: 30; height: 40; y: 50%;' />							
						</div>
						<div class='divider' />
						<div class='item'>
							<span style='x:50; y:50%;'>Forms</span>
							<button class='green' id='btnMainView' hover='hover' style='right:50; y:50%;'>Main View</button>
						</div>
						</div>
					</div>			
			</menuView>
			<mainView id='mainView'>
				<div class='header'>
					<button>back</button>
					<span>Main View</span></div>
				<div class='spinner' style='x:50%; y:50%;'></div>
				</mainView>
			");
		
		Dom.body.find('#btnMainView').touchEnd( View.open.bind(View, 'mainView'));
		
		
		//DebugView.setup();			
		
		Launcher.remove();	
		View.setupMain('menuView');	
		
		var badaMenu = (new BadaMenu(Dom.body, {
			items:[ {
				_css: { backgroundImage: 'ex.icon-1.png' },
				label: 'Icon',
				position: 0
			},{
				_css: { backgroundImage: 'ex.icon-2.png' },
				label: 'Tree',
				position: 1
			},{
				_css: { backgroundImage: 'ex.icon-3.png' },
				label: 'Smile',
				position: 2
			}]
		}));
	}
}