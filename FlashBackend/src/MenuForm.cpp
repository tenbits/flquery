#include "MenuForm.h"

using namespace Osp::App;
using namespace Osp::Base;
using namespace Osp::Base::Collection;
using namespace Osp::Ui;
using namespace Osp::Ui::Controls;
using namespace Osp::Graphics;

MenuForm::MenuForm(void)
	:	__pList(null),
		__pFlashForm(null)
{
}

MenuForm::~MenuForm(void)
{
}

bool
MenuForm::Initialize(void)
{
	Construct(FORM_STYLE_NORMAL | FORM_STYLE_TITLE | FORM_STYLE_INDICATOR | FORM_STYLE_SOFTKEY_1);
	SetTitleText(L"Flash Control");

	SetSoftkeyText(SOFTKEY_1, L"Exit");
	SetSoftkeyActionId(SOFTKEY_1, ID_MENUFORM_EXIT);
	AddSoftkeyActionListener( SOFTKEY_1, *this);

	return true;
}

result
MenuForm::OnInitializing(void)
{
	if(!CreateMainList())
		return false;

	InitializeList();

	return E_SUCCESS;
}

result
MenuForm::OnTerminating(void)
{
	result r = E_SUCCESS;

	return r;
}

bool
MenuForm::CreateMainList(void)
{
	__pList = new List();
	__pList->Construct(Rectangle(0,0,GetClientAreaBounds().width, GetClientAreaBounds().height)
												, LIST_STYLE_NORMAL, LIST_ITEM_SINGLE_TEXT, 100, 0, 450, 0);
	__pList->AddItemEventListener(*this);
	AddControl(*__pList);

	return true;
}

void
MenuForm::InitializeList(void)
{
	String itemText[5] = {
			L"1. Animation",
			L"2. Interaction (MMI)",
			L"3. Video (local FLV)",
			L"4. Input Text",
			L"5. Screen Layout"
	};

	for(int i=0; i<5; i++)
	{
		__pList->AddItem(&itemText[i], null, null, null);
	}
}

void
MenuForm::OnActionPerformed(const Osp::Ui::Control& source, int actionId)
{
	switch(actionId)
	{
	case ID_MENUFORM_EXIT:
		Osp::App::Application::GetInstance()->Terminate();
		break;
	default:
		break;
	}
}

void
MenuForm::OnItemStateChanged(const Osp::Ui::Control& source, int index, int itemId, Osp::Ui::ItemStatus status)
{
	String fileName, fileUrl;
	String titleText;
	bool result;
	Frame* pFrame = static_cast<Frame*>(GetParent());

	switch (index)
	{
	case 0: // Flash Animation(vector graphics)
		titleText.Append(L"Flash Animation");
		fileName.Append(L"/Res/Bada.swf");
		break;
	case 1: // Flash UI (MMI)
		titleText.Append(L"Flash Interaction(MMI)");
		fileName.Append(L"/Res/FlashUi.swf");
		break;
	case 2:	// Flash video (local play)
		titleText.Append(L"Flash Video(Local FLV)");
		fileName.Append(L"/Res/LocalFlv.swf");
		break;
	case 3:	// Flash Input Text
		titleText.Append(L"Flash InputText");
		fileName.Append(L"/Res/Input_Text.swf");
		break;
	case 4:	// Flash Screen Layout
		titleText.Append(L"Flash Layout Control");
		fileName.Append(L"/Res/ScreenLayout.swf");
		break;
/*
 *	case 5: // Flash video (remote streaming play from server)
 * 		fileName.Append(L"/Res/{Flash Contents File}");
 *		fileUrl.Append(L"http://{Server URL}/{Flash Contents File}");
 *		break;
 *	case 6: // Load remote image
 *		fileName.Append(L"/Res/{Image File}");
 *		break;
 */
	default:
		break;
	}

	__pFlashForm = new FlashForm();

	result = __pFlashForm->Initialize(this, titleText, fileName, fileUrl);
	if(result == false)
	{
		AppLog("Failed to initialize the FlashForm.");
		delete __pFlashForm;
		__pFlashForm = null;
		return;
	}

	pFrame->AddControl(*__pFlashForm);
	pFrame->SetCurrentForm(*__pFlashForm);
}

void
MenuForm::OnUserEventReceivedN(RequestId requestId, Osp::Base::Collection::IList* pArgs)
{
	Frame* pFrame = static_cast<Frame*>(GetParent());

    if(requestId == REQUEST_FLASHFORM_REMOVE)
    {
		pFrame->RemoveControl(*__pFlashForm);
		__pFlashForm = null;
    }
}


FlashForm*
MenuForm::GetFlashFormInstance()
{
	return __pFlashForm;
}
