/*
 * Json.h
 *
 *  Created on: 02.03.2011
 *      Author: Root
 */

#ifndef JSON_H_
#define JSON_H_
#include <FBase.h>
#include <FBaseColHashMapT.h>

using namespace Osp::Base;
using namespace Osp::Base::Collection;

namespace FlashCppProxy { namespace Data {


enum JsonType { AArrayType, ArrayType};

class Json: public Object {
private:
	JsonType __type;
	ArrayListT<MapEntryT<String,Object* >* > __values;
public:
	Json();
	Json(JsonType type);

	virtual ~Json();

	virtual Json* Add(String key, String* value);
	virtual Json* Add(String key, Integer* value);
	virtual Json* Add(String key, Json* value);

	bool Equals(const Object& obj);
	int GetHashCode(void);

	String Stringify();
	String StringifyValue(MapEntryT<String, Object* >* entry);

	void Clear(void);
	/*
	 * utils
	 */
	static String StringifyString(String * string);


};



}}

#endif /* JSON_H_ */
