import bada.dom.NodesFabric;
/**
 * ...
 * @author tenbits
 */
class bada.dom.NodesFabricItem
{
	
	public function NodesFabricItem(tag:String, o:Object) 
	{
		Bada.log('reg. ', tag);
		NodesFabric.controls[tag] = o;
	}
	
}