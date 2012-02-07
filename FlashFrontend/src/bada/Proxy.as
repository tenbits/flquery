import bada.dom.Dom;
//import flash.events;
class bada.Proxy{
    
    //private static var callback:Function = null;
    private static var $confirm:MovieClip = null;
   
    public static function setupDialogs():Void {
		Dom.body.append( {
			_id:'confirmDialog',
			_css: {
				width:480,
				height:800,
				backgroundColor:0x000000,
				opacity:.8,
				backgroundImage:'framework.popup_black.png',
				backgroundPosition:[15, 100],
				display:'none'
			},
			_children:[ {
				tag:'span',
				_name:'text',
				_css: {
					width:430,
					height:130,
					x:25,
					y: 120,
					autoSize:'center',
					textAlign:'center',
					fontSize: 25,
					color:0xf3f3f3
					}
			},{
				tag:'button',
				_css: {
					width: 180,
					height:65,
					x: 30,
					y: (280 + 100),
					backgroundImage:'framework.btn_yes.png'
				},
				handler: {
					touchEnd:function() {
						if (Proxy.callback) Proxy.callback(1);
						Dom.body.first('#confirmDialog').toggle(false);
					}
				}
			},{
				tag:'button',
				_css: {
					width: 180,
					height:65,
					x: 480 - 30 - 180,
					y: (280 + 100),
					backgroundImage:'framework.btn_no.png'
				},
				handler: {
					touchEnd:function() {
						if (Proxy.callback) Proxy.callback(0);
						Dom.body.first('#confirmDialog').toggle(false);
					}
				}
			}]
		});
        
    }
	
	public static function confirm(text:String, callback:Function):Void {
		if (Bada.isFlashLite() == false){
			Proxy.setupDialogs();
			Proxy.confirm = function(_text:String, _callback:Function){
				Proxy.callback = _callback;
				Dom.body.first('#confirmDialog').ztop().toggle(true).first('text').asSpan().text(_text);
			}
			Proxy.confirm(text, callback);
		}else {
			Proxy.callback = callback;
			FSCommand2('Set','Confirm', text);
		}
	}
	
	public static function alert(message:String):Void {
		if (Bada.isFlashLite() == false){
			Proxy.setupDialogs();
			Proxy.alert = function(_text:String){
				Dom.body.first('#confirmDialog').ztop().toggle(true).first('text').asSpan().text(_text);
			}
			Proxy.confirm(message);
		}else {
			Proxy.service('system', 'alert', {
				message: message
			});
		}
	}
	
	/**
	 * fscommand2('Set',service, data);
	 * @param data key=value
	 */
	public static function post(service:String, method:String, data:String, callback:Function ):Void {
		_global.cppPost(service, method);
	}
	
	/**
	 * fscommand2('Get',service, data);
	 */
	public static function get(service:String, method:String, data:String, callback:Function ):Void {
		_global.cppGet(service, method, data, callback);
	}
	
	public static function service(service:String, method:String, data:Object, callback:Function):Void {
		var array:Array = [];
		if (typeof data === 'object') {
			for (var key in data) {
				array.push(key +'=' + data[key]);
			}
		}
		Bada.log('sending', service, method, array.join('&'));
		
		if (Bada.isFlashLite() == false) {
			callback(); /* simulate callback */
		}
		else {
			_global.cppPost(service, method, array.join('&'), callback);
		}
	}
	
	
	private static var callback:Function;
	private static var requestid:Number;
	private static var serviceCallbacks:Object = { };
	static function setup() {
		Proxy.requestid = 1;
		_global.onConfirmListener = new Object();
		_global.onConfirmListener.onEvent = function(answer) {		 	
				if (Proxy.callback) Proxy.callback(answer == 1 ? true : false);
		};
		_global.ExtendedEvents.ConfirmHandler.addListener(_global.onConfirmListener)
		
		_global.onCommandListener = new Object();
		_global.onCommandListener.onEvent = function() {		
				bada.Events.trigger.apply(bada.Events, arguments);
		};
		_global.ExtendedEvents.CommandHandler.addListener(_global.onCommandListener);
		 
		_global.onServiceListener = new Object();
		_global.onServiceListener.onEvent = function() {						
			var args = Array.prototype.slice.call(arguments),
			req_id = args.shift();
			
			if (Proxy.serviceCallbacks[req_id]){
				Proxy.serviceCallbacks[req_id].apply(this, args);
				delete Proxy.serviceCallbacks[req_id];
			}				
		 };
		 _global.ExtendedEvents.ServiceHandler.addListener(_global.onServiceListener);
		
		_global.alert = function(message:String):Void{
			setTimeout(function(){
					FSCommand2('Set','Alert',message);    
				},0);
		}
		
		
		_global.deviceTrace = function(message:String):Void{
			FSCommand2('Set','Trace',message);
		}
		
		
		_global.cppPost = function(service:String, method:String, data:String, _callback:Function):Void{
			if (data == null || data.length == 0) data = 'requestid=' + (++Proxy.requestid);
			else data += '&requestid=' + (++Proxy.requestid);
			
			if (_callback) Proxy.serviceCallbacks[Proxy.requestid] = _callback;
			FSCommand2('Set',service, method, data);
		}
		_global.cppGet = function(service, method:String, data:String, _callback:Function):Void{
			var response;
			FSCommand2('Get',service, method, data, response);
			_callback(response);
		}
		
		_global.resolveLocalStorage = function(callback:Function){
			_root.deviceTrace('resolve storage');
			
			_global.onload = function(){
			 _root.deviceTrace('RESOLVED 0');
			   callback(arguments[0]);
		   }
			SharedObject['addListener']('localStorage', _global.onload);
			  var so = SharedObject.getLocal('localStorage');
			  so.path = this; 
			  //_root.deviceTrace('resolve storage' + so + so.data);
			  //callback(so);
			  
			  
		}
	}

}