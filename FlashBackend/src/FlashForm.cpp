#include "FlashForm.h"
#include "MenuForm.h"

using namespace Osp::Base;
using namespace Osp::Base::Collection;
using namespace Osp::Ui;
using namespace Osp::Ui::Controls;
using namespace Osp::Graphics;
using namespace Osp::System;

FlashForm::FlashForm(void)
	:	__pMenuForm(null),
		__pFlash(null),
		__pPopup(null),
		__pButton(null),
		__pLabel(null),
		__pKeypad(null),
		__fileName(L""),
		__fileUrl(L""),
		__oldText(L"")
{
}

FlashForm::~FlashForm(void)
{
	if(__pKeypad)
	{
		delete __pKeypad;
		__pKeypad = null;
	}

	if(__pPopup)
	{
		delete __pPopup;
		__pPopup = null;
	}
}

bool
FlashForm::Initialize(Osp::Ui::Controls::Form* pMenuForm, Osp::Base::String& titleText, Osp::Base::String& fileName, Osp::Base::String& fileUrl)
{
	result r = E_SUCCESS;

	__pMenuForm = pMenuForm;
	__fileName = "/res/main.swf";
	__fileUrl = fileUrl;

	r = Construct(FORM_STYLE_NORMAL | FORM_STYLE_TITLE | FORM_STYLE_INDICATOR | FORM_STYLE_SOFTKEY_1);
	if(IsFailed(r))
	{
		AppLog("Failed to Construct the FlashForm.");
		return false;
	}
	SetTitleText(titleText);

	SetSoftkeyText(SOFTKEY_1, L"Exit");
	SetSoftkeyActionId(SOFTKEY_1, ID_FLASHFORM_EXIT);
	AddSoftkeyActionListener( SOFTKEY_1, *this);

	return true;
}

result
FlashForm::OnInitializing(void)
{
	Rectangle bounds(0,0,GetClientAreaBounds().width, GetClientAreaBounds().height);

	__pFlash = new Flash();

	if (!__fileUrl.GetLength())
		__pFlash->Construct(bounds, FLASH_STYLE_PLAY_WITHOUT_FOCUS, __fileName);
	else
		__pFlash->Construct(bounds, FLASH_STYLE_PLAY_WITHOUT_FOCUS, __fileName, __fileUrl);
	AddControl(*__pFlash);

	SetFlashProperties();
	PlayFlash();

	return E_SUCCESS;
}

result
FlashForm::OnTerminating(void)
{
	// TODO: Add your termination code here
	return E_SUCCESS;
}

bool
FlashForm::SetFlashProperties(void)
{
    __pFlash->SetQuality(FLASH_QUALITY_HIGH);
	__pFlash->SetRepeatMode(FLASH_REPEAT_NONE);
	__pFlash->AddFlashEventListener(*this);
	AddKeyEventListener(*this);

	return true;
}

bool
FlashForm::PlayFlash(void)
{
	bool 	silentMode = false;
	String 	stateBtHeadset;
	String 	stateHeadset;
	String 	stateHeadphone;

	SettingInfo::GetValue(L"SilentMode", silentMode);

	DeviceManager::GetState(BluetoothHeadset, stateBtHeadset);
	DeviceManager::GetState(WiredHeadset, stateHeadset);
	DeviceManager::GetState(WiredHeadphone, stateHeadphone);

	if(stateBtHeadset == L"Inserted" || stateHeadset == L"Inserted" || stateHeadphone == L"Inserted")
	{
		__pFlash->SetSoundEnabled(true);
	}
	else
	{
		__pFlash->SetSoundEnabled(!silentMode);
	}

	Draw();
	Show();

	__pFlash->Play();

	return true;
}

void
FlashForm::CreatePopup(Osp::Base::String popupTitle)
{
	// Create Popup
	__pPopup = new Popup();
	__pPopup->Construct(true, Dimension(350,350));
	__pPopup->SetTitleText(popupTitle);
	__pPopup->SetShowState(true);

	// Create Button
	__pButton = new Button();
	__pButton->Construct(Rectangle(110,180,150, 70), L"OK");
	__pButton->SetActionId(ID_BUTTON_OK);
	__pButton->AddActionEventListener(*this);
	__pPopup->AddControl(*__pButton);

	// Create Label
	__pLabel = new Label();
	__pLabel->Construct(Rectangle(10, 10, 350, 120), L"Empty");
	__pLabel->SetTextConfig(36, LABEL_TEXT_STYLE_NORMAL);
	__pLabel->SetTextHorizontalAlignment(ALIGNMENT_CENTER);
	__pLabel->SetTextVerticalAlignment(ALIGNMENT_MIDDLE);
	__pPopup->AddControl(*__pLabel);
}

void
FlashForm::OnActionPerformed(const Osp::Ui::Control& source, int actionId)
{
	Frame* pFrame = static_cast<Frame*>(GetParent());

	switch(actionId)
	{
	case ID_FLASHFORM_EXIT:
		if (__pFlash)
		{
			__pFlash->Stop();
			__pFlash = null;
		}
		pFrame->SetCurrentForm(*__pMenuForm);
		__pMenuForm->SendUserEvent(MenuForm::REQUEST_FLASHFORM_REMOVE, null);
		break;

	case ID_BUTTON_OK:
		if(__pPopup)
		{
			delete __pPopup;
			__pPopup = null;
		}
		__pFlash->Resume();
		break;

	default:
		break;
	}

	pFrame->Draw();
	pFrame->Show();
}

void
FlashForm::OnFlashDataReceived (const Osp::Ui::Control &source, const Osp::Base::Collection::IList &paramList)
{
	AppLog("flash received");
	String 		message;
	ArrayList   params;
	ArrayList   dataList;
	String* 	pReceivedMethod;
	String* 	pReceivedDataValue;

	params.Construct();
	params.AddItems(paramList);

	pReceivedMethod    = static_cast<String*> (params.GetAt(0));
	pReceivedDataValue = static_cast<String*> (params.GetAt(1));

	if(__pPopup)
	{
		AppLog("Popup already has been created.");
		return;
	}

	CreatePopup(L"OnFlashDataReceived");

	if(pReceivedMethod->Equals(L"SetDate",true))
	{
		/*
		 * FSCommand2("Set","SetDate", date);
		 */
		// Get the received date value
		message = *pReceivedDataValue;
	}
	else if(pReceivedMethod->Equals(L"SetDimension",true))
	{
		/*
		 * FSCommand2("SetVars","SetDimension", dimension);
		 */
		// Get the received dimension value
		// Message : "width=value1&height=value2", '&' -> data separator
		message = *pReceivedDataValue;
	}
	else if(pReceivedMethod->Equals(L"SendDataEvent",true))
	{
		/* FSCommand2("Set","SendDataEvent", "/");
		 * Comment : "/" is nothing to do with an action, dummy parameter.
		 *
		 * OnMenuItemChanged = new Object();
		 * OnMenuItemChanged.onEvent = function(arg1, arg2) {
		 * 		txtMenu.text = arg1;
		 *      txtNum.text  = arg2;
		 * };
		 * ExtendedEvents.ItemChanged.addListener(OnMenuItemChanged);
		 *
		 * Usage : ExtendedEvents.[UserDefineEventHandler].addListener(UserDefineEvent)
		 */

		// Send data lists to flash
		dataList.Construct();
		dataList.Add(*(new String(L"Flash UI")));
		dataList.Add(*(new String(L"2")));
		// ItemChaged -> UserDefineEventHandler
		__pFlash->SendDataEventToActionScript(L"ItemChanged",dataList);

		// Display message box
		String* pMenuData   = static_cast<String*>(dataList.GetAt(0));
		String* pNumberData = static_cast<String*>(dataList.GetAt(1));
		message = " Number = " + *pNumberData + "\n" + " Menu = " + *pMenuData;
		__pPopup->SetTitleText(L"SendDataEvent");
	}

	__pLabel->SetText(message);
	__pFlash->Pause();
	__pPopup->Show();

	dataList.RemoveAll(true);
}


void
FlashForm::OnFlashDataReturned (const Osp::Ui::Control &source,	const Osp::Base::Collection::IList &paramList)
{
	AppLog("flash returned");
	ArrayList 	params;
	String* 	pReceivedMethod;

	params.Construct();
	params.AddItems(paramList);

	pReceivedMethod = static_cast<String*> (params.GetAt(0));

	if(__pPopup)
	{
		AppLog("Popup already has been created.");
		return;
	}



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
		dimensionData = "width=" + widthData + "&" + "height=" + heightData;
		__pFlash->SendDataToActionScript(dimensionData);

	}

}

void
FlashForm::OnFlashTextEntered(const Osp::Ui::Control& source, FlashTextInputMode inputMode, const Osp::Base::String& defaultText, int limitTextLength)
{
	__oldText = defaultText;

	if(__pKeypad)
	{
		delete __pKeypad;
		__pKeypad = null;
	}

	__pKeypad = new Keypad();

	if(inputMode == FLASH_TEXT_INPUTMODE_PASSWORD)
	{
		__pKeypad->Construct(KEYPAD_STYLE_PASSWORD, KEYPAD_MODE_ALPHA, limitTextLength);
	}
	else
	{
		__pKeypad->Construct(KEYPAD_STYLE_NORMAL, KEYPAD_MODE_ALPHA, limitTextLength);
	}

	__pKeypad->AddTextEventListener(*this);
	__pKeypad->SetText(defaultText);
	__pKeypad->Show();
}

void
FlashForm::OnFlashLayoutChanged(const Osp::Ui::Control& source, FlashLayoutStyle layoutStyle)
{
	if(layoutStyle == FLASH_LAYOUT_STYLE_FULLSCREEN)
	{
		__pFlash->SetPosition(0,0);
		__pFlash->SetSize(GetClientAreaBounds().width, GetClientAreaBounds().height);
	}
	else if(layoutStyle == FLASH_LAYOUT_STYLE_CLIENT)
	{
		__pFlash->SetPosition(120, 200);
		__pFlash->SetSize(240, 400);
	}
	Draw();
	Show();
}

void
FlashForm::OnKeyLongPressed (const Osp::Ui::Control &source, Osp::Ui::KeyCode keyCode)
{
}

void
FlashForm::OnKeyPressed (const Osp::Ui::Control &source, Osp::Ui::KeyCode keyCode)
{
	int oldVolume = __pFlash->GetVolume();
	int newVolume = 0;

	switch(keyCode)
	{
	case KEY_SIDE_UP:
		newVolume = oldVolume <= 90 ? oldVolume + 5 : oldVolume;
		break;
	case KEY_SIDE_DOWN:
		newVolume = oldVolume >= 5 ? oldVolume - 5 : oldVolume;
		break;
	default:
		return;
	}

	if(oldVolume != newVolume)
	{
		__pFlash->SetVolume(newVolume);
	}
}

void
FlashForm::OnKeyReleased (const Osp::Ui::Control &source, Osp::Ui::KeyCode keyCode)
{
}

void
FlashForm::OnTextValueChanged(const Osp::Ui::Control& source)
{
	__pFlash->EnterText(__pKeypad->GetText());
}

void
FlashForm::OnTextValueChangeCanceled(const Osp::Ui::Control& source)
{
	__pFlash->CancelText();
}
