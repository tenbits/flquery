###Bada Flash Container###

----------

RESTFull Flash-C++ bidirectional Communication:

C++: @see https://github.com/tenbits/flquery/blob/master/FlashBackend/inc/FlashCppProxy/IOService.h<br/>
Flash Usage: <br/>
	@code bada.Proxy.service('ioservice', 'file-delete',{path:'/Media/image.png'});<br/>
	@code bada.Proxy.service('ioservice', 'directory-list',{path: '/Media/Videos'}, function(fileList:Array){/**callback function */});

Events:
C++:  @see https://github.com/tenbits/flquery/blob/master/FlashBackend/inc/FlashCppProxy/FlashProxyForm.h method TriggerCommand
	  @code FlashFormPointer->TriggerCommand("gps-changed",Integer::ToString(lat), Integer::ToString(long)); 
Flash: bada.Events.bind('gps-changed', function(lat, long) {/** callback function */});