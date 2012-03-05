import bada.dom.element.Div;
import bada.dom.widgets.BadaMenu;
import bada.dom.widgets.View;
class views.MenuView extends bada.dom.widgets.View {
	
	

	private var name:String;
	function MenuView(parent: Div, data: Object) {
		super(parent, data);
		
	}
	
	
	function activate() {
		BadaMenu.Instance.show();
	}
}