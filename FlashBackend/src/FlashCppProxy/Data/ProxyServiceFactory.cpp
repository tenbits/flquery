/*
 * ProxyServiceFactory.cpp
 *
 *  Created on: 02.03.2011
 *      Author: Root
 */

#include "FlashCppProxy/Data/ProxyServiceFactory.h"

namespace FlashCppProxy { namespace Data {

ProxyServiceFactory::ProxyServiceFactory(Flash* flashControl) {
	Osp::Base::Collection::ArrayListT<IProxyService *> __services();
	__pFlash = flashControl;
	requestCounter = 0;
}

ProxyServiceFactory::~ProxyServiceFactory() {
	// TODO Auto-generated destructor stub
}

void
ProxyServiceFactory::Register(IProxyService * __service){
	__services.Add(__service);
}

bool
ProxyServiceFactory::Request(
			String serviceName,
			String serviceMethod,
			StringDictionary* params){


	requestCounter++;

	IEnumeratorT<IProxyService*>* enumerator = __services.GetEnumeratorN();
	IProxyService* current;
	while(enumerator->MoveNext() == E_SUCCESS){
		enumerator->GetCurrent(current);
		if (current == null){
			continue;
		}
		if (serviceName == current->Name){
			Json* json = current->RunN(serviceMethod, params);
			if (json != NULL){

				int req_id = -1;
				if (params != NULL) params->GetValueInt32("requestid",req_id);
				Response(json,serviceName,serviceMethod, req_id);
				delete json;
			}
			delete enumerator;
			return true;
		}
	}
	delete enumerator;
	AppLog("Service Endpoint was not found %S",serviceName.GetPointer());
	return false;
}

void
ProxyServiceFactory::Response(Json* json,String service, String method, int req_id){
	ArrayList  dataList;
	dataList.Construct();


	//dataList.Add(*(new String(method)));
	dataList.Add(*(new String(Integer::ToString(req_id))));

	dataList.Add(*(new String(json->Stringify())));


	AppLog("send response %d %S", req_id,json->Stringify().GetPointer());
	__pFlash->SendDataEventToActionScript("ServiceHandler",dataList);
	dataList.RemoveAll(true);
}

}}
