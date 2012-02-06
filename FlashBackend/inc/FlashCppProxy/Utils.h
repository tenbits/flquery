#ifndef FLASHCPPUTILS_H_
#define FLASHCPPUTILS_H_

#include <FBase.h>
#include <FUi.h>
#include <FGraphics.h>
#include <FApp.h>
#include <FMedia.h>
#include <FIo.h>
#include <FSystem.h>
#include <FContent.h>

using namespace Osp::Base;
using namespace Osp::Ui::Controls;
using namespace Osp::Graphics;
using namespace Osp::App;
using namespace Osp::Media;

namespace FlashCppProxy{
	class Utils{
		private:
		static Dimension __dimension;
		static String adaptResPath(String bigDevicePath){
				if (IsSmallDevice()){
					bigDevicePath.Replace("/800/","/400/");
					return bigDevicePath;
				}
				return bigDevicePath;
			}
		static Dimension& GetScreenSize(){
			if (__dimension.width == 0){
				Frame* frame = Osp::App::Application::GetInstance()->GetAppFrame()->GetFrame();
				__dimension = frame->GetSize();
			}
			return __dimension;
		}

		public:
		static bool Confirm(String message){
				MessageBox messageBox;
			    messageBox.Construct("", message, MSGBOX_STYLE_OKCANCEL);
			    int modalResult = 0;
			    messageBox.ShowAndWait(modalResult);
			    return modalResult == MSGBOX_RESULT_OK;
		}

		static void Alert(String message){
			if (message == "") return ;

			MessageBox messageBox;
			messageBox.Construct("", message, MSGBOX_STYLE_OK);
			int m;
			messageBox.ShowAndWait(m);
		}

		static bool IsSmallDevice(){
			Dimension& dim = GetScreenSize();

			return dim.width * dim.height < 800 * 480;
		}

		static Bitmap * LoadBitmapN(String path){
			path = adaptResPath(path);

			AppLog("path %S", path.GetPointer());
			Image* image = new Image;
			image->Construct();

			AppLog("before decode");
			Bitmap* bmp= image->DecodeN(path, BITMAP_PIXEL_FORMAT_ARGB8888);
			AppLog("after decode");
			if (bmp == NULL){
				AppLog("bmp is null");
				delete image;
				return NULL;
			}

			delete image;
			return bmp;
		}

		static String prepairLauncher(){
			String value;
			Osp::System::DeviceManager::GetState(Osp::System::StorageCard, value);

			if (value.Equals("Inserted", false) == false)
				return "/Res/main.swf";

			Osp::Content::ContentType type;
			type = Osp::Content::ContentManagerUtil::CheckContentType(L"/Storagecard/Media/flvplayer-launcher.swf");



			if (Osp::Io::File::IsFileExist(L"/Storagecard/Media/flvplayer-launcher.swf")){
				//return L"/Storagecard/Media/flvplayer-launcher.swf";
				bool value = DeleteFileInMediaFolder(L"/Storagecard/Media/flvplayer-launcher.swf");
				AppLog("Exists deleted %S", value ? "YES" : "NO");
			}


			result r = Osp::Content::ContentManagerUtil::CopyToMediaDirectory(L"/Res/flvplayer-launcher.swf",L"/Storagecard/Media/flvplayer-launcher.swf");
			if (IsFailed(r) && r != E_FILE_ALREADY_EXIST){
				AppLog("Launcher copy failed %S", GetErrorMessage(r));
				return L"/Res/main.swf";
			}
			return L"/Storagecard/Media/flvplayer-launcher.swf";
		}

		static bool DeleteFileInMediaFolder(String strFilePath)
		{
		  if(!Osp::Io::File::IsFileExist(strFilePath)) return true;

		    Osp::Content::ContentManager contentManager;
		    Osp::Content::ContentId contentId;
		    result r = contentManager.Construct();
		    if(IsFailed(r))
		    {
		      AppLog(GetErrorMessage(r));
		      return false;
		    }

		    // create
		    Osp::Content::OtherContentInfo contentInfo;
		    r = contentInfo.Construct(strFilePath);
		    if(IsFailed(r))
		    {
		      AppLog(GetErrorMessage(r));
		      return false;
		    }

		    contentId = contentManager.CreateContent(contentInfo);
		    if (Osp::Base::UuId::INVALID_UUID != contentId)
		    {
		      r = contentManager.DeleteContent(contentId);
		        if(IsFailed(r))
		        {
		          AppLog(GetErrorMessage(r));
		          return false;
		        }
		    }
		    return true;
		}
	};


}


#endif
