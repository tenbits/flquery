import bada.dom.element.Div;
import bada.dom.widgets.View;
import bada.Highscore;
import reactor.Settings;

/**
 * ...
 * @author tenbits
 */
class bada.views.HighscoreView extends View
{
	private static var WIDTH:Number = 400;
	public function HighscoreView(parent: Div, data: Object) 
	{
		super(parent, data);
		
		this.append("<div style='y:10' background='view-settings.headbar.png'>
					<span style='width:480;textAlign:center;height:100%; verticalAlign:middle;fontSize:45;'>Highscore</span>
					<button name='btnHome' style = 'x:380' background='view-settings.btn_home.png' ></button>
					</div>
				<div id='divHighscore' style='x:40;y:140;width:400;height:600;'/>");
		
		this.first('_btnHome').bind('touchEnd', function() {
			View.open('viewMenu');
		});
		
	}
	

	public function activate(currentEntry:Object) {
		Bada.log('currentEntry', currentEntry, currentEntry.name);
		this.first('#divHighscore').empty();

		var _list:Array = Highscore.list[Settings.Instance.players];
		if (_list == null) return;
		
		for (var i = 0; i < _list.length; i++) {
			this.createEntry(_list[i], _list[i] == currentEntry);
		}
	}
	
	private function createEntry(entry:Object, current:Boolean) {
		
		this.first('#divHighscore').append( {
			_css: {
				height: 50,
				width: '100%',
				position: 'static',
				margin: 5,
				backgroundColor: current ? 0x048804 : 0x000000,
				borderRadius: 6,
				opacity: .7
			},
			_children: [ (!current ? {
					tag:'span',
					_text:entry.name,
					_css: {
						width: '100%',
						x: 10,
						height:50,
						fontSize:30,
						verticalAlign:'middle'
					}
				} : {
					tag:'input',
					_text:entry.name,
					_css: {
						width: '100%',
						x: 10,
						height:50,
						fontSize:30,
						verticalAlign:'middle',
						backgroundImage: 'icon-edit.png',
						padding: [0,0,0,60]
					}
				}),{
					tag:'span',
					_text:entry.score +'',
					_css: {
						width: '100%',
						x: -10,
						height:40,
						fontSize:30,
						textAlign:'right',
						verticalAlign:'middle'
					}
				}]
		});
	}
	
}