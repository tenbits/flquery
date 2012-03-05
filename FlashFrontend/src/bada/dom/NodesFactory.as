import bada.dom.element.Img;
import bada.dom.element.INode;
import bada.dom.element.Div;
import bada.dom.element.Span;
import bada.dom.element.Button;

class bada.dom.NodesFactory{
    public static var controls:Object = {};
    public static var _ids = {};
    
    public static function register(node:INode){
        if (node._id) {
			if(_ids[node._id] != null) Bada.log('already exists node._id');
            _ids[node._id] = node;
        }
    }
    
    
    public static function get(selector:String):INode{
        return _ids[selector];
    }
  
    
   /* public static function remove(node:INode){
        if (node._children){
            for(var i = 0; i< node._children; i++){
                remove(node._children[i]);
            }
        }
        if (node._id) delete _ids[node._id];
    }*/
    
    public static function create(parent:Div, data:Object):INode{        
		if (data instanceof INode) {
			data.appendTo(parent);
			return INode(data);
		}        
		if (typeof data.tag === 'undefined') data.tag = 'div';       
		
		if (typeof controls[data.tag] !== 'undefined') {
			return new controls[data.tag](parent,data);            
		}       
		Bada.log('Error # UNKNOWN DOM NODE',data.tag);
		return null;
    }
}