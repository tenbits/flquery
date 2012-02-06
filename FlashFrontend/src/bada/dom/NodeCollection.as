import bada.dom.element.INode;
class bada.dom.NodeCollection{
    public var _collection:Array = null;
    
    public function NodeCollection(){
        
    }
    public function append(node):NodeCollection{
        
        if (_collection == null) _collection = [];
        
        _collection.push(node);
        return this;
    }
    
    public function eval():NodeCollection{
        if (_collection == null) return this;
        var args = Array.prototype.slice.call(arguments),
        method = args.shift();
        
        for(var i = 0; i<_collection.length; i++){
            _collection[i][method].apply(_collection[i],args);
        }
        return this;
    }
	
	/**
	 * @param	func - func(node:INode, index:Number)
	 */
	public function each(func:Function):NodeCollection {
		for(var i = 0; i<_collection.length; i++){
            func(_collection[i], i);
        }
        return this;
	}
    
    public function get count():Number{
        return _collection == null ? 0 : _collection.length;
    }
	
	public function get(i:Number):INode {
		return _collection == null ? null : _collection[i];
	}

}