import bada.dom.Dom;
import bada.dom.element.Div;
import bada.dom.element.INode;
import bada.dom.events.Event;

/**
 * ...
 * @author tenbits
 */
class bada.dom.widgets.DropDownMenu extends Div
{
	private var $overlay:Div;
	private var _callback:Function;
	public function DropDownMenu(data:Object) 
	{
		
		this.$overlay = (new Div( {
			width:480,
			height:800,
			backgroundColor:0,
			backgroundOpacity:70,
			backgroundImage: 'ex.background.noise.png',
			backgroundRepeat: 'repeat'			
		})).appendTo(Dom.body).touchEnd(function() {
			this.$overlay.toggle(false);
			return false;
		}.bind(this)).asDiv();
		
		var items:Array = [];
		
		for (var i:Number = 0; i < data.items.length; i++) 
		{
			items.push( {
				_name: data.items[i].action,
				_css: {
					position:'static',
					padding: 20,
					//backgroundColor:0xff0000,
					border: i < data.items.length - 1 ? { bottom: [1, 0xaaaaaa] } : null
				},
				hover : {
					backgroundGradient: {
						colors:[0, 0x333333, 0],
						alphas: [0, 80, 0],
						ratios: [25,150,225],
						radius: Math.PI / 2.3
					}
				},
				_children: {
					tag: 'span',					
					_text: data.items[i].value,
					_css: {
						position:'static'
					}
				}
			});			
		}
		
		this._callback = data.callback;
		
		super.init(this.$overlay, {
			_id:'drp',
			_css: {
				display:'inline-block',
				padding: 10,
				//backgroundColor:0,
				borderImage: ['src.resources.800.ex.background.menu.bitmap.png', 30],
				fontSize: 25,
				color:0xfafafa
			},
			_children: items
		});	
		
		this.$overlay.first().children().eval('touchEnd', this.onItemClicked.bind(this));
		
		if (data.x > Bada.screen.width  - this.width - 15) {
			data.x = Bada.screen.width  - this.width - 15;
		}
		if (data.y > Bada.screen.height - this.height - 15) {
			data.y = Bada.screen.height - this.height - 15;
		}
		
		this.x = data.x;
		this.y = data.y;
	}
	
	function toggle(flag:Boolean):INode 
	{
		if (flag)  this.$overlay.fadeIn(.6);
		else this.$overlay.fadeOut(.6);
		
		return this;
	}
	
	private function onItemClicked(e:Event) {
		this._callback(e.target._name);
		return true;
	}
}