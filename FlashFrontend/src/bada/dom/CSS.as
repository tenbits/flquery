import bada.dom.css.BackgroundHelper;
import bada.dom.element.Div;
import bada.dom.element.INode;
import bada.dom.NodeCollection;
import bada.dom.element.Span;
import bada.dom.StyleSheets;
import bada.Graphics;
import bada.Helper;
import bada.Utils;
import caurina.Rotator;
import flash.display.BitmapData;
class bada.dom.CSS {

	
	//public static function prepairCss(div:INode, css:Object) {
		//
		//
		//if (div._css == null) div._css = { };
		//
		//if (typeof css.width === 'string' && css.width.charAt(css.width.length - 1) == '%') {
			//var percent = parseInt(css.width.substring(0, css.width.length - 1), 10);
			//var parents = div.parent.width;
			//if (typeof parents !== 'number') continue;
			//css.width = parents * percent / 100;
		//}
		//if (typeof css.height === 'string' && css.height.charAt(css.height.length - 1) == '%') {
			//var percent = parseInt(css.height.substring(0, css.height.length - 1), 10);
			//var parents = div.parent.height;
			//if (typeof parents !== 'number') continue;
			//css.height = parents * percent / 100;
		//}
		//
		//for (var key in css) {
			///** convert percents to values */
			//if (typeof css[key] === 'string' && css[key].charAt(css[key].length - 1) == '%') {
				//var percent = parseInt(css[key].substring(0, css[key].length - 1), 10);
				//var parents = div.parent.css(key);
				//
				//var parents = div.parent[key];
				//if (typeof parents !== 'number') continue;
				//
				//
				//css[key] = parents * percent / 100;
				//
				//if (key == 'width') {
					//if (div.css('position') == 'static') {
						//css.width = css.width - div._parent.style.paddingLeft - div._parent.style.paddingRight;
					//}
					///*if (css.x == null && div._css.x == null) {
						//div._css.x = (css.x = (parents - css[key]) / 2);
					//}*/
				//}
				//if (key == 'height') {
					//if (div.css('position') == 'static') {
						//css.height = css.height - div._parent.style.paddingBottom - div._parent.style.paddingTop;
					//}
					///*if (css.x == null && div._css.x == null) {
						//div._css.x = (css.x = (parents - css[key]) / 2);
					//}*/
				//}
				//
				//if (key == 'x') {
					//div._css.x = (css.x = (div.parent.width - div.width) / 2);
				//}
			//}
			//
			//div._css[key] = css[key];
		//}
		//
		///*if (css.border) {
			//if (css.border instanceof Array) {
				// [width, color, opacity]
				//div.borderBottomWidth = div.borderTopWidth = div.borderLeftWidth = div.borderRightWidth = css.border[0];
				//div.borderBottomColor = div.borderTopColor = div.borderLeftColor = div.borderRightColor = css.border[1] || 0x000000;
				//div.borderBottomOpacity = div.borderTopOpacity = div.borderLeftOpacity = div.borderRightOpacity = css.border[2] || 100;
			//}
			//if (css.border instanceof Object) {
				//if (css.border.top instanceof Array) {
					//div.borderTopWidth = css.border.top[0];
					//div.borderTopColor = css.border.top[1] || 0x000000;
					//div.borderTopOpacity = css.border.top[2] || 100;
				//}
				//if (css.border.left instanceof Array) {
					//div.borderLeftWidth = css.border.left[0];
					//div.borderLeftColor = css.border.left[1] || 0x000000;
					//div.borderLeftOpacity = css.border.left[2] || 100;
				//}
				//if (css.border.bottom instanceof Array) {
					//div.borderBottomWidth = css.border.bottom[0];
					//div.borderBottomColor = css.border.bottom[1] || 0x000000;
					//div.borderBottomOpacity = css.border.bottom[2] || 100;
				//}
				//if (css.border.right instanceof Array) {
					//div.borderRightWidth = css.border.right[0];
					//div.borderRightColor = css.border.right[1] || 0x000000;
					//div.borderRightOpacity = css.border.right[2] || 100;
				//}
			//}
		//}*/
		///*if (typeof css.borderRadius === 'number') {
			//div.borderRadiusBottomLeft = css.borderRadius;
			//div.borderRadiusBottomRight = css.borderRadius;
			//div.borderRadiusTopLeft = css.borderRadius;
			//div.borderRadiusTopRight = css.borderRadius;
		//}
		//else if (typeof css.borderRadius instanceof Array) {
			//div.borderRadiusTopLeft = css.borderRadius[0] || 0;
			//div.borderRadiusTopRight = css.borderRadius[1] || 0;
			//div.borderRadiusBottomLeft = css.borderRadius[2] || 0;
			//div.borderRadiusBottomRight = css.borderRadius[3] || 0;
		//}*/
		//
		//
		///*if (css.padding != null) {
			//if (typeof css.padding === 'number') {
				//div.paddingRight = div.paddingBottom = div.paddingLeft = div.paddingTop = css.padding;
			//}else if (css.padding instanceof Array) {
				//div.paddingTop = css.padding[0] || 0;
				//div.paddingRight = css.padding[1] || 0;
				//div.paddingBottom = css.padding[2] || 0;
				//div.paddingLeft = css.padding[3] || 0;
				//
			//}
		//}
		//if (css.margin != null) {
			//if (typeof css.margin === 'number') {
				//div.marginRight = div.marginBottom = div.marginLeft = div.marginTop = css.margin;
			//}else if (css.margin instanceof Array) {
				//div.marginTop = css.margin[0] || 0;
				//div.marginRight = css.margin[1] || 0;
				//div.marginBottom = css.margin[2] || 0;
				//div.marginLeft = css.margin[3] || 0;				
			//}
		//}*/
		//
		//if (css.position == 'static' && (css.x == null || css.y == null)) {
			//var xy = CSS.calculateOffset(div, div._parent);
			//if (css.x == null) css.x = xy.x;
			//if (css.y == null) css.y = xy.y;
			//if (css.width == null) {
				//css.width = CSS.calculateWidth(div, div._parent);
			//}
		//}
		//
	//}
	//
	//public static function calculateOffset(node:INode, parent:INode):Object {
		//
		//
		//var last:INode;
		//if (node._css.ready == null){
			//for (var i:Number = parent._children.length - 1; i > -1; i--) 
			//{
				//if (parent._children[i]._css.position == 'static') {
					//last = parent._children[i];
					//break;
				//}
			//}
		//}else {
			//var found:Boolean;			
			//for (var i:Number = parent._children.length - 1; i > -1; i--) 
			//{
				//if (found != true) {
					//if (parent._children[i] == node) found = true;
					//continue;
				//}
				//if (parent._children[i]._css.position == 'static') {
					//last = parent._children[i];
					//break;
				//}
			//}
		//}
		//if (last == null) {
			//return {
				//x: parent.style.paddingLeft + node.style.marginLeft,
				//y: parent.style.paddingTop + node.style.marginTop
			//}
		//}
		//
		//
		//if (node.css('display') == 'inline-block') {
			//if (parent.width - last.x - last.width - last.style.marginRight - node.style.marginLeft - node.width  - parent.style.paddingLeft - parent.style.paddingRight > -1) {
				//return {
					//x: last.x,
					//y: last.y + last.width + last.style.marginRight - node.style.marginLeft
				//}
			//}
		//}		
		//
		//return {
			//x: parent.style.paddingLeft + node.style.marginLeft,
			//y: last.y + last.height + last.style.marginBottom + node.style.marginTop
		//}
	//}
	//
	//private static function calculateWidth(node:INode, parent:INode):Number {
		//return parent.width - parent.style.paddingLeft - parent.style.paddingRight;
	//}
	
    /*public static function backgroundImage(node: INode, refreshScale:Boolean) : MovieClip {		
		
		var movie = node.movie;
		if (refreshScale) {
			movie._xscale = 100;
			movie._yscale = 100;
		}
		
		var img:MovieClip = Utils.attachMovie(movie, node._css.backgroundImage, 'backgroundImage' , 1);
		
		if (img == null) {
			return movie;
		}
		if (node._css.backgroundPosition instanceof Array) {            
			img._x = node._css.backgroundPosition[0] || 0;
			img._y = node._css.backgroundPosition[1] || 0;
		}
		
		if (node._css.backgroundRepeat === 'repeat') {
			Graphics.repeatCanvas(movie, img, node.width, node.height);
		}
		
		if (typeof node._css.backgroundSize === 'string') {
			switch(node._css.backgroundSize) {
				case 'stretch':
					img._width = node.width;
					img._height = node.height;
					break;
			}
		}
		if (node._css.width == null) node._css.width = img._width;
		if (node._css.height == null) node._css.height = img._height;
		return movie;
    }*/

	/*public static function fill(movie: MovieClip, color: Number, opacity: Number, width: Number, height: Number) : MovieClip {
        if (typeof opacity == 'undefined') opacity = 100;
        else opacity *= 100;

        movie.clear();
        movie.beginFill(color, opacity);
        movie.moveTo(0, 0);
        movie.lineTo(0, 0);
        movie.lineTo(width, 0);
        movie.lineTo(width, height);
        movie.lineTo(0, height);
        movie.lineTo(0, 0);
        movie.endFill();

        return movie;
    }
    
    public static function fillEx(mc:MovieClip, 
									width:Number, 
									height:Number, 
									radius:Array, 
									color:Number, 
									opacity:Number,
									borderWidth:Number, 
									borderColor:Number, 
									borderOpacity:Number) {
        with (mc) {
          beginFill(color, opacity * 100);
          lineStyle(borderWidth, borderColor, borderOpacity);
          
          moveTo(radius[0], 0);
          
          lineTo(width - radius[1], 0);
          curveTo(width, 0, width, radius[1]);
          lineTo(width, radius[1]);
          
          lineTo(width, height - radius[2]);
          curveTo(width, height, width - radius[2], height);
          lineTo(width - radius[2], height);
          
          lineTo(radius[3], height);
          curveTo(0, height, 0, height - radius[3]);
          lineTo(0, height - radius[3]);
          
          lineTo(0, radius[0]);
          curveTo(0, 0, radius[0], 0);
          lineTo(radius[0], 0);
          
          endFill();
        }
    }*/
	
	/*public static function fillExBorders(mc:MovieClip, 
									width:Number, 
									height:Number, 
									radius:Array, 
									color:Number, 
									opacity:Number,
									border:Object) {
										
        
		var defaultBorder = { width: 0, color:0xffffff, opacity: 100 };
		
		if (typeof border !== 'object')  border = new Object;
		border.top = Helper.extendDefaults(border.top, defaultBorder);
		border.left = Helper.extendDefaults(border.left, defaultBorder);
		border.bottom = Helper.extendDefaults(border.bottom, defaultBorder);
		border.right = Helper.extendDefaults(border.right, defaultBorder);
		
		with (mc) {
          beginFill(color, opacity * 100);
		  
          lineStyle(border.top.width, border.top.color, border.top.opacity);
          
          moveTo(radius[0], 0);
          
          lineTo(width - radius[1], 0);
          curveTo(width, 0, width, radius[1]);
          lineTo(width, radius[1]);
          
		  lineStyle(border.right.width, border.right.color, border.right.opacity);
          lineTo(width, height - radius[2]);
          curveTo(width, height, width - radius[2], height);
          lineTo(width - radius[2], height);
          
		  lineStyle(border.bottom.width, border.bottom.color, border.bottom.opacity);
          lineTo(radius[3], height);
          curveTo(0, height, 0, height - radius[3]);
          lineTo(0, height - radius[3]);
          
		  lineStyle(border.left.width, border.left.color, border.left.opacity);
          lineTo(0, radius[0]);
          curveTo(0, 0, radius[0], 0);
          lineTo(radius[0], 0);
          
          endFill();
        }
    }*/
    
    /*public static function gradient(movie: MovieClip, info: Object,width:Number, height:Number) : MovieClip {
        
        movie.clear();
        movie.beginGradientFill('linear', info.colors, info.alphas || [100, 100], info.ratios || [0, 255], {
            matrixType: "box",
            x: 0,
            y: 0,
            w: width,
            h: height,
            r:info.radius || 0
        });
        movie.moveTo(0, 0);
        movie.lineTo(0, 0);
        movie.lineTo(width, 0);
        movie.lineTo(width, height);
        movie.lineTo(0, height);
        movie.lineTo(0, 0);
        movie.endFill();

        return movie;
    }*/
   
    
	/*public static function scale(movie:MovieClip, value:Number, width:Number, height:Number):Void{        
		movie._xscale = value;
		movie._yscale = value;
		movie._x += width/2 - width * value / 200;
		movie._y += height/2 - height * value / 200;
	}*/

	/*public static function align(parent:Div, collection:NodeCollection ,type:String) {
		switch(type) {
			case 'vertical-align':
				{
					var length = collection.count,
					height = parent.height - parent.style.paddingBottom - parent.style.paddingBottom,
					rowHeight = height / length;
					
					Bada.log('align', length, height, rowHeight,'btnHeight',collection.get(0).height);
					for (var i:Number = 0; i < length; i++) 
					{
						collection.get(i).y = rowHeight * i + (rowHeight - collection.get(i).height) / 2;
					}
				}
				break;
			case 'horizontal-align': {
				var width = parent.width,
				cellWidth = width / parent._children.length;
				
				for (var j:Number = 0; j < parent._children.length; j++) 
				{
					parent._children[j].x = cellWidth * j + (cellWidth - parent._children[j].width) / 2;
				}
			}
			break;
		}
	}*/
	
	
	
	
	/*private static function parseClass(node:INode):Object {
		var classes:Array = null, css:Object = null;
		
		if (typeof node._class === 'string') {
			classes = node._class.split(' ');
		}
		
		if (typeof node._name === 'string') {
			if (classes == null) classes = [];
			classes.unshift(node._name);
		}
		if (typeof node._id === 'string') {
			if (classes == null) classes = [];
			classes.unshift(node._id);
		}
		
		
		if (classes != null){
			for (var i:Number = 0; i < classes.length; i++) 
			{
				css = Helper.extendDefaults(css, StyleSheets.Classes[classes[i]]);
			}
		}
		
		if (StyleSheets.Classes[node._tagName] != null) {
			css = Helper.extendDefaults(css, StyleSheets.Classes[node._tagName]);
		}
		
		return css;
	}*/
	
	
	/*static function calculateCss(div:INode):Void {
		// join class css and in-object css properties
		div._css = Helper.extend(CSS.parseClass(div), div._css);
		
		CSS.prepairCss(div, div._css);
	}*/
	
	/** 
	 * if css is undefined: all css properties of a div are applied
	 * if css is object: only properties from that object are applied
	 */
	/*public static function renderCss(div:INode, css:Object):Void {
		
		if (css.backgroundImage != null) {
			// apply backgroundImage first, for correct width/height calculation 
			CSS.backgroundImage(div, false);
			delete css.backgroundImage;
		}
		
		var width:Number = div.width,
		height:Number = div.height,
		movie:Object = div.movie || div.textField;
	
		
		
		for (var prop in css) {
			if (prop == 'width' || prop == 'height') continue;
			
			if (typeof movie['_' + prop] !== 'undefined') {
				movie['_' + prop] = css[prop];
				continue;
			}

			switch (prop) {
			case 'bottom':
				movie._y = div._parent.height - css[prop] - height;
				continue;
			case 'right':
				movie._x = div._parent.width - css[prop] - width;
				continue;
			case 'top':
				movie._y = css[prop];
				continue;
			case 'left':
				movie._x = css[prop];
				continue;
			case 'scale':
				//div.scale = css[prop];
				continue;
			case 'opacity':
			case 'onload':
			case 'display':
				if (css[prop] == 'none') div.toggle(false);
				continue;
			case 'transform':
				transform(movie,css[prop]);
				continue;
			}
			
			div.applyCss(prop, css[prop]);
		}
		
		
		
		if (css.scale) {
			div.scale = div._css.scale;
		}
		if (css.backgroundColor != null || css.backgroundGradient != null || css.border != null) {
			BackgroundHelper.render2(div.asDiv());
		}		
	}*/
	
}