import bada.controls.Info;
import bada.dom.CSS;
import bada.dom.css.Border;
import bada.dom.css.BorderImage;
import bada.dom.css.Gradient;
import bada.dom.element.INode;
import flash.geom.Point;
/**
 * ...
 * @author ...
 */
class bada.dom.css.StyleSheet
{
	/*
	 * could be checked if style is supported. StyleSheet.styles.hasOwnProperty(styleName)
	 */
	static var styles:Object = {
		x: null,
		y: null,
		width: null,
		height: null,
		margin: null,
		marginTop: null,	
		marginRight: null,
		marginBottom: null,
		marginLeft: null,
		padding: null, // [10,10,10,10] || '10,10,10,10'
		paddingTop: null,	
		paddingRight: null,
		paddingBottom: null,
		paddingLeft: null,
		border: null,
		borderRadius: null,
		borderRadiusTopLeft: null,
		borderRadiusTopRight: null,
		borderRadiusBottomLeft: null,
		borderRadiusBottomRight: null,
		borderImage: null,
		backgroundImage: null,
		backgroundPosition: null,
		backgroundRepeat: null,
		backgroundSize: null,
		backgroundColor: null,
		backgroundOpacity: null,
		opacity: null,
		backgroundGradient: null,
		rotation: null,
		rotationPivot: null,
		scale: null,
		display: null,
		position:  null,
		overflow: null,
		color: null,
		fontSize: null,
		fontFamily: null,
		verticalAlign: 1,
		textAlign: null,
		wordWrap:null,
		autoSize:null
	};
	
	private var _node:INode;
	
	private var _x:Number;
	private var _y:Number;
	
	private var _width:Number;
	private var _height:Number;
	
	public var marginTop:Number;	
	public var marginRight:Number;
	public var marginBottom:Number;
	public var marginLeft:Number;
	
	public var paddingTop:Number;	
	public var paddingRight:Number;
	public var paddingBottom:Number;
	public var paddingLeft:Number;
	
	
	
	private var _border:Border;
	
	public var borderRadiusTopLeft:Number;
	public var borderRadiusTopRight:Number;
	public var borderRadiusBottomLeft:Number;
	public var borderRadiusBottomRight:Number;
	
	private var _borderImage:BorderImage;
	
	public var backgroundImage:String;
	public var backgroundPosition:Point;
	public var backgroundRepeat:String;
	public var backgroundSize:String;
	public var backgroundColor:Number;
	public var backgroundOpacity:Number;
	
	public var opacity:Number;
	
	private var _backgroundGradient:Gradient
	
	public var rotation:Number;
	public var rotationPivot:Point;
	public var scale:Number;
	
	public var display:String;
	public var overflow:String;
	private var _position: String;
	
	public var color:Number;
	public var fontSize:Number;	
	public var fontFamily:String;
	public var wordWrap:Boolean;
	public var autoSize:String;	
	public var verticalAlign:String;
	public var textAlign:String; // horizontalAlign;
	
	
	
	public function StyleSheet(node:INode, css:Object) 
	{
		this._node = node;
		
		this.paddingBottom = this.paddingLeft = this.paddingRight = this.paddingTop = 0;
		this.marginBottom = this.marginLeft = this.marginRight = this.marginTop = 0;
		this.display = 'block';
		
		this.borderRadiusBottomLeft = 0;
		this.borderRadiusBottomRight = 0;
		this.borderRadiusTopLeft = 0;
		this.borderRadiusTopRight = 0;
		
		this.backgroundOpacity = 100;
		
		//this.parseCss(css);
		//this.inheritCss(this._node.style, css);		
	}
	
	
	public function parseCss(css:Object) {
		for (var key in css) {
			switch(key) {
				case 'x':
					this.x = css[key];
					break;
				case 'y':
					this.y = css[key];
					break;
				case 'width':
					this.width = css[key];
					break;
				case 'height':
					this.height = css[key];
					break;
				case 'padding':
					this.padding = css[key];
					break;
				case 'margin':
					this.margin = css[key];
					break;
				case 'border':
					this.border = css[key];
					break;
				case 'position':
					this.position = css[key];					
					break;
				case 'backgroundColor':
					this.backgroundColor = css[key];
					break;
				case 'backgroundGradient':
					this.backgroundGradient = css[key];
					break;
			}
		}
	}
	
	public function inheritCss(parents:StyleSheet, currentCss:Object) {
		if (this._width == null && this.display != 'inline-block') {
			if (parents.width != null){
				this.width = parents.width - parents.paddingLeft - parents.paddingRight - this.marginRight - this.marginLeft;				
			}
		}		
		if (currentCss.color == null && parents.color != null) {
			this.color = (currentCss.color = parents.color);
		}
		if (currentCss.fontSize == null && parents.fontSize != null) {
			this.fontSize = (currentCss.fontSize = parents.fontSize);			
		}
		if (currentCss.fontFamily == null && parents.fontFamily != null) {
			this.fontFamily = (currentCss.fontFamily = parents.fontFamily);
		}
	}
	
	private function renderCss(css:Object) {
		
	}
	
	public function get x():Number {
		return this._x || 0;
	}
	public function set x(value):Void {
		if (typeof value === 'string')  {
			if (value.charAt(value.length - 1) == '%') {				
				this._x = (this._node.parent.width - this._node.width) / 2
			}
			else this._x = parseInt(value);
		}
		else this._x = value;		
	}
	public function get y():Number{
		return this._y || 0;
	}
	public function set y(value):Void{
		if (typeof value  === 'string') this._y = parseInt(value);
		else this._y = value;
	}
	public function get width():Number{
		return this._width;
	}
	public function set width(value):Void{
		if (typeof value === 'string') {
			if (String(value).charAt(String(value).length - 1) === '%') {
				var parents:Number = this._node.parent.width,
				percent = parseInt(String(value).substring(0, String(value).length - 1), 10);
				this._width = parents * percent / 100;
				return;
			}
			this._width = parseInt(String(value));
			return;
		}
		this._width = Number(value);
		if (isNaN(this._width)) {
			Bada.log('Error # stylesheet.width is NAN', value, this._node._tagName);
		}
	}
	public function get height():Number{
		return this._height;
	}
	public function set height(value):Void {
		if (typeof value === 'string') {
			
			if (String(value).charAt(String(value).length - 1) === '%') {
				var parents:Number = this._node.parent.height,
				percent = parseInt(String(value).substring(0, String(value).length - 1), 10);
				this._height = parents * percent / 100;
				return;
			}
			this._height = parseInt(String(value));
			return;
		}
		this._height = Number(value);
	}
	
	public function get margin():Array {
		return [this.marginTop, this.marginRight, this.marginBottom, this.marginLeft];
	}
	public function set margin(value):Void {
		if (typeof value === 'number') {
			this.marginRight = this.marginBottom = this.marginLeft = this.marginTop = Number(value);
			return;
		}
		if (typeof value === 'string') {
			value = String(value).split(' ');
		}
		if (value instanceof Array) {
			this.marginTop = value[0] || 0;
			this.marginRight = value[1] || 0;
			this.marginBottom = value[2] || 0;
			this.marginLeft = value[3] || 0;	
			
			Bada.log('this.marginTop', this.marginTop);
			return;
		}		
	}
	
	public function get padding():Array {
		return [this.paddingTop, this.paddingRight, this.paddingBottom, this.paddingLeft];
	}
	public function set padding(value):Void {
		if (typeof value === 'number') {
			this.paddingRight = this.paddingBottom = this.paddingLeft = this.paddingTop = Number(value);
			return;
		}
		if (typeof value === 'string') {
			
			value = String(value).split(' ');
			for (var i:Number = 0; i < value.length; i++) 
			{
				value[i] = parseInt(value[i]);
			}
		}
		if (value instanceof Array) {
			this.paddingTop = value[0] || 0;
			this.paddingRight = value[1] || 0;
			this.paddingBottom = value[2] || 0;
			this.paddingLeft = value[3] || 0;				
			return;
		}		
	}
	public function get border():Border {
		return this._border;
	}
	public function set border(value):Void {
		if (value instanceof Border) {
			this._border = value;
			return;
		}
		this._border = new Border(value);
	}
	public function get position():String {
		return this._position == null ? 'absolute' : this._position;		
	}
	public function set position(value:String):Void {
		this._position = value;
		/*if (this._position == 'static') {
			var xy = CSS.calculateOffset(this._node, this._node.parent);
			this.x = xy.x;
			this.y = xy.y;			
		}*/
	}
	public function get backgroundGradient():Gradient 
	{
		return this._backgroundGradient;
	}
	public function set backgroundGradient(value):Void 
	{
		if (value == null) this._backgroundGradient = null;
		else if (value instanceof Gradient) this._backgroundGradient = Gradient(value);
		else this._backgroundGradient = new Gradient(value);
	}
	public function get borderImage():BorderImage 
	{
		return this._borderImage;
	}
	public function set borderImage(value):Void 
	{
		if (value instanceof BorderImage) this._borderImage = BorderImage(value);
		else {
			_borderImage = new BorderImage(value);
		}
	}
	
	public function set borderRadius(value):Void {
		if (typeof value === 'number') {
			this.borderRadiusBottomLeft = 
			this.borderRadiusBottomRight = 
			this.borderRadiusTopLeft =
			this.borderRadiusTopRight = value;
		}
		else if (value instanceof Array) {
			this.borderRadiusTopLeft = value[0] || 0;
			this.borderRadiusTopRight = value[1] || 0;
			this.borderRadiusBottomLeft = value[2] || 0;
			this.borderRadiusBottomRight = value[3] || 0;
		}else if (typeof value === 'string') {
			this.borderRadius = parseInt(value);
		}
	}
	
}