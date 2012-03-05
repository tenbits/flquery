import bada.dom.animation.CssAnimation;
import bada.dom.element.Div;
import bada.dom.widgets.BadaMenu;
import bada.dom.widgets.View;

class views.MainView extends bada.dom.widgets.View {
	public static var Instance:MainView;
	
	private var _spinner:CssAnimation;
	function MainView(parent: Div, data: Object) {
		super(parent, data);        
		Instance = this;
		
		this._spinner = new CssAnimation( {
			_0: {
				rotation: 0
			},			
			_100: {
				rotation: 360
			}
		});
		
		this.find('button').touchEnd(View.open.bind(View, 'menuView'));
	}
	
	function activate():Void 
	{
		this._spinner.start(this.find('.spinner'), 3);		
		BadaMenu.Instance.hide();
	}
	
	function deactivate():Void 
	{
		this._spinner.stop();
	}
	
	
	
}