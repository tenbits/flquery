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
		super(parent, data);
		
		Instance = this;
		this.y = this._parent.height - 54;
		
		append([ {
			_name:'menuPanel',
			_css: {
				width:this.width,
				height:this.height,
				backgroundImage: 'buttons.btn_menu_on.png',
				//align:'horizontal',
				display:'none'
			}
		},{
			_name:'btnMenuOpen',
			_css: {
				width:130,
				height:60,
				x: (_parent.width - 130) / 2,
				y: 0,
				backgroundImage: 'buttons.btn_menu_off.png'
			}
		}]);
		
		
		
		var panel = this.first('menuPanel').append(data.items);
		
		
		
		var cell_width = 480 / 2;
		for (var i = 0; i < data.i_tems.length; i++) {
			
			var item = data.i_tems[i];
			panel.append( [{
				_name: item._name,
				_css: {
					width: cell_width,
					height: 100,
					x:cell_width * item.position,
					y:60,
					display: item.visible == false ? 'none' : 'block'
				},
				_children:[ {
					tag:'button',
					_css: Helper.extend(item._css, {
						x: (cell_width - item._css.width) / 2
					})
				},{
					tag:'span',
					_text:item.label,
					_css: {
						y: item._css.height - 5,
						autoSize: 'center',
						width: cell_width,
						height:25,
						color:0x222222,
						fontSize:20,
						italic:true,
						bold:true
						
					}
				}]
			}]);
		}
		
		panel.children().eval('bind', 'touchEnd', Function.bind(this.itemClicked, this));
		
		
		this.first('btnMenuOpen').bind('touchEnd', Function.bind(this.open, this));
		
		this.delegateClose = Function.bind(this.close, this);
		this.onSelect = data.onSelect;
		
		panel.bind('touchEnd', this.delegateClose);
	}
	
	public function open() {
		this.first('btnMenuOpen').toggle(false);
		this.first('menuPanel').toggle(true);
		
		this.animate( {
			y: this._parent.height - this.height,
			transition:'easeoutexpo',
			time:.2
		});
		
		Dom.body.bind('touchEnd', this.delegateClose);
		return false;
	}
	
	public function close() {
		
		Dom.body.unbind(this.delegateClose);
		
		this.first('btnMenuOpen').toggle(true);
		this.animate( {
			y: this._parent.height - 54,
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
		var items = this.first('menuPanel')._children;
		
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
		var items = this.first('menuPanel')._children;
		
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