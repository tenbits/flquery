import bada.dom.element.Div;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import mx.data.encoders.Num;
/**
 * ...
 * @author tenbits
 */
class bada.dom.widgets.PaintPanel extends Div
{
	private var painter:Div;
	private var brush: Number = 0xff0000;
	private var background:BitmapData;
	private var current:BitmapData;
	
	private var lastX:Number;
	private var lastY:Number;
	
	private var cache:Array = [];
	private var cachePosition:Number = 0;
	
	public function PaintPanel(parent:Div,data:Object) 
	{
		super(parent, data);
		
		this._movie.lineStyle(Bada.smallscreen ? 7 : 10, this.brush, 70, true, 'none', 'round', 'miter', 0);
		
	
		
		
		this._movie.moveTo(0, 0);
		this._movie.lineTo(this.width, this.height);
		
		this._parent.append( {
			_name:'painter',
			_css: {
				y:this.y,
				x:this.x,
				width:this.width,
				height:this.height,
				backgroundColor:0xffffff,
				backgroundOpacity:0
			}
		});
		
		this._parent.first('painter')
			.bind('touchStart', Function.bind(this.paintStart, this))
			.bind('move', Function.bind(this.paint, this))
			.bind('touchEnd', Function.bind(this.end, this));
	}
	
	public function toggleDrawing(status:Boolean) {
		if (status){
			this._movie.onEnterFrame = Function.bind(function() {
					for (var i = this.cachePosition; i < this.cache.length; i++) {
						this._movie.lineTo(this.cache[i][0], this.cache[i][1]);
						this.cachePosition++;
					}
					
			}, this);
		}else {
			delete this._movie.onEnterFrame;
			this._movie.onEnterFrame = null;
			
			for (var i = this.cachePosition; i < this.cache.length; i++) {
				this._movie.lineTo(this.cache[i][0], this.cache[i][1]);				
				this.cachePosition++;
			}
			
			this.cachePosition = 0;
			this.cache.splice(0);
		}
	}
	
	public function setBrush(brush:Object):Boolean {
		if (typeof brush === 'number') {
			if (this.brush == brush) return false;
			
			this.brush = Number(brush);
		}
		if (typeof brush === 'string') {
			var number = PaintPanel.mapColorName(String(brush));
			
			if (this.brush == number) return false;
			this.brush = number;
		}
		if (this.brush == -1) {
			if (Bada.smallscreen) {
				this._movie.clear();
			}else{
				if (this.current != null) this.current.dispose();
				this.current = new BitmapData(this.width, this.height, true, 0);
				this.current.draw(this._movie);				
				this._movie.clear();
				this._movie.attachBitmap(this.current, 111, 'auto', true);
			}
		}
		
		this._movie.lineStyle(Bada.smallscreen ? 7 : 10, this.brush, 70, true, 'none', 'round', 'miter', 0);
		return true;
	}
	
	private function end() {
		lastX = null;
		lastY = null;
		this._movie.endFill();
		
		if (Bada.smallscreen || 1) this.toggleDrawing(false);
	}
	
	private function paintStart() {
		this.lastX = this._movie._xmouse;
		this.lastY = this._movie._ymouse;
			
		this._movie.moveTo(this.lastX, this.lastY);
		this._movie.lineTo(this.lastX - 1, this.lastY - 1);
		
		if (Bada.smallscreen || 1) this.toggleDrawing(true);
	}
	
	private function paint() {
		if (lastX == null) {
			lastX = this._movie._xmouse;
			lastY = this._movie._ymouse;
			
			//this._movie.beginFill(brush, 90);
			this._movie.moveTo(lastX, lastY);
			return;
		}
		
		if (this._movie._xmouse == lastX && this._movie._ymouse == lastY) return;
		
		if (this.brush > -1)  {
			if (this._movie._xmouse > -1 && this._movie._ymouse > -1) {
				if (this._movie._xmouse <= this.width && this._movie._ymouse <= this.height)
				
				if (Bada.smallscreen || 1) this.cache.push([this._movie._xmouse, this._movie._ymouse]);
				else this._movie.lineTo(this._movie._xmouse, this._movie._ymouse);
				
			}
			
		}
		else if (Bada.smallscreen == false) this.rubber();
		
		lastX = this._movie._xmouse;
		lastY = this._movie._ymouse;
	}
	
	private function rubber() {
		if (this.current == null) return;
		var x = lastX - 8, y = lastY - 8, width = 32, height = 32
		
		//this.current.dispose();
		//this.current = new BitmapData(this.width, this.height, true, 0);
		//this.current.draw(this._movie);
		this.current.copyPixels(this.background, new Rectangle(x, y, width, height), new Point(x,y));
		this._movie.clear();
		this._movie.attachBitmap(this.current, 111, 'auto', true);
		
	}
	
	
	
	private static function mapColorName(name:String):Number {
		switch(name) {
			case 'red': return 0xff0000;
			case 'orange': return 0xFF6600;
			case 'yellow': return 0xF5D500;
			case 'green': return 0x00D400;
			case 'blue': return 0x2841D5;
			case 'lila': return 0x800080;
			case 'black': return 0x000000;
			case 'rubber': return -1;
		}
		return 0;
	}
	
	public function clear_() {
		if (this.background == null) {
			this.background = new BitmapData(this.width, this.height, true, 0);
		}
		
		if (this.current != null) {
			this.current.dispose();
			this.current = null;
		}
		
		this._movie.clear();
		this._movie.getInstanceAtDepth(111).unloadMovie();
		
		setTimeout( Function.bind(function(){
			this.background.draw(this._movie);
			this.current.draw(this._movie);
		}, this),400);
		this._movie.lineStyle(Bada.smallscreen ? 7 : 10, this.brush, 70, true, 'none', 'round', 'miter', 0);
	}
	
	public function refresh() {
		
		//this.background.dispose();
		this.current.dispose();
		this.current = null;
		
		this._movie.clear();
		this._movie.getInstanceAtDepth(111).unloadMovie();
		this._movie.lineStyle(Bada.smallscreen ? 7 : 10, this.brush, 70, true, 'none', 'round', 'miter', 0);
		//this.background.draw(this._movie);
		//this.current.draw(this._movie);
		//this._movie.attachBitmap(this.current, 111, 'auto', true);
	}
}