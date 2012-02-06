import bada.dom.LocalStorage;
import bada.dom.widgets.Dialog;
import bada.dom.element.Input;
import bada.dom.widgets.View;
import bada.GameDialogs;
import reactor.Settings;
/**
 * ...
 * @author tenbits
 */
class bada.Highscore
{
	public static var list:Array = [];
	public static var promtCallback:Function;
	
	public static function save() {
		LocalStorage.set('highscore', list);
	}
	public static function restore():Void {
		restore = Bada.doNothing;
		LocalStorage.get('highscore', function(value) {
			if (value instanceof Array) {
				Highscore.list = value;
			}
		});		
	}
	
	public static function promtName(currentName:String, callback:Function):Void {
		Input(Dialog.get('highscorePromt').find('input')).text(currentName);
		Dialog.show('highscorePromt');
		promtCallback = callback;
	}
	
	public static function add(score:Number, name:String):Boolean {
		Bada.log('adding', score, name);
		var o = {
			score: score,
			name: name
		},
		_list: Array = Highscore.list[Settings.Instance.players];
		if (_list == null) {
			_list = (Highscore.list[Settings.Instance.players] = []);			
		}
		
		var added = false;
		for (var i = 0; i < _list.length; i++) {
			if (score > _list[i].score) {
				_list.splice(i, 0, o);
				added = true;
				break;
			}
		}
		if (_list.length > 10){
			_list.splice(10);
		}
		if (!added && _list.length < 10) {
			_list.push(o);
			added = true;
		}
		
		//Highscore.list.sort(function(a,b){return a.score < b.score;})
		
		if (added) {
			//Highscore.promtName(name,function(_name) {
				//o.name = _name;
				Highscore.save();
				Highscore.showHighscore(o);		
			//});
		}
		//else Highscore.showHighscore();
		
		return added;
	}
	
	public static function setup() {
		Highscore.restore();
		Dialog.register('highscorePromt', {
			_css: {
				width:'70%',
				height:300,
				y:60,
				backgroundColor:0x555555,
				opacity:.9,
				borderRadius:[14, 14, 14, 14],
				border:[5,0x000000,70]
			},
			_children:[{
				tag:'span',
				_text:'Highscore!',
				_css: {
					width:'90%',
					y:10,
					color:0x10ff10,
					alpha:10,
					fontSize:45,
					autoSize:'center',
					textShadow:0xa0a0a0
				}
			},{
				tag:'input',
				_id:'inputHighscore',
				_text:'Anonym',
				_css: {
					width:347,
					height:48,
					x:'50%',
					y:100,
					color:0xff0000
				}
			}]
		});
	}
	
	public static function showHighscore(currentEntry:Object) {
		View.open('viewHighscore',null,currentEntry);
	}
	
}