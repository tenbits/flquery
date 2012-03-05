import bada.dom.element.Div;
import bada.dom.Dom;
import bada.dom.widgets.View;
import bada.Helper;

/**
 * ...
 * @author tenbits
 */
class bada.dom.widgets.BadaMenu extends Div
{
	private var delegateClose:Function = null;
	private var onSelect:Function;
	
	public static var Instance:BadaMenu;
	
	
	
	public function BadaMenu(parent:Div, data:Object) 
	{
		if (data == null) data = { };
		data._css = {
			height: 160
		};
		
		super.init(parent, data);	
		Instance = this;
		this.y = Bada.screen.height - 46;
		
		this._tagName = 'badaMenu';
		this.append([ {
			_name:'menuPanel',
			_css: {
				width:this.width,
				height:this.height,
				backgroundImage: 'ex.menu_on.png',
				display:'none'
			}
		},{
			_name:'btnMenuOpen',
			_css: {
				width:130,
				height:60,
				x: (Bada.screen.width - 130) / 2,
				y: -10,
				backgroundImage: 'ex.menu_off.png'
			}
		}]);
		
		
		
		var panel:Div = this.first('_menuPanel').asDiv();
		
		var cell_width = 480 / 3;
		for (var i = 0; i < data.items.length; i++) {
			
			var item = data.items[i];
			panel.append( [{
				_name: item._name,
				_css: {
					width: cell_width,
					height: 100,
					x:cell_width * item.position,
					y:68,
					display: item.visible == false ? 'none' : 'block'
				},
				_children:[ {
					_css: Helper.extend(item._css, {
						x: (cell_width - (item._css.width || 64)) / 2
					}),
					hover: {
						scale:95,
						alpha:80
					}	
				},{
					tag:'span',
					_text:item.label,
					_css: {
						y: 64,
						textAlign: 'center',
						width: cell_width,
						height:25,
						color:0x222222,
						fontSize:20
						
					}
				}]
			}]);
		}
		
		panel.children().eval('bind', 'touchEnd', Function.bind(this.itemClicked, this));
		
		
		this.first('_btnMenuOpen').bind('touchEnd', Function.bind(this.open, this));
		
		this.delegateClose = Function.bind(this.close, this);
		this.onSelect = data.onSelect;
		
		panel.bind('touchEnd', this.delegateClose);
	}
	
	public function open() {
		this.first('_btnMenuOpen').toggle(false);
		this.first('_menuPanel').toggle(true);
		
		this.animate( {
			y: Bada.screen.height - this.height,
			transition:'easeoutexpo',
			time:.2
		});
		
		Dom.body.bind('touchEnd', this.delegateClose);
		return false;
	}
	
	public function close() {
		
		Dom.body.unbind(this.delegateClose);
		
		this.first('_btnMenuOpen').toggle(true);
		this.animate( {
			y: Bada.screen.height - 46,
			transition:'easeoutexpo',
			time:.2,
			onComplete: Function.bind(function() {
				this.first('menuPanel').toggle(false);
			},this)
		});
		return false;
	}
	
	private function itemClicked($div:Div) {
		if ($div.movie._alpha < 90) return;
		
		switch($div._name) {
			case 'info':
				this.hide();
				View.open('viewInfo', 'next');
				
				break;
			default:
				if (this.onSelect) this.onSelect($div._name);
				break;
		}
	}
	
	public function hide() {
		//this.toggle(false);
		this._movie._visible = false
	}
	public function show() {
		//this.toggle(true);
		this._movie._visible = true;
	}
	
	public function active(names:Object, status:Boolean):Void {
		var items = this.first('_menuPanel')._children;
		
		for (var i = 0; i < items.length; i++) {
			if (names instanceof Array){
				for (var j = 0; j < names.length; j++) {
					if (items[i]._name == names[j]) {
						items[i].css('alpha', status ? 100 : 40);
						continue;
					}
				}
			}
			if (typeof names == 'string') {
				if (items[i]._name == names) {
					items[i].css('alpha', status ? 100 : 30);
				}
			}
		}
	}
	
	public function visible(names:Object, status:Boolean):Void {
		var items = this.first('_menuPanel')._children;
		
		for (var i = 0; i < items.length; i++) {
			if (names instanceof Array){
				for (var j = 0; j < names.length; j++) {
					if (items[i]._name == names[j]) {
						items[i].toggle(status);
						continue;
					}
				}
			}
			if (typeof names == 'string') {
				if (items[i]._name == names) {
					items[i].toggle(status);
				}
			}
		}
	}
	
	
}