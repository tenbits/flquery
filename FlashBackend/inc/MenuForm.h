#ifndef _MENUFORM_H_
#define _MENUFORM_H_

#include <FApp.h>
#include <FBase.h>
#include <FUi.h>
#include <FGraphics.h>

#include "FlashForm.h"

class MenuForm :
	public Osp::Ui::Controls::Form,
	public Osp::Ui::IActionEventListener,
	public Osp::Ui::IItemEventListener
{

public:
	static const int ID_MENUFORM_EXIT = 100;
	static const int REQUEST_FLASHFORM_REMOVE = 200;

public:
	MenuForm(void);
	virtual ~MenuForm(void);

	bool Initialize(void);
	bool CreateMainList(void);
	void InitializeList(void);
	FlashForm* GetFlashFormInstance(void);

public:
	virtual result OnInitializing(void);
	virtual result OnTerminating(void);
	virtual void OnActionPerformed(const Osp::Ui::Control& source, int actionId);
	virtual void OnItemStateChanged(const Osp::Ui::Control& source, int index, int itemId, Osp::Ui::ItemStatus status);
	virtual void OnUserEventReceivedN(RequestId requestId, Osp::Base::Collection::IList* pArgs);


public:
	Osp::Ui::Controls::List*	__pList;
	FlashForm*					__pFlashForm;
};

#endif	//_MENUFORM_H_
