/*
 * ProxyServiceFactory.h
 *
 *  Created on: 02.03.2011
 *      Author: Root
 */

#ifndef PROXYSERVICEFACTORY_H_
#define PROXYSERVICEFACTORY_H_
#include <FBase.h>
#include <FUi.h>

#include "FlashCppProxy/Interface/IProxyService.h"
#include "FlashCppProxy/Data/StringDictionary.h"
#include "FlashCppProxy/Data/Json.h"


using namespace Osp::Base;
using namespace Osp::Base::Collection;
using namespace Osp::Ui::Controls;
using namespace FlashCppProxy;
using namespace FlashCppProxy::Data;


namespace FlashCppProxy { namespace Data {

class ProxyServiceFactory {

private:
	ArrayListT<IProxyService *> __services;
	Flash* __pFlash;
	int requestCounter; // Incremented counter
public:
	ProxyServiceFactory(Flash* flashControl);
	virtual ~ProxyServiceFactory();

	void Register(IProxyService * service);
	bool Request(
			String serviceName,
			String serviceMethod,
			StringDictionary* params = NULL);
	void Response(Json* json, String service, String method, int req_id);
};

}}

#endif /* PROXYSERVICEFACTORY_H_ */
