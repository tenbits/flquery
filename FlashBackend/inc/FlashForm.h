#ifndef _FLASHFORM_H_
#define _FLASHFORM_H_

#include <FBase.h>
#include <FUi.h>
#include <FGraphics.h>
#include <FSystem.h>

class FlashForm :
	public Osp::Ui::Controls::Form,
	public Osp::Ui::IActionEventListener,
	public Osp::Ui::IFlashEventListener,
	public Osp::Ui::IKeyEventListener,
	public Osp::Ui::ITextEventListener
{

public:
	static const int ID_FLASHFORM_EXIT = 100;
	static const int ID_BUTTON_OK = 200;

public:
	FlashForm(void);
	virtual ~FlashForm(void);

	bool Initialize(Osp::Ui::Controls::Form* pMenuForm, Osp::Base::String& titleText, Osp::Base::String& fileName, Osp::Base::String& fileUrl);
	void CreatePopup(Osp::Base::String popupTitle);
	bool SetFlashProperties(void);
	bool PlayFlash(void);

	virtual result OnInitializing(void);
	virtual result OnTerminating(void);

	virtual void OnActionPerformed(const Osp::Ui::Control& source, int actionId);

	virtual void OnFlashDataReceived(const Osp::Ui::Control &source, const Osp::Base::Collection::IList &paramList);
	virtual void OnFlashDataReturned(const Osp::Ui::Control &source, const Osp::Base::Collection::IList &paramList);
	virtual void OnFlashTextEntered(const Osp::Ui::Control& source, Osp::Ui::FlashTextInputMode inputMode, const Osp::Base::String& defaultText, int limitTextLength);
	virtual void OnFlashLayoutChanged(const Osp::Ui::Control& source, Osp::Ui::FlashLayoutStyle layoutStyle);

	virtual void OnKeyLongPressed (const Osp::Ui::Control &source, Osp::Ui::KeyCode keyCode);
	virtual void OnKeyPressed (const Osp::Ui::Control &source, Osp::Ui::KeyCode keyCode);
	virtual void OnKeyReleased (const Osp::Ui::Control &source, Osp::Ui::KeyCode keyCode);

	virtual void OnTextValueChanged(const Osp::Ui::Control& source);
	virtual void OnTextValueChangeCanceled(const Osp::Ui::Control& source);

public:
	Osp::Ui::Controls::Form*	__pMenuForm;
	Osp::Ui::Controls::Flash*	__pFlash;
	Osp::Ui::Controls::Popup*	__pPopup;
	Osp::Ui::Controls::Button*	__pButton;
	Osp::Ui::Controls::Label*	__pLabel;
	Osp::Ui::Controls::Keypad*	__pKeypad;
	Osp::Base::String			__fileName;
	Osp::Base::String			__fileUrl;
	Osp::Base::String			__oldText;
};

#endif	//_FLASHFORM_H_
