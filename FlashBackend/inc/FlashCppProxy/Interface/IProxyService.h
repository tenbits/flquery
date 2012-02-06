#ifndef IPROXYSERVICE_H_
#define IPROXYSERVICE_H_

#include "FlashCppProxy/Data/StringDictionary.h"
#include "FlashCppProxy/Data/Json.h"
#include "FlashCppProxy/Interface/IFlashProxy.h"

using namespace Osp::Base;
using namespace FlashCppProxy::Data;
namespace FlashCppProxy {

class IProxyService {

public:
	Osp::Base::String Name;
	FlashCppProxy::IFlashProxy * FlashProxy;

	virtual ~IProxyService() {}
	/*
	 * return: json string
	 */
	virtual Json* RunN(
			String method,
			FlashCppProxy::Data::StringDictionary* params) = 0;

};
}
#endif
