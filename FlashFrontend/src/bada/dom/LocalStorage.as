/**
 * ...
 * @author tenbits
 */
class bada.dom.LocalStorage
{
	private static var _localStorage:SharedObject;
	private static var _deferred:Array = [];
	private static function resolve() {
		LocalStorage.resolve = Bada.doNothing;
		
		if (Bada.isFlashLite()){
			_global.resolveLocalStorage(function(db:SharedObject) {
				
				var keys = '';
				for (var key in db.data) {
					keys += key + ',';
				}
				Bada.log('RESOLVED', keys);
				LocalStorage._localStorage = db;
				for (var i = 0; i < LocalStorage._deferred.length; i++) {
					LocalStorage._deferred[i]();
				}
				LocalStorage._deferred.splice(0);
				LocalStorage._deferred = null;
			
			});
		}else {
			_localStorage = SharedObject.getLocal('localStorage');
			for (var i = 0; i < LocalStorage._deferred.length; i++) {
				LocalStorage._deferred[i]();
			}
			LocalStorage._deferred.splice(0);
			LocalStorage._deferred = null;
		}
	}
	public static function set(key:String, value:Object) 
	{
		if (_localStorage == null) {
			_deferred.push(Function.bind(LocalStorage.set, LocalStorage, key, value));
			LocalStorage.resolve();
			return;
		}
		
		//_root.resolveLocalStorage(function(db:SharedObject) {
			LocalStorage._localStorage.data[key] = value;
			LocalStorage._localStorage.flush();
			//Bada.log('localstorage saved');
		//});
	}
	
	public static function get(key:String, callback:Function) {
		if (_localStorage == null) {
			_deferred.push(Function.bind(LocalStorage.get, LocalStorage, key, callback));
			Bada.log('GLOBAL', _global, _global.resolveLocalStorage);
			Bada.log('ROOT', _root, _root.saveStorage);
			
			LocalStorage.resolve();
			return;
		}
		callback(LocalStorage._localStorage.data[key]);
		/*_root.resolveLocalStorage(function(db:SharedObject) {
			callback(db.data[key]);
		});*/
	}
	
	public static function clear() {
		if (_localStorage == null) {
			_deferred.push(Function.bind(LocalStorage.clear, LocalStorage));
			LocalStorage.resolve();
			return;
		}
		LocalStorage._localStorage.clear();
		LocalStorage._localStorage.flush();		
		
		/*_root.resolveLocalStorage(function(db:SharedObject) {
			Bada.log('CLEAR STORAGE EMPTY');
			db.clear();
			db.flush();		
		});*/
		
	}
	
}