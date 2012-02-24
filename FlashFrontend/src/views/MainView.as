import bada.dom.element.Div;
import bada.dom.widgets.View;

class views.MainView extends bada.dom.widgets.View {
	public static var Instance:MainView;
	
	function MainView(parent: Div, data: Object) {
		super(parent, data);        
		Instance = this;
		
	}
	
	
	public function view(what:String) {
		switch(what) {
			
		}
	}
	
	
}