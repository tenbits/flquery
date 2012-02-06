import bada.dom.element.Div;
import bada.dom.element.INode;
/**
 * ...
 * @author tenbits
 */
dynamic class bada.dom.events.Event
{
	public var target:INode;
	public var currentTarget:INode;
	public var pageX:Number;
	public var pageY:Number;
	
	public var preventDefault:Boolean;
	public var stopBubbling:Boolean;
	
	public function Event(target:INode, x:Number, y:Number) 
	{
		this.target = target;
		this.pageX = x;
		this.pageY = y;
	}
	
}