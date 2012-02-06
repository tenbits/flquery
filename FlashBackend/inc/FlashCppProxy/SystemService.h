/*
 * SystemService.h
 *
 *  Created on: 07.12.2011
 *      Author: Root
 */

#ifndef SYSTEMSERVICE_H_
#define SYSTEMSERVICE_H_


#include <FBase.h>
#include <FIo.h>

#include <FlashCppProxy/FlashProxyForm.h>
#include <FlashCppProxy/Interface/IProxyService.h>
#include <FlashCppProxy/Data/Json.h>


namespace FlashCppProxy {

using namespace Osp::Io;
using namespace Osp::Base::Collection;
using namespace Osp::Base;


class SystemService:
	public FlashCppProxy::IProxyService{
private:
	FlashProxyForm * __form;
public:
	SystemService(FlashProxyForm * form){
		__form = form;
		this->Name = "system";
	}
	virtual ~SystemService(){

	}

	Json* RunN(String method,FlashCppProxy::Data::StringDictionary* params){
			AppLog("method %s", method.GetPointer());
			if (method == "alert"){
				if (params == null) return null;

				String message = params->GetValue("message");
				AppLog("message %S", message.GetPointer());
				FlashCppProxy::Utils::Alert(message);

				return NULL;
			}
			if (method == "quit"){
				Osp::App::Application::GetInstance()->Terminate();
			}
			if (method == "activity"){
				String status = params->GetValue("status");
				Osp::System::PowerManager::KeepScreenOnState(status == "1", false);
				return NULL;
			}
			if (method == "orientation"){
				String status = params->GetValue("status");

				Orientation orientation;

				if (status == "portrait") orientation = ORIENTATION_PORTRAIT;
				else if (status == "landscape") orientation = ORIENTATION_LANDSCAPE;
				else if (status == "auto") orientation = ORIENTATION_AUTOMATIC_FOUR_DIRECTION;
				this->__form->SetOrientation(orientation);

				return NULL;
			}
			return NULL;
		}
};

}

#endif /* SYSTEMSERVICE_H_ */
