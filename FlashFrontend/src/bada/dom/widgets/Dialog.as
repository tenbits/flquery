import bada.dom.element.Div;
import bada.dom.Dom;
import bada.dom.element.INode;
/**
 * ...
 * @author tenbits
 */
class bada.dom.widgets.Dialog
{
	private static var $overlay:Div;
	private static var _dialogs:Object;
	
	
	public static function register(id:String, data:Object):Div {
		if ($overlay == null) {
			$overlay = new Div(Dom.body, {
				_id:'dialogOverlay',
				_css: {
					width:Bada.screen.width,
					height:Bada.screen.height,
					display:'none',
					backgroundGradient:{
						  colors:[0x373737, 0x000000],
						  alphas:[60, 90],
						  radius: 45/180*Math.PI,
						  ratios:[0,180]
						}
				},
				handler: {
					touchEnd: function() {
						return false;
					}
				}
			});
			_dialogs = {};
		}
		data._id = id;
		data._css.display = 'none';
		
		$overlay.append(data);
		
		return (_dialogs[id] = $overlay.find('#' + id));
	}
	
	public static function show(id:String) {
		
		$overlay.ztop().css('alpha', 30).toggle(true).animate( {
			alpha:100,
			time:.1,
			onComplete:function() {
				Dialog._dialogs[id].toggle(true);				
			}
		});
		
	}
	
	public static function close() {
		for (var key in _dialogs) {
			if (_dialogs[key].visible() == false) continue;
			_dialogs[key].toggle(false);			
		}
		$overlay.toggle(false);
	}
	
	public static function get(id:String):Div {
		return _dialogs[id];
	}
}