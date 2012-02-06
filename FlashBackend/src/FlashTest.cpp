/**
 * Name        : FlashTest
 * Version     : 
 * Vendor      : 
 * Description : 
 */


#include "FlashTest.h"
#include "FlashForm.h"


using namespace Osp::App;
using namespace Osp::Base;
using namespace Osp::System;
using namespace Osp::Ui;
using namespace Osp::Ui::Controls;

FlashTest::FlashTest()
{
}

FlashTest::~FlashTest()
{
}

Application*
FlashTest::CreateInstance(void)
{
	// Create the instance through the constructor.
	return new FlashTest();
}

bool
FlashTest::OnAppInitializing(AppRegistry& appRegistry)
{
	// TODO:
	// Initialize UI resources and application specific data.
	// The application's permanent data and context can be obtained from the appRegistry.
	//
	// If this method is successful, return true; otherwise, return false.
	// If this method returns false, the application will be terminated.

	// Uncomment the following statement to listen to the screen on/off events.
	//PowerManager::SetScreenEventListener(*this);

	// Create a form
	Frame *pFrame = GetAppFrame()->GetFrame();


		__pFlashForm = FlashCppProxy::FlashProxyForm::CreateInstanceN(pFrame);

		pFrame->AddControl(*__pFlashForm);
		pFrame->SetCurrentForm(*__pFlashForm);
		__pFlashForm->Draw();
		__pFlashForm->Show();

		__pFlashForm->Play();

		__pFlashForm->AddKeyEventListener(*this);



		__systemService = new SystemService(__pFlashForm);
		__pFlashForm->registerService(__systemService);

		__ioService = new IOService(__pFlashForm);
		__pFlashForm->registerService(__ioService);
	return true;
}

bool
FlashTest::OnAppTerminating(AppRegistry& appRegistry, bool forcedTermination)
{
	// TODO:
	// Deallocate resources allocated by this application for termination.
	// The application's permanent data and context can be saved via appRegistry.
	return true;
}

void
FlashTest::OnForeground(void)
{
	/*
	bool silentMode;
	SettingInfo::GetValue(L"SilentMode", silentMode);

	if (silentMode){
		if (FlashCppProxy::Utils::Confirm(L"Ton im Lautlos-Modus abspielen?")){
			silentMode = false;
		}
	}
	if (silentMode){
		this->__pFlashForm->volume(0);
	} */
}

void
FlashTest::OnBackground(void)
{
	// The flash content is automatically paused when the application moved to the background.
}

void
FlashTest::OnLowMemory(void)
{
	// TODO:
	// Free unused resources or close the application.
}

void
FlashTest::OnBatteryLevelChanged(BatteryLevel batteryLevel)
{
	// TODO:
	// Handle any changes in battery level here.
	// Stop using multimedia features(camera, mp3 etc.) if the battery level is CRITICAL.
}

void
FlashTest::OnScreenOn (void)
{
	// TODO:
	// Get the released resources or resume the operations that were paused or stopped in OnScreenOff().
}

void
FlashTest::OnScreenOff (void)
{
	// TODO:
	//  Unless there is a strong reason to do otherwise, release resources (such as 3D, media, and sensors) to allow the device to enter the sleep mode to save the battery.
	// Invoking a lengthy asynchronous method within this listener method can be risky, because it is not guaranteed to invoke a callback before the device enters the sleep mode.
	// Similarly, do not perform lengthy operations in this listener method. Any operation must be a quick one.
}
