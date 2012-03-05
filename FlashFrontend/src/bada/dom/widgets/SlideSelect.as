import bada.dom.element.Div;
import bada.dom.element.INode;
import bada.dom.helper.Draggable;
import bada.dom.element.Span;
import caurina.transitions.Tweener;
import flash.geom.Rectangle;

/**
 * ...
 * @author tenbits
 */
class bada.dom.widgets.SlideSelect extends Div
{
	private var _items:Array;
	private var $head:Div;
	private var $line:Div;
	public function SlideSelect(parent:Div, data:Object) 
	{
		this._tagName = 'slideSelect';
		
		this._items = data._children;
		
		delete data._children;
		
		super.init(parent, data);
		
		
		this.append( {
			_name: 'line',
			_css: {
				backgroundImage: 'ex.slider_line.png',
				backgroundSize:'stretch',
				height: 10,
				width: this.width - 40,
				x: 20,
				bottom: 17
			},
			_children: [{		
					_name: 'sliderHead',
					_css: {
						backgroundImage: 'ex.slider_head.png',
						height: 42,
						y: - 17
					}
			}]
		});
		
		
		
		this.onresize();
		
		
		
		var width:Number = 250 +  (250 / 2),
			x: Number = (this.width - width) / 2,
			ceil = width / 3;
		
		for (var i:Number = 0; i < this._items.length; i++) 
		{
			this.append(new Span(this._items[i].value, {
				width:ceil,
				//height:30,
				x: x + ceil * i + 6,
				fontSize: 20,
				textAlign:'center'
			}));
		}
		
		this.find('_sliderHead').bind('draggEnd', Function.bind(this.moveEnd, this));		
	}
	
	private function onresize() {	
		var $head:Div = this.find('_sliderHead').asDiv();
		if ($head == null) return;
		
		var line:INode = this.find('_line'),
		head = $head.movie,
		rect:Rectangle = new Rectangle(0, head._y, line.width - head._width, 0);
		
		$head._css.draggable = rect;		
		
		
		Draggable.enable($head, Div(this));
		
		if (this.data('selected')) {
			var pos = 0;
			for (var i = 1; i < this._items.length; i++) {
				if (this._items[i] == this.data('selected')) {
					pos = i;
					break;
				}
			}
			if (pos != null) {
				var step:Number = ( line.width + head._width) / this._items.length;
				head._x = step * pos;
			}
		}
	}
	
	private function moveEnd() {
		if (this._items == null) return;
		var lineMovie: MovieClip = this._children[0]._movie,
		//-headMovie: MovieClip = this._children[1]._movie;
		$head:Div = this.find('_sliderHead').asDiv(),
		headMovie:MovieClip = $head.movie;
		
		
		//-var currentPos:Number = headMovie._x - lineMovie._x;// + headMovie._width / 2;
		var currentPos:Number = headMovie._x;
		var width:Number = lineMovie._width + headMovie._width;
		
		var step:Number  = width / this._items.length;
		
		var floor:Number = Math.floor(currentPos / step) * step;
		var ceil:Number = floor + step;
		
		var dfloor = Math.abs(currentPos - floor);
		var dceil = Math.abs(currentPos - ceil);
		
		
		var pos = (dfloor < dceil ? floor : ceil);
		Tweener.addTween($head.movie,{
			_x: pos,
			time:.2
		});
		
		this.trigger('onchange', Math.round(pos / step));
	}
	
}