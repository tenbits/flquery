import bada.dom.element.Div;
import bada.dom.helper.Template;

/**
 * ...
 * @author tenbits
 */
class bada.dom.widgets.ListView extends Div
{
	private var _divider:String;	
	public function ListView() 
	{
		this._tagName = 'listview';
		var data = super.init.apply(this, arguments);
		
		this._divider = data.divider;
	}
	
	public function appendItems(template:Template, items:Array) {
		for (var i:Number = 0; i < items.length; i++) 
		{
			this.append(template.run(items[i]));
			if (i < items.length - 1) {
				this.append(this._divider);
			}
		}
	}
	
}