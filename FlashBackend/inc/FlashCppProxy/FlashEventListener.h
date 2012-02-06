/*
 * FlashCppProxyForm.h
 *
 *  Created on: 20.09.2011
 *      Author: Root
 */

#ifndef FLASHEVENT_H_
#define FLASHEVENT_H_

#include <FUi.h>
#include <FBase.h>
#include <FSystem.h>
#include <FlashCppProxy/Utils.h>
#include <FlashCppProxy/FlashProxyForm.h>
#include <FlashCppProxy/Data/ProxyServiceFactory.h>

namespace FlashCppProxy {

using namespace Osp::Base;
using namespace Osp::Base::Collection;
using namespace Osp::Ui;
using namespace Osp::Ui::Controls;
using namespace Osp::System;

class FlashEventListener:
	public Osp::Ui::IFlashEventListener,
	public Osp::Ui::ITextEventListener{
private:
	//FlashProxyForm* __flash;
	Flash* __flashControl;
	ProxyServiceFactory * __serviceFactory;
	Keypad * keypad;
public:
	FlashEventListener() {

	}

	void Construct(Flash* flash, ProxyServiceFactory * serviceFactory){
		 keypad = new Keypad();
		 keypad->Construct(KEYPAD_STYLE_NORMAL, KEYPAD_MODE_PREDICTIVE);
		 keypad->AddTextEventListener(*this);
		 keypad->SetShowState(false);

		 __flashControl = flash;
		 __serviceFactory = serviceFactory;
	}

	virtual ~FlashEventListener() {
		if (keypad){
			delete keypad;
		}

	}

	void OnFlashDataReceived(const Osp::Ui::Control& source,
			const Osp::Base::Collection::IList& paramList) {

			AppLog("receive data");

			ArrayList   params;
			params.Construct();
			params.AddItems(paramList);

			String * pReceivedMethod = static_cast<String*> (params.GetAt(0));

			if(pReceivedMethod->Equals(L"Alert",true))
			{
				FlashCppProxy::Utils::Alert(*(static_cast<String*> (params.GetAt(1))));
			}
			else if(pReceivedMethod->Equals(L"Confirm",true))
			{
				__flashControl->Pause();
				bool answer = FlashCppProxy::Utils::Confirm(*(static_cast<String*> (params.GetAt(1))));
				__flashControl->Resume();

				ArrayList response;
				response.Construct();
				response.Add(*(new String(answer ? "1" : "0")));
				__flashControl->SendDataEventToActionScript(L"ConfirmHandler",response);
				response.RemoveAll(true);
			}
			else if(pReceivedMethod->Equals(L"Trace",true))
			{
				AppLog("FLASH: %S", (static_cast<String*> (params.GetAt(1)))->GetPointer());
			}
			else{
				String * service = static_cast<String*> (params.GetAt(0));
				String * method =  static_cast<String*> (params.GetAt(1));
				String * data = static_cast<String*> (params.GetAt(2));

				StringDictionary * _dict = (data == NULL ? NULL : StringDictionary::ParseCommandsN(*data));

				AppLog("custom service %S %S", service->GetPointer(), method->GetPointer());
				__serviceFactory -> Request(*service, *method, _dict);

				if (_dict != NULL) delete _dict;

			}


	}

	void OnFlashDataReturned(const Osp::Ui::Control& source,
			const Osp::Base::Collection::IList& paramList) {

		AppLog("receive command");
		ArrayList 	params;
		String* 	pReceivedMethod;

		params.Construct();
		params.AddItems(paramList);

		pReceivedMethod = static_cast<String*> (params.GetAt(0));

		AppLog("receive method %S", pReceivedMethod->GetPointer());


		if(pReceivedMethod->Equals(L"GetDate",true))
		{
			/*
			 * FSCommand2("Get","GetDate", date);
			 */
			String 	 todayTime;
			DateTime today;

			SystemTime::GetCurrentTime(UTC_TIME,today);

			int year  = today.GetYear();
			int month = today.GetMonth();
			int day   = today.GetDay();

			// Send the date data to flash
			todayTime = Osp::Base::Integer::ToString(year) +
						Osp::Base::Integer::ToString(month) +
						Osp::Base::Integer::ToString(day);
			__flashControl->SendDataToActionScript(todayTime);

		}
		else if(pReceivedMethod->Equals(L"GetDimension",true))
		{
			/*
			 * FSCommand2("GetVars","SetDimension", Dimension);
			 */
			int		width  = __flashControl->GetWidth();
			int		height = __flashControl->GetHeight();

			String dimensionData;
			String widthData  = Osp::Base::Integer::ToString(width);
			String heightData = Osp::Base::Integer::ToString(height);

			// Send the dimension data to flash.
			// dimensionData : "width=value1&height=value2", '&' -> data separator
			dimensionData = widthData + "x" + heightData;
			__flashControl->SendDataToActionScript(dimensionData);

		}else{
			String * service = pReceivedMethod;
			String * method =  static_cast<String*> (params.GetAt(1));

			AppLog("custom service get %S %S", service->GetPointer(), method->GetPointer());

			StringDictionary * _dict = StringDictionary::CreateN(params,2);
			__serviceFactory -> Request(*service, *method, _dict);
			delete _dict;
		}

	}

	void OnFlashTextEntered(const Osp::Ui::Control& source,
			FlashTextInputMode inputMode, const Osp::Base::String& defaultText,
			int limitTextLength) {

		keypad->SetText(defaultText);
		keypad->SetShowState(true);
		keypad->Show();
	}

	void OnFlashLayoutChanged(const Osp::Ui::Control& source,
			FlashLayoutStyle layoutStyle) {
		AppLog("on flash layout changed");
	}


	void OnTextValueChanged(const Osp::Ui::Control& source){
		__flashControl->EnterText(keypad->GetText());
	}
	void OnTextValueChangeCanceled(const Osp::Ui::Control& source){
		__flashControl->CancelText();
	}

};
}

#endif
