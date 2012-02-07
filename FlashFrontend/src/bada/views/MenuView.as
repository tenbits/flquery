import bada.dom.CSS;
import bada.dom.css.BackgroundHelper;
import bada.dom.element.Div;
import bada.dom.element.INode;
import bada.dom.events.Event;
import bada.dom.widgets.BadaMenu;
import bada.dom.element.Input;
import bada.dom.widgets.ToggleSlide;
import bada.dom.widgets.View;
import bada.Events;
import bada.Game;
import bada.Spruche;
import bada.views.MainView;
import mx.data.encoders.Num;
import reactor.Settings;
class bada.views.MenuView extends bada.dom.widgets.View {
	
	

	private var name:String;
	function MenuView(parent: Div, data: Object) {
		super(parent, data);
		
		this.name = 'SomeName!!!';
		
		var f = function() {
			Bada.log('infunction',this.name);			
		};
		
	}
	
	
	
}