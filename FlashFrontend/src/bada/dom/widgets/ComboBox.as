import bada.dom.element.Div;
import bada.dom.events.Event;
import bada.dom.widgets.DropDownMenu;
import bada.Helper;

/**
 * ...
 * @author tenbits
 */
class bada.dom.widgets.ComboBox extends Div
{
	private var _items: Array;
	private var _menu:DropDownMenu;
	public function ComboBox(parent:Div, data:Object) 
	{
		this._tagName = 'combobox';
		
		data._css = Helper.extend(data._css, {
			/*backgroundGradient: {
				type:'radial',
				colors:[0, 0x000000],
				alphas: [0, 100],
				width:80,
				height:80,
				x: -20,
				y: -20
			},*/
			borderImage: ['src.resources.800.ex.background.combobox.bitmap.png',15],
			width:60,
			height: 40,
			lineHeight:50,
			verticalAlign:'middle',
			textAlign:'center',
			color:0
		});
		
		var current:Object;
		this._items = data._children;
		
		for (var i:Number = 0; i < this._items.length; i++) 
		{
			if (this._items[i].active) {
				current = {
					tag: 'span',
					_text: this._items[i].value
				}
				break;
			}
		}
		
		data._children = current;
		
		super.init(parent, data);
		
		this.touchEnd(function(e) {
			this.showMenu(e);
		}.bind(this));
	}
	
	function showMenu(e:Event) {
		if (this._menu == null) {
			this._menu = new DropDownMenu( {
				items: this._items,
				x: e.pageX,
				y: e.pageY,
				callback: function(action:String) {
					this.find('span').asSpan().text(action);
				}.bind(this)
			});
		}else {
			this._menu.toggle(true);
		}
	}
}