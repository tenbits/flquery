/**
 * ...
 * @author tenbits
 */
class bada.generics.Collection
{
	private var _collection:Array;
	public function Collection() 
	{
		this._collection = [];
	}
	
	public function push(item:Object):Collection {
		this._collection.push(item);
		return this;
	}
	public function get(index:Number):Object {
		return this._collection[index];
	}
	
	public function get length():Number {
		return this._collection.length;
	}
	
	public function remove(index:Number):Collection {
		this._collection.splice(index, 1);
		return this;
	}
	
	public function clear():Collection {
		this._collection.splice(0);
		return this;
	}
}