#ifndef _FLASHTEST_H_
#define _FLASHTEST_H_

#include <FApp.h>
#include <FBase.h>
#include <FSystem.h>
#include <FUi.h>

#include "FlashCppProxy/FlashProxyForm.h"
#include "FlashCppProxy/SystemService.h"
#include "FlashCppProxy/IOService.h"
#include "FlashForm.h"
#include "MenuForm.h"
/**
 * [FlashBasedApp] application must inherit from Application class
 * which provides basic features necessary to define an application.
 */
class FlashTest :
      public Osp::App::Application,
      public Osp::System::IScreenEventListener,
      public IKeyEventListener
{

private:
       FlashCppProxy::FlashProxyForm * __pFlashForm;
       FlashForm * __pFlashForm2;
       MenuForm* __pMenuForm;
       FlashCppProxy::SystemService * __systemService;
       FlashCppProxy::IOService * __ioService;
public:

      /**
       * [FlashBasedApp] application must have a factory method that creates an instance of itself.
       */
      static Osp::App::Application* CreateInstance(void);

		FlashTest();
		~FlashTest();

      // Called when the application is initializing.
      bool OnAppInitializing(Osp::App::AppRegistry& appRegistry);

      // Called when the application is terminating.
      bool OnAppTerminating(Osp::App::AppRegistry& appRegistry, bool forcedTermination = false);


      // Called when the application's frame moves to the top of the screen.
      void OnForeground(void);


      // Called when this application's frame is moved from top of the screen to the background.
      void OnBackground(void);

      // Called when the system memory is not sufficient to run the application any further.
      void OnLowMemory(void);

      // Called when the battery level changes.
      void OnBatteryLevelChanged(Osp::System::BatteryLevel batteryLevel);

      // Called when the screen turns on.
      void OnScreenOn (void);

      // Called when the screen turns off.
      void OnScreenOff (void);



      void OnKeyPressed(const Osp::Ui::Control& source, Osp::Ui::KeyCode keyCode){
		    switch(keyCode){
				case KEY_SIDE_UP:
					__pFlashForm->volumeUp();
					break;
				case KEY_SIDE_DOWN:
					__pFlashForm->volumeDown();
					break;
				default:
					break;
			}

      }
      void OnKeyReleased(const Osp::Ui::Control& source, Osp::Ui::KeyCode keyCode){

      }
      void OnKeyLongPressed(const Osp::Ui::Control& source, Osp::Ui::KeyCode keyCode){

      }


};

#endif

