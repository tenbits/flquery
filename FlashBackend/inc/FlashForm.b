#ifndef _FLASHFORM_H_
#define _FLASHFORM_H_

#include <FBase.h>
#include <FUi.h>
#include <FGraphics.h>
#include <FSystem.h>

using namespace Osp::Base;
using namespace Osp::Ui::Controls;
using namespace Osp::System;
using namespace Osp::Graphics;
using namespace Osp::Base::Collection;
using namespace Osp::Ui;

class FlashForm :
	public Osp::Ui::Controls::Form,
	public Osp::Ui::IKeyEventListener,
	public Osp::Ui::IFlashEventListener
{

// Construction
public:
	FlashForm(void);
	virtual ~FlashForm(void);
	bool Initialize(void);
	void PlayFlash(void);
	void OnUserEventReceivedN(RequestId requestId, Osp::Base::Collection::IList* pArgs);
	Osp::Ui::Controls::Flash* GetFlashInstance(void);

public:
	static const int REQUEST_FLASH_PLAY = 100;

// Implementation
protected:
	Osp::Ui::Controls::Flash *__pFlash;

public:
	virtual result OnInitializing(void);
	virtual result OnTerminating(void);
	virtual void OnKeyLongPressed (const Osp::Ui::Control &source, Osp::Ui::KeyCode keyCode);
	virtual void OnKeyPressed (const Osp::Ui::Control &source, Osp::Ui::KeyCode keyCode);
	virtual void OnKeyReleased (const Osp::Ui::Control &source, Osp::Ui::KeyCode keyCode);

	String CreateFlashControl(){
			result r = E_SUCCESS;
				int screen_width = 0;
				int screen_height = 0;


			    SystemInfo::GetValue("ScreenWidth", screen_width);
			    SystemInfo::GetValue("ScreenHeight", screen_height);

			    __pFlash = new Flash();


				if (screen_height > 700){
					//screen_height -= 38;
				}else{
					//screen_height -= 19;
				}

				r = __pFlash->Construct(Rectangle(0, 0, screen_width, screen_height), FLASH_STYLE_PLAY_WITHOUT_FOCUS, L"/res/main.swf");
				TryCatch(r == E_SUCCESS, ,"Flash is not constructed\n ");

				__pFlash->SetQuality(FLASH_QUALITY_LOW);
				__pFlash->SetRepeatMode(FLASH_REPEAT_LOOP);

				AddControl(*__pFlash);
				return screen_height > 500 ? "_480x800" : "_240x400";

			CATCH:
				AppLog("Error = %s\n", GetErrorMessage(r));
				return "_240x400";
		}

	void OnFlashDataReceived(const Osp::Ui::Control& source,
  				const Osp::Base::Collection::IList& paramList) {
  			AppLog("data received");

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
  				__pFlash->SendDataToActionScript(todayTime);

  			}
  			else if(pReceivedMethod->Equals(L"GetDimension",true))
  			{
  				/*
  				 * FSCommand2("GetVars","SetDimension", Dimension);
  				 */
  				int		width  = __pFlash->GetWidth();
  				int		height = __pFlash->GetHeight();

  				String dimensionData;
  				String widthData  = Osp::Base::Integer::ToString(width);
  				String heightData = Osp::Base::Integer::ToString(height);

  				// Send the dimension data to flash.
  				// dimensionData : "width=value1&height=value2", '&' -> data separator
  				dimensionData = widthData + "x" + heightData;
  				__pFlash->SendDataToActionScript(dimensionData);

  			}
  		}

  		void OnFlashTextEntered(const Osp::Ui::Control& source,
  				FlashTextInputMode inputMode, const Osp::Base::String& defaultText,
  				int limitTextLength) {

  		}

  		void OnFlashLayoutChanged(const Osp::Ui::Control& source,
  				FlashLayoutStyle layoutStyle) {


  		}

};
#endif	//_FLASHFORM_H_

