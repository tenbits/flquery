import bada.dom.LocalStorage;
/**
 * abstract class 
 * @author tenbits
 */
class bada.Settings
{	
	public static var Instance:Settings;	
	public function Settings() 
	{
		Instance = this;
	}
	
	public function save(settings) {
		LocalStorage.set('settings', settings);
	}
	
	public function restore(callback:Function) {
		LocalStorage.get('settings', function(data) {
			if (data == null) {
				callback();
				return;
			}			
			this.applySettings(data);
			callback();
		}.bind(this));
	}
	
	/** abstract */
	public function applySettings(settings:Object){}
}