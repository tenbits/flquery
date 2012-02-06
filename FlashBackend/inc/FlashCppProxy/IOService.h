/*
 * DirectoryService.h
 *
 *  Created on: 02.12.2011
 *      Author: Root
 */

#ifndef DIRECTORYSERVICE_H_
#define DIRECTORYSERVICE_H_

#include <FBase.h>
#include <FIo.h>

#include <FlashCppProxy/FlashProxyForm.h>
#include <FlashCppProxy/Interface/IProxyService.h>
#include <FlashCppProxy/Data/Json.h>


namespace FlashCppProxy {

using namespace Osp::Io;
using namespace Osp::Base::Collection;
using namespace Osp::Base;


class IOService:
	public FlashCppProxy::IProxyService{
private:
	FlashProxyForm * __form;
public:
	IOService(FlashProxyForm * form){
		__form = form;
		this->Name = "ioservice";
	}
	virtual ~IOService(){

	}

	Json* RunN(String method,FlashCppProxy::Data::StringDictionary* params){
			if (method == "directory-list"){


				if (params == null) return null;
				String path = params->GetValue("path");
				AppLog("ioservice.dir-list %S", path.GetPointer());
				Json * json = new Json(ArrayType);

				if (path.Equals(L"", false)){
					String value;
					Osp::System::DeviceManager::GetState(Osp::System::StorageCard, value);

					AppLog("storage size: %S", value.GetPointer());
					if (value.Equals(L"Inserted", false)){
						json->Add("value1", new String("/Media"));
						json->Add("value2", new String("/Storagecard"));
						return json;
					}
					path = "/Media";
				}


				if (path.StartsWith("/Storagecard",0)) {
					path.Replace("/Storagecard","/Storagecard/Media");
				}else{
					if (path.StartsWith("/Media",0) == false) {
						path = "/Media/" + path;
					}
				}

				Directory* pDir= new Directory;
				result r = pDir->Construct(path);
				if(IsFailed(r) == false){
					DirEnumerator* pDirEnum = pDir->ReadN();
					if(pDirEnum != NULL){
						int i = 0;
						while(pDirEnum->MoveNext() == E_SUCCESS)
						{
							DirEntry record = pDirEnum->GetCurrentDirEntry();

							AppLog("Adding Name: %S",record.GetName().GetPointer());
							json->Add("value" + i, new String(record.GetName()));
							i++;
						}
						delete pDirEnum;
					}
				}else{
					AppLog("Dir Construct Failed %S %S", path.GetPointer(), GetErrorMessage(r));
				}
				if (pDir != NULL) delete pDir;


				return json;
			}
			if (method == "file-delete"){
				if (params == null) return null;
				String path = params->GetValue("path");

				File::Remove(path);
			}
			return NULL;
		}
};

}

#endif /* DIRECTORYSERVICE_H_ */
