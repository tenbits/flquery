import bada.dom.element.Div;
import bada.dom.helper.Draggable;
import bada.dom.element.Span;
import flash.geom.Rectangle;

/**
 * ...
 * @author tenbits
 */
class bada.dom.widgets.SlideSelect extends Div
{
	private var _data:Object;
	private var $head:Div;
	private var $line:Div;
	public function SlideSelect(data) 
	{
		super.init.apply(this, arguments);
		this._tagName = 'slideSelect';
		
		this.append( [ {
				_css: {
					backgroundImage: 'view-settings.slider_line.png',
					height: 10,
					width: 250,
					bottom: 17,
					x: '50%'
				},
				_children:[ {		
						_name: 'sliderHead',
						_css: {
							backgroundImage: 'view-settings.slider_head.png',
							height: 42,
							y: - 17
						}
				}]
			}]);	
		
		
		
		var width:Number = 250 +  (250 / 2),
			x: Number = (this.width - width) / 2,
			ceil = width / 3;
		
		for (var i:Number = 0; i < data.gauge.length; i++) 
		{
			this.append((new Span(data.gauge[i], {
				width:ceil,
				//height:30,
				x: x + ceil * i + 6,
				fontSize: 20,
				fontFamily:'src.resources.AGENCYB.TTF',
				//backgroundColor:([0xff0000, 0x00ff00, 0x0000ff])[i],
				textAlign:'center'
			})));
		}
		
		this.find('_sliderHead').bind('moveEnd', Function.bind(this.moveEnd, this));
		
		this._data = data;
	}
	
	private function onresize() {	
		
		var line:MovieClip = this._children[0].movie,
		$head:Div = this.find('_sliderHead').asDiv(),
		head = $head.movie,
		rect:Rectangle = new Rectangle(0, head._y, line._width - head._width, 0);
		
		$head._css.draggable = rect;		
		Draggable.enable($head, Div(this));
		
		if (this._data.selected) {
			var pos = 0;
			for (var i = 1; i < this._data.gauge.length; i++) {
				if (this._data.gauge[i] == this._data.selected) {
					pos = i;
					break;
				}
			}
			if (pos != null) {
				var step:Number = ( line._width + head._width) / this._data.gauge.length;
				head._x = step * pos;
			}
		}
	}
	
	private function moveEnd() {
		if (this._data.gauge == null) return;
		var lineMovie: MovieClip = this._children[0]._movie,
		//-headMovie: MovieClip = this._children[1]._movie;
		$head:Div = this.find('_sliderHead').asDiv(),
		headMovie:MovieClip = $head.movie;
		
		
		//-var currentPos:Number = headMovie._x - lineMovie._x;// + headMovie._width / 2;
		var currentPos:Number = headMovie._x;
		var width:Number = lineMovie._width + headMovie._width;
		
		var step:Number  = width / this._data.gauge.length;
		
		var floor:Number = Math.floor(currentPos / step) * step;
		var ceil:Number = floor + step;
		
		var dfloor = Math.abs(currentPos - floor);
		var dceil = Math.abs(currentPos - ceil);
		
		
		var pos = (dfloor < dceil ? floor : ceil);
		$head.animate( {
			_x: pos,
			time:.2
		});
		
		this.trigger('onchange', Math.round(pos / step));
	}
	
}