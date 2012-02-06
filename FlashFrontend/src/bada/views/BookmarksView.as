import bada.dom.element.Div;
import bada.dom.widgets.View;
import bada.Highscore;

/**
 * ...
 * @author tenbits
 */
class bada.views.BookmarksView extends View
{
	public function BookmarksView(parent: Div, data: Object) 
	{
		super(parent, data);
		
		
		append([ {
			_id:'divHighscore',
			_css: {
				x:385,
				y:142,
				width:260,
				height:300,
				opacity:.5
			}
		},{
			tag:'button',
			_id:'btnHighscoreBack',
			_css: {
				width:64,
				height:54,
				bottom: 20,
                right: 20,
				//backgroundColor:0xffffff
                backgroundImage: 'external/800/buttons/btnBack.png'
			},
			handler: {
				touchEnd: function() {
					View.open('viewMenu','back');
				}
			}
		}]);
	}
	
	public function activate() {
		
	}
	
	
	
}