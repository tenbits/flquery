/*
 * FlashCppProxyForm.h
 *
 *  Created on: 20.09.2011
 *      Author: Root
 */

#ifndef FLASHCPPPROXYFORM_H_
#define FLASHCPPPROXYFORM_H_

#include <FBase.h>
#include <FUi.h>
#include <FSystem.h>
#include <FlashCppProxy/FlashEventListener.h>
#include <FlashCppProxy/Data/ProxyServiceFactory.h>
#include <FlashCppProxy/Interface/IProxyService.h>
#include <FlashCppProxy/MultiTouch.h>

using namespace Osp::App;
using namespace Osp::Ui::Controls;
using namespace Osp::Base;
using namespace Osp::System;
using namespace Osp::Graphics;
using namespace Osp::Ui;

namespace FlashCppProxy {

class FlashProxyForm:
	public Osp::Ui::Controls::Form,
	public Osp::Ui::IOrientationEventListener,
	/** check flv play */
	public IPlayerEventListener{
private:
	Osp::Ui::Controls::Flash * __pFlashControl;
	FlashEventListener* __flashEventListener;
	ProxyServiceFactory* __serviceFactory;

	//Osp::Media::Player * __player;
	FlashCppProxy::MultiTouch * __multiTouch;
public:
	static FlashProxyForm * Instance;

	FlashProxyForm(){
		//FlashProxyForm::Instance = this;
	}
	virtual ~FlashProxyForm(){
		if (__flashEventListener != NULL){
			delete __flashEventListener;
		}
	}
	bool Initialize(void){
		Construct(FORM_STYLE_NORMAL);
		SetOrientation(ORIENTATION_PORTRAIT);

		CreateFlashControl();


		__serviceFactory = new ProxyServiceFactory(__pFlashControl);
		return true;
	}

	result OnInitializing(void){

		SendUserEvent(100, null);

		return E_SUCCESS;
	}


	void
	OnUserEventReceivedN(RequestId requestId, Osp::Base::Collection::IList* pArgs)
	{
		if(requestId == 100)
		{
			//AddKeyEventListener(*this);
			__flashEventListener = new FlashEventListener;
			__flashEventListener->Construct(__pFlashControl, __serviceFactory);

			//__pFlashControl->SetRepeatMode(FLASH_REPEAT_LOOP);


			__pFlashControl->AddFlashEventListener(*__flashEventListener);

			this->AddOrientationEventListener(*this);



			this->__multiTouch = new MultiTouch(this->__pFlashControl);


			Draw();
			Show();

			//__pFlashControl->SendDataToActionScript("_root.mydata=99");
			__pFlashControl->Play();
			AppLog("play");
		}else if (requestId == 101){
			__pFlashControl->SetShowState(false);

		}

	}

	void Play(void){

		//__pFlashControl->SetRepeatMode(FLASH_REPEAT_LOOP);
		//__pFlashControl->Play();

	}
	String CreateFlashControl(){
		result r = E_SUCCESS;
			int screen_width = 0;
			int screen_height = 0;


		    SystemInfo::GetValue("ScreenWidth", screen_width);
		    SystemInfo::GetValue("ScreenHeight", screen_height);

		    __pFlashControl = new Flash();


			if (screen_height > 700){
				//screen_height -= 38;
			}else{
				//screen_height -= 19;
			}


			AppLog("screen %d %d",screen_width, screen_height);

			//-String file = FlashCppProxy::Utils::prepairLauncher();
			String file = "/Res/main.swf";
			AppLog("swf file: %S", file.GetPointer());
			r = __pFlashControl->Construct(Rectangle(0, 0, screen_width, screen_height),
					FLASH_STYLE_PLAY_WITHOUT_FOCUS,
					file);
			__pFlashControl->SetBackgroundColor(Osp::Graphics::Color::COLOR_BLACK);


			TryCatch(r == E_SUCCESS, ,"Flash is not constructed\n ");


			AddControl(*__pFlashControl);

			__pFlashControl->SetQuality(FLASH_QUALITY_HIGH);
			__pFlashControl->SetRepeatMode(FLASH_REPEAT_LOOP);



			return screen_height > 500 ? "_480x800" : "_240x400";

		CATCH:
			AppLog("Error = %s\n", GetErrorMessage(r));
			return "_240x400";
	}

	static FlashProxyForm* CreateInstanceN(Frame *container){

		FlashProxyForm* pFlashForm = new FlashProxyForm();
		pFlashForm->Initialize();

		//container->AddControl(*pFlashForm);
		//container->SetCurrentForm(*pFlashForm);


		return pFlashForm;
	}

	Flash* getFlashInstance(){
		return __pFlashControl;
	}

	void TriggerCommand(String action, String arg1 = NULL ,String arg2 = null,String arg3 = null,String arg4 = null){
		ArrayList  dataList;
		dataList.Construct();
		dataList.Add(action);

		if (arg1 != NULL) dataList.Add(arg1);//*(new String(arg1)));
		if (arg2 != NULL) dataList.Add(arg2);
		if (arg3 != NULL) dataList.Add(arg3);
		if (arg4 != NULL) dataList.Add(arg4);


		__pFlashControl->SendDataEventToActionScript("CommandHandler",dataList);
		//dataList.RemoveAll(true);
	}

	void volume(int value){
		if (value > 99) value = 100;
		if (value < 0) value = 0;

		//value = 70 * value / 100;
		__pFlashControl->SetVolume(value);
		__pFlashControl->SetSoundEnabled(true);


		this->TriggerCommand("volume", Integer::ToString(value));
	}
	void volumeUp(){
		this->volume(__pFlashControl->GetVolume()  + 10);
	}
	void volumeDown(){
		this->volume(__pFlashControl->GetVolume() - 10);
	}

	void registerService(IProxyService * service){
		__serviceFactory->Register(service);
	}

	void OnOrientationChanged(const Osp::Ui::Control& source, Osp::Ui::OrientationStatus orientationStatus){
		switch(orientationStatus){
			case ORIENTATION_PORTRAIT:
			case ORIENTATION_PORTRAIT_REVERSE:
				this->__pFlashControl->SetBounds(0,0,480,800);
				TriggerCommand("orientation-portrait");
				AppLog("portr");
			break;
			case ORIENTATION_LANDSCAPE:
			case ORIENTATION_LANDSCAPE_REVERSE:
				this->__pFlashControl->SetBounds(0,0,800,480);
				TriggerCommand("orientation-landscape");
				AppLog("landscp");
			break;
		}
	}

	/**remove */
	void OnPlayerOpened( result r ) {}
	void OnPlayerEndOfClip(void) {}
	void OnPlayerSeekCompleted( result r ){};
	void OnPlayerBuffering(int percent) {}
	void OnPlayerErrorOccurred( PlayerErrorReason r ) {}
	void OnPlayerInterrupted(void) {}
	void OnPlayerReleased(void) {}
};

}

#endif /* FLASHCPPPROXYFORM_H_ */
