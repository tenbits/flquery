/**
 * ...
 * @author tenbits
 */
class bada.SoundController
{
	private static var _sounds:Object;
	private static var _volume:Number = 100;
	
	private static var _current:Sound;
	public static function setup() {
		setup = Bada.doNothing;
		_sounds = {
			//a: create('external/sounds/A.mp3')
			//ready: create('external/ready.mp3')
		};
		
	}
	
	public static function play(id:String) {
		
		if (SoundController._sounds[id] == null) {
			SoundController.create(id,'external/sounds/' + id.toUpperCase() + '.mp3', 
			Function.bind(SoundController.play, SoundController, id));
			return;
		}
		if (SoundController._current != null) {
			SoundController._current.stop();
		}
		
		SoundController._sounds[id].start(0, 1);
		SoundController._current = SoundController._sounds[id];
	}
	
	private static function create(id:String, url:String, callback:Function):Sound {
		var sound:Sound = new Sound();
		SoundController._sounds[id] = sound;
		
		if (callback) sound.onLoad = callback;
		sound.setVolume(_volume);
        sound.loadSound(url, false);
		
		
		return sound;
	}
	
	public static function volumeUp() {
		SoundController._volume += 10;
		if (SoundController._volume > 100) SoundController._volume = 100;
		SoundController.volume(SoundController._volume);
	}
	public static function volumeDown() {
		SoundController._volume -= 10;
		if (SoundController._volume < 0) SoundController._volume = 0;
		SoundController.volume(SoundController._volume);
	}
	
	
	public static function volume(value:Number) {
		var sound:Sound = SoundController._current;
		if (sound == null) {
			for (var key in SoundController._sounds) {
				sound = SoundController._sounds[key];
				break;
			}
		}
		
		Bada.log('setVolume', value);
		sound.setVolume(value);
		
		
	}
	
}