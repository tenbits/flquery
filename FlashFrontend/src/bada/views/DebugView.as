import bada.dom.Dom;
import bada.dom.element.INode;

class bada.views.DebugView extends bada.dom.widgets.View {

	private static var messages:Array = [];
	private static var _instance: DebugView;
	private static var $debugMessages:bada.dom.element.Span;
	private var $btnDebugButton: MovieClip;    
	public var active: Boolean = true;


      public static function outputNode(node:INode) {
		Bada.log('node output:');
		for (var key in node) {
			switch(typeof node[key]) {
				case 'number':
				case 'string':
					Bada.log('  ', key, node[key]);
					break;
			}
		}
		Bada.log('   css output:');
		for (var key in node._css) {
			switch(typeof node._css[key]) {
				case 'number':
				case 'string':
					Bada.log('  ', key, node._css[key]);
					break;
			}
		}
	}

	function DebugView(parent: bada.dom.element.Div, data: Object) {
		super(parent, data);
		
		Dom.body.append( {
			_css: {
			width: 32,
			height: 32,
			backgroundColor: 0x00ff00
		},
			handler: {
				touchEnd: function() {
					bada.dom.widgets.View.open('viewDebug');
				}
			}
		});
	   
		this.append([{
			_css: {
				width: 32,
				height: 32,
				bottom: 0,
				right: 0,
				backgroundColor: 0xff0000
			},
			handler: {
				touchEnd: function() {
					bada.dom.widgets.View.open('mainView');
				}
			}
		},
		{
			tag: 'span',
			_name:'debugMessages',
			_text: messages.join('\r'),
			_css: {
				width: Bada.screen.width - 40,
				x: 30,
				y: 10,
				height: Bada.screen.height - 20,
				fontSize: 20,
				color:0xffffff
			}
		}]);
		
		_instance = this;
		
		$debugMessages = this.first('_debugMessages').asSpan();
	}
    
	public static function log(message:String) {	
		if ($debugMessages == null) {
			messages.push(message);
			return;
		}
		var t = message + '\r' + $debugMessages.text();
		$debugMessages.text(t);
	}
	
	static function setup() {
		if (Bada.debug == false) return;
		
		
		if (Bada.debug) {
			Dom.body.append({
				tag:'debugView',
				_id:'viewDebug',
					_css:{
						width:Bada.screen.width,
						height:Bada.screen.height,
						x:Bada.screen.width,
						backgroundColor:0x0f0f0f
					}
				
			});
		}
	}
}