import bada.dom.events.EventManager;
class bada.Events {
    private static var callbacks = new Object();

    public static function bind(action: String, callback: Function) : Void {
        if (callbacks[action] == null) callbacks[action] = [];
        callbacks[action].push(callback);
    };

    public static function trigger() : Void {
		var args = Array.prototype.slice.call(arguments),
        action = args.shift();
        
        if (typeof callbacks[action] != undefined) {
            for (var item, i = 0; item = callbacks[action][i], i < callbacks[action].length; i++) {
                item.apply(_root, args);
            }
        }
    };
    
    public static function unbind(action: String, callback: Function) : Void {
        if (typeof callbacks[action] != undefined) {
            for (var item, i = 0; item = callbacks[action][i], i < callbacks[action].length; i++) {
                if (item == callback) {
                    callbacks.splice(i, 1);
                }
            }
        }
    };
    
}