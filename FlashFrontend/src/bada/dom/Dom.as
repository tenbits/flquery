import bada.dom.element.Div;
import bada.dom.events.EventManager;
import bada.dom.helper.XmlParser;
import bada.dom.NodesFabric;
import bada.dom.element.INode;
import bada.dom.widgets.*;
import bada.dom.element.*;
import bada.views.DebugView;

class bada.dom.Dom {
    
	public static var focused:Object;
	private static var _xmouse:Number;
	public static function get xmouse():Number {		
		return _xmouse == null ? body.movie._xmouse : _xmouse;
	}
	private static var _ymouse:Number;
	public static function get ymouse():Number {
		return _ymouse == null ? body.movie._ymouse : _ymouse;
	}

	public static var body:Div;

	public static function setup(){
		Launcher.setup();        
		NodesFabric.controls['div'] = Div;
		NodesFabric.controls['span'] = Span;
		NodesFabric.controls['button'] = bada.dom.element.Button;
		NodesFabric.controls['img'] = Img;
		NodesFabric.controls['input'] = Input;
		NodesFabric.controls['checkbox'] = CheckBox;
		
		NodesFabric.controls['view'] = View;
		NodesFabric.controls['badaMenu'] = BadaMenu;
		NodesFabric.controls['debugView'] = DebugView;		
		caurina.transitions.properties.ColorShortcuts.init();
		body = new Div(_root, 'body', {
				width:Bada.screen.width,
				height:Bada.screen.height
		});
		
		EventManager.setup();
	}

	private function Dom(){
		
	}

	public static function get(selector:String):INode{
		return NodesFabric.get(selector);
	}


	public static function parse(html:String):Object {
		return XmlParser.parseHtml(html);
	}
}