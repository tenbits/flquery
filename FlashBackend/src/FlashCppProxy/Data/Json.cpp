/*
 * Json.cpp
 *
 *  Created on: 02.03.2011
 *      Author: Root
 */

#include "FlashCppProxy/Data/Json.h"

namespace FlashCppProxy { namespace Data {

Json::Json(JsonType type) {
	// TODO Auto-generated constructor stub
	__type = type;
}
Json::Json(){
	__type = AArrayType;
	ArrayListT<MapEntryT<String,Object>* > __values();
}

Json*
Json::Add(String key, String* value){
	__values.Add(new MapEntryT<String,Object* >(key,value));
	return this;
}
Json*
Json::Add(String key, Integer* value){
	__values.Add(new MapEntryT<String,Object* >(key,value));
	return this;
}
Json*
Json::Add(String key, Json* value){
	__values.Add(new MapEntryT<String,Object* >(key,value));
	return this;
}


String
Json::Stringify(){
	String json = __type == AArrayType ? "{" : "[";
	IEnumeratorT<MapEntryT<String, Object* >* >* enumerator = __values.GetEnumeratorN();

	int length = __values.GetCount();
	int index = 0;
	MapEntryT<String, Object* >* current;
	while(enumerator->MoveNext() == E_SUCCESS){

		enumerator->GetCurrent(current);
		json.Append(StringifyValue(current));

		if (++index < length) json.Append(",");
	}

	json.Append( __type == AArrayType ? "}" : "]");
	delete enumerator;
	return json;
}
/*
 * Array : ["key","value"; "key2",2; "key3",JsonObject*]
 *
 * {
 * 	key: 'key',
 *  key2: 2,
 *  key3: {...}
 *  }
 */
String
Json::StringifyValue(MapEntryT<String, Object* >* item){
	String entry;
	if (__type == AArrayType){
		entry.Append("\"");
		entry.Append(item->GetKey());
		entry.Append("\":");
	}

	Object* value = item->GetValue();

	if (value == NULL){
		AppLog("JSON SERIALIZED: value is null");
		return "\"\"";
	}

	String *string = dynamic_cast<String*>(value);
	if (string != NULL){
		entry.Append(Json::StringifyString(string));
		return entry;
	}
	Integer *integer = dynamic_cast<Integer*>(value);
	if (integer != NULL){
		entry.Append(integer->ToString());
		return entry;
	}

	Json *json = dynamic_cast<Json*>(value);
	if (json != NULL){
		entry.Append(json->Stringify());
		return entry;
	}

	entry.Append("'unknown type'");
	return entry;
}

Json::~Json() {
	Clear();
}

bool Json::Equals(const Object& obj){
	return false;
}
int Json::GetHashCode(void){
	return __values.GetHashCode();
}

void
Json::Clear(void){
	if (__values.GetCount() > 0){
		MapEntryT<String, Object* >* current;
		IEnumeratorT<MapEntryT<String, Object* >* >* enumerator = __values.GetEnumeratorN();
		while(enumerator->MoveNext() == E_SUCCESS){
			enumerator->GetCurrent(current);
			String key = current->GetKey();
			Object* o = current->GetValue();
			if (o != NULL){
				delete o;
			}
		}
		__values.RemoveAll();
		delete enumerator;
	}
}

/*
 * Utils
 */
String
Json::StringifyString(String* string){

	String result = "\"";
	mchar current;
	for(int i = 0; i<string->GetLength(); i++){

		string->GetCharAt(i,current);
		switch(current){
		case '\"':
		case '\\':
		case '/':
			result.Append('\\');
			result.Append(current);
			continue;
		case '\b':
			result.Append("\\b");
			continue;
		case '\n':
			result.Append("\\n");
			continue;
		case '\f':
			result.Append("\\f");
			continue;
		case '\r':
			result.Append("\\r");
			continue;
		case '\t':
			result.Append("\\t");
			continue;
		}
		result.Append(current);
	}
	result.Append("\"");
	return result;
}
}} // namespace WebCppProxy::Data;
