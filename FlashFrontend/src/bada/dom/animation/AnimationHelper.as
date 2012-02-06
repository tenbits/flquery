import bada.dom.element.Div;
import bada.dom.element.INode;
import bada.Utils;
import caurina.transitions.Tweener;
/**
 * ...
 * @author ...
 */
class bada.dom.animation.AnimationHelper
{
	
	static function splash(parent:Div, element:INode) {
		parent.append(element);
		
		Tweener.addTween(element.textField, {
			_alpha:100,
			time: .4
		});
		
		Tweener.addTween(element.textField, {
			_alpha: 0,
			time: .5,
			delay: 2,
			onComplete: function() {
				element.remove();
			}
		});		
	}
	
	static function fadeOut(element:INode, time:Object) {
		var movie:MovieClip = element.movie,
		var alpha:Number = movie._alpha;
		
		Tweener.addTween(movie, {
			_alpha: 0,
			time:time,
			onComplete: function () {
				element.toggle(false);
				movie._alpha = alpha;
				element = null;
				movie = null;
			}
		});
	}
	static function fadeIn(element:INode, time:Object) {
		var movie:MovieClip = element.movie,
		alpha = movie._alpha;
		
		movie._alpha = 0;
		element.toggle(true);
		Tweener.addTween(movie, {
			_alpha: alpha,
			time: time
		});
	}
	
	static function load(container:MovieClip, url:String, duration:Number, callback:Function) {
		var depth = container.getNextHighestDepth(),
		id = 'animation-' + depth,
		animation:MovieClip = Utils.createMovieClip(container, id),
		mc: MovieClipLoader = new MovieClipLoader(),
		mclListener: Object = {
			onLoadInit: function($div) {
				Bada.wait(function() {
					animation.removeMovieClip();					
					callback();
				},duration);
				mc = null;				
			},
			onLoadError: function() {
				animation.removeMovieClip();
				callback();
				mc = null;
			}
		};
		container = null;
		mc.addListener(mclListener);
		mc.loadClip(url, animation);
	}
}