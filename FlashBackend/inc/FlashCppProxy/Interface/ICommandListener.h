#ifndef ICOMMANDLISTENER_H_
#define ICOMMANDLISTENER_H_

#include "FlashCppProxy/Data/StringDictionary.h"

namespace FlashCppProxy {

class ICommandListener {

public:
	virtual ~ICommandListener() {}

	virtual void OnCommand(Osp::Base::String command) = 0;
	virtual void OnCommand(WebCppProxy::Data::StringDictionary* dictionary) = 0;
	virtual void OnReady() = 0;

	//virtual void OnService(WebCppProxy::Data::StringDictionary* dictionary);
};
}
#endif
