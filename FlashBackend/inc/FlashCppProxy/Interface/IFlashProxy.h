#ifndef IWEBPROXY_H_
#define IWEBPROXY_H_

#include <FBase.h>
#include "FlashCppProxy/Data/StringDictionary.h"

using namespace Osp::Base;
using namespace FlashCppProxy::Data;
namespace FlashCppProxy {

class IFlashProxy {

public:
	virtual ~IFlashProxy() {}

	virtual void TriggerCommand(String action, String arg1 = NULL ,String arg2 = null,String arg3 = null,String arg4 = null) = 0;

};
}
#endif
