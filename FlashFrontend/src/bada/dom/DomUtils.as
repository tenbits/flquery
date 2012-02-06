import bada.dom.element.Div;

class bada.dom.DomUtils{
   
	public static function layoutTable(parent:Div, cells:Number) {
		var elements = parent._children,
		length = elements.length,
		rows = Math.ceil(length / cells),
		offsetX = parent.style.paddingLeft,
		offsetY = parent.style.paddingTop,
		cellWidth = (parent.width - parent.style.paddingLeft - parent.style.paddingRight)  / cells,
		cellHeight = (parent.height - parent.style.paddingTop - parent.style.paddingBottom) / rows;
		
		for (var i:Number = 0; i < elements.length; i++) 
		{
			var element = elements[i];
			element.x = offsetX + (cellWidth - element.width) / 2;
			element.y = offsetY + (cellHeight - element.height) / 2;
			
			offsetX += cellWidth;
			if (offsetX >= cellWidth * cells) {
				offsetX = parent.style.paddingLeft;
				offsetY += cellHeight;
			}
		}
		
	}
}