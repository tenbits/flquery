/*
 * MultiTouch.h
 *
 *  Created on: 20.01.2012
 *      Author: tenbits
 */

#ifndef FLASHMULTITOUCH_H_
#define FLASHMULTITOUCH_H_

#include <FUi.h>
#include <FGraphics.h>
#include <FBase.h>
#include <FlashCppProxy/FlashProxyForm.h>


namespace FlashCppProxy {
	using namespace Osp::Base;
	using namespace Osp::Ui;
	using namespace Osp::Ui::Controls;
	using namespace Osp::Graphics;
	using namespace Osp::Base::Collection;

	class MultiTouch:
		public Osp::Ui::ITouchEventListener{
	private:
		Flash * __flashControl;
		//FlashCppProxy::FlashProxyForm * __proxyForm;
	public:

		MultiTouch(Flash * flash){
			//this->__flashControl = flash;
			//this->__proxyForm = flash;
			this->__flashControl = flash; //FlashProxyForm::Instance->GetFormStyle();//flash->getFlashInstance();

			Osp::Ui::Touch touch;
			touch.SetMultipointEnabled(*this->__flashControl, true);

			this->__flashControl->AddTouchEventListener(*this);
		}
		virtual ~MultiTouch(){

		}


		void OnTouchPressed(const Control& source, const Point& currentPosition, const TouchEventInfo & touchInfo){
			this->sendEvent("touchStart", touchInfo.GetCurrentPosition());
			//this->__proxyForm->TriggerCommand("multitouch", Integer::ToString(point.x), Integer::ToString(point.y));
			//FlashProxyForm::Instance->TriggerCommand("multitouch", Integer::ToString(point.x), Integer::ToString(point.y));
		}
		void OnTouchLongPressed(const Control& source, const Point& currentPosition, const TouchEventInfo& touchInfo){

		}
		void OnTouchReleased(const Control& source, const Point& currentPosition, const TouchEventInfo& touchInfo){
			this->sendEvent("touchEnd", touchInfo.GetCurrentPosition());
		}
		void OnTouchMoved(const Control& source, const Point& currentPosition, const TouchEventInfo& touchInfo){

		}
		void OnTouchDoublePressed(const Control& source, const Point& currentPosition, const TouchEventInfo& touchInfo){

		}
		void OnTouchFocusIn(const Control& source, const Point& currentPosition, const TouchEventInfo& touchInfo){

		}
		void OnTouchFocusOut(const Control& source, const Point& currentPosition, const TouchEventInfo& touchInfo){

		}

		void sendEvent(String type, Point point){
			ArrayList  dataList;
			dataList.Construct();

			String event = L"multitouch";
			Integer x = point.x;
			Integer y = point.y;

			String _x = x.ToString();
			String _y = y.ToString();
			dataList.Add(event);
			dataList.Add(type);
			dataList.Add(_x);
			dataList.Add(_y);

			this->__flashControl->SendDataEventToActionScript("CommandHandler",dataList);
		}
	};

}

#endif /* FLASHMULTITOUCH_H_ */
