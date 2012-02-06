/*
 * StringDictionary.cpp
 *
 *  Created on: 29.01.2011
 *      Author: Root
 */
#include "FlashCppProxy/Data/StringDictionary.h"

using namespace FlashCppProxy::Data;

StringDictionary::StringDictionary() {

}

void
StringDictionary::Add(String key, String value){
	__dict.Add(new MapEntryT<String,String>(key,value));
}

int
StringDictionary::GetCount(){
	return __dict.GetCount();
}

String
StringDictionary::GetValue(String key){
	IEnumeratorT<MapEntryT<String,String>* >* enumerator = __dict.GetEnumeratorN();
	MapEntryT<String,String>* current;
	while(enumerator->MoveNext() == E_SUCCESS){
		enumerator->GetCurrent(current);
		if (current->GetKey() == key){
			delete enumerator;
			return current->GetValue();
		}
	}
	delete enumerator;
	return "";
}

result
StringDictionary::GetValueInt32(String key, int& integer){
	String value = GetValue(key);
	return Integer::Parse(value, integer);
}


MapEntryT<String,String >*
StringDictionary::GetKeyValue(int pos){
	MapEntryT<String,String >* temp;
	__dict.GetAt(pos,temp);
	return temp;
}

IEnumeratorT<MapEntryT<String,String>* >*
StringDictionary::GetEnumeratorN(){
	return __dict.GetEnumeratorN();
}

bool StringDictionary::ContainsKey(String key){
	IEnumeratorT<MapEntryT<String,String>* >* enumerator = __dict.GetEnumeratorN();
	MapEntryT<String,String>* current;
	while(enumerator->MoveNext() == E_SUCCESS){
		enumerator->GetCurrent(current);
		if (current->GetKey() == key){
			delete enumerator;
			return true;
		}
	}
	delete enumerator;
	return false;
}
StringDictionary::~StringDictionary() {
	MapEntryT<String,String>* temp = null;
	for(int i = 0; i< __dict.GetCount(); i++)
	{
		__dict.GetAt(i, temp);
		if (temp == null) continue;
		delete temp;
		temp = null;
	}
}

