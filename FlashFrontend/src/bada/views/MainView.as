import bada.dom.animation.AnimationHelper;
import bada.dom.CSS;
import bada.dom.element.Div;
import bada.dom.element.Span;
import bada.dom.widgets.BadaMenu;
import bada.dom.widgets.View;
import bada.Events;
import bada.Graphics;
import bada.Highscore;
import bada.Spruche;
import bada.Utils;
import caurina.transitions.Tweener;
import flash.filters.DisplacementMapFilter;
import flash.geom.Rectangle;
import reactor.Player;
import reactor.puzzle.Equation;
import reactor.puzzle.MathPuzzle;
import reactor.puzzle.Question;
import reactor.puzzle.Test;
import reactor.PuzzleFactory;
import reactor.Settings;
import reactor.Timer;

class bada.views.MainView extends bada.dom.widgets.View {
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