/*
 * StringDictionary.h
 *
 *  Created on: 29.01.2011
 *      Author: Root
 */

#ifndef STRINGDICTIONARY_H_
#define STRINGDICTIONARY_H_
#include <FBase.h>
#include <FBaseColHashMapT.h>

using namespace Osp::Base;
using namespace Osp::Base::Collection;

namespace FlashCppProxy { namespace Data{
class StringDictionary {
private:
	ArrayListT<MapEntryT<String,String>* > __dict;

public:
	StringDictionary();
	virtual ~StringDictionary();

	void Add(String key, String value);
	IEnumeratorT<MapEntryT<String,String>* >* GetEnumeratorN();
	int GetCount();
	String GetValue(String key);
	result GetValueInt32(String key, int& integer);
	bool ContainsKey(String key);
	MapEntryT<String,String >* GetKeyValue(int position);

	static StringDictionary * CreateN(ArrayList & params, int startIndex = 0){
		StringDictionary * _dict = new StringDictionary;

		int length = params.GetCount();
		for(int i = startIndex; i< length; i++){
			String * entry =  static_cast<String*>(params.GetAt(i));
			if (entry == null){
				AppLog("StringDict.CreatN entry is null");
				continue;
			}

			int eq = 0;
			if (entry->IndexOf("=",0, eq) != E_SUCCESS){
				AppLog("StringDict.CreatN no equation character.key=value");
				continue;
			}

			String key, value;
			entry->SubString(0, eq, key);
			entry->SubString(eq + 1, value);

			_dict->Add(key, value);
		}

		return _dict;
	}

	static StringDictionary* ParseCommandsN(String& line) {

		StringDictionary* dict = new StringDictionary();

		ArrayListT<String>* paars = new ArrayListT<String> ();
		bool isInEscape = false;

		mchar ch;
		mchar prev = null;
		/*
		 * parse items;
		 */
		for (int i = 0; i < line.GetLength(); i++) {
			line.GetCharAt(i, ch);
			if (ch == '\\') {
				isInEscape = !isInEscape;
				prev = ch;
				continue;
			}
			if (isInEscape && i > 0 && prev != '\\') {
				isInEscape = false;
			}
			if (ch != '&' || isInEscape) {
				prev = ch;
				continue;
			}
			String paar;
			line.SubString(0, i, paar);
			paars->Add(paar);
			line.SubString(i + 1, line);
			if (i == line.GetLength() - 1)
				break;
			i = 0;
		}

		if (line.GetLength() > 0) {
			paars->Add(line);
		}
		isInEscape = false;

		IEnumeratorT<String>* e = paars->GetEnumeratorN();
		String keyValue;

		prev = null;
		/*
		 * parse key=value
		 */
		while (e->MoveNext() == E_SUCCESS) {
			e->GetCurrent(keyValue);
			for (int i = 0; i < keyValue.GetLength() - 1; i++) {
				keyValue.GetCharAt(i, ch);
				if (ch == '\\') {
					isInEscape = !isInEscape;
					prev = ch;
					continue;
				}
				if (isInEscape && i > 0 && prev != '\\') {
					isInEscape = false;
				}

				if (isInEscape || ch != '=') {
					prev = ch;
					continue;
				}

				String key, value;
				keyValue.SubString(0, i, key);
				keyValue.SubString(i + 1, value);

				/*
				 * unescape
				 */
				key.Replace(L"\\&",L"&");
				key.Replace(L"\\=",L"=");
				value.Replace(L"\\&",L"&");
				value.Replace(L"\\=",L"=");

				AppLog("stringdict. %S %S", key.GetPointer(), value.GetPointer());
				dict->Add(key, value);

				break;
			}

		}

		delete paars;
		delete e;

		return dict;
	}
};
};}

#endif /* STRINGDICTIONARY_H_ */
