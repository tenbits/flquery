import bada.dom.CSS;
import bada.dom.element.Div;
import bada.dom.Dom;
import bada.dom.element.INode;
import caurina.transitions.Tweener;
import flash.display.BitmapData;
class bada.dom.widgets.View extends bada.dom.element.Div {
    
	private static var _views: Object = { };
	private static var _stack:Array = [];
	private static var _lastId:String;
	
    public static var _currentId: String = null;
	private static var transitions:Object;
	
	public static function setupMain(id:String):View {
		_currentId = id;		
		_views[id].x = 0;
		return _views[id];
	}

    private function View(parent: Div, data: Object) {
		data._css.width = Bada.screen.width;
		data._css.height = Bada.screen.height;		
		data._css.x = data.main ? 0 : Bada.screen.width;		
		super.init.apply(this, arguments);
		_views[data._id] = this;
    }
	
    public function activate():Void{
        
    }
    public function deactivate():Void{
        
    }

    static function open(id: String):Boolean {
		if (_views[id] == null) {
			Bada.log('Error # view undefined:', id);
			return false;
		}
		
	  if (id != _currentId) {
            var X = _views[id]._movie._x > 0 ? Bada.screen.width * -1 : Bada.screen.width
            _views[_currentId].deactivate();
			
			var args = Array.prototype.slice.call(arguments);
			args.shift();
			args.shift();
			_views[id].activate.apply(_views[id], args);
			
			if (Bada.smallscreen) {
				_views[_currentId].toggle(false);
				_views[id].css({
					x:0,
					y:0,
					visible:true
				});
				
				if (arguments[1] == 'next') {
					_lastId = _currentId
				}
				
			}else{			
				switch(arguments[1]) {
					case 'next':
						transitionForward(_views[_currentId], _views[id]);
						_lastId = _currentId;
						break;
					case 'back':
						transitionBackward(_views[_currentId], _views[id]);
						break;
					default:
						transition(_views[_currentId], _views[id]);
						break;
				}
			}
            _currentId = id;
			return true;
        }
		return false;
    }
    
	
	private static function transition($hide:View, $show:View){
		if (transitions == null) createPanels();
		/*
		var $transition = _root['transition'];
		if ($transition == null){
			$transition = bada.Utils.createMovieClip(_root,'transition',{
				width:Bada.screen.width,
				height:Bada.screen.height
			});
		
			bada.Utils.createMovieClip($transition,'hide',{
				width:Bada.screen.width,
				height:Bada.screen.height
			});
			bada.Utils.createMovieClip($transition,'show',{
				width:Bada.screen.width,
				height:Bada.screen.height
			});
			
			
		}*/
		
		View.cloneCanvas(transitions.hide, $hide.movie);
		View.cloneCanvas(transitions.show, $show.movie);
	  
		$hide.toggle(false);
		$show.toggle(false);
		
		transitions.show.ztop().toggle(true).css( {
			xscale:0,
			x: Bada.screen.width / 2
		});		
		transitions.hide.ztop().toggle(true).css( {
			xscale: 100,
			x: 0
		});
		
		
		
	   
		
		Tweener.addTween(transitions.hide.movie,{
			_xscale:0,
			_x:Bada.screen.width / 2,
			transition:'linear',
			time:.2
			
		});
		Tweener.addTween(transitions.show.movie,{
			_xscale:100,
			_x:0,
			
			time:.2,
			delay:.2,
			transition:'linear',
			onComplete:function(){			
				$show.css({
					x:0,
					y:0,
					visible:true
				});
				
				View.transitions.hide.toggle(false);
				View.transitions.show.toggle(false);
			}
		});
	}
	
	private static function transitionForward($hide:View, $show:View) {
		if (transitions == null) createPanels();
		
		View.cloneCanvas(transitions.hide, $hide.movie);
		View.cloneCanvas(transitions.show, $show.movie);
	  
		$hide.toggle(false);
		$show.toggle(false);
		
		transitions.hide.ztop();
		
		transitions.show.css({
			scale:50,
			alpha:100,
			visible:true
		});
		
		transitions.hide.css({
			visible:true,
			scale:100,
			alpha:80
		});
		
		
		Tweener.addTween(transitions.hide,{
			scale:150,
			opacity:20,
			time:.4,
			transition:'linear'
		});
		Tweener.addTween(transitions.show,{
			scale:100,
			time:.4,
			transition:'linear',
			onComplete:function() {
				$show.css({
					x:0,
					y:0,
					visible:true
				});
				View.transitions.hide.css('visible', false);
				View.transitions.show.css('visible',false);
			}
		});
	}
	
	private static function transitionBackward($hide:View, $show:View) {
		
		if (transitions == null) createPanels();
		
		View.cloneCanvas(transitions.hide, $hide.movie);
		View.cloneCanvas(transitions.show, $show.movie);
	  
		$hide.toggle(false);
		$show.toggle(false);
		
		transitions.show.ztop();
		transitions.show.css({
			scale:150,
			alpha:30,
			visible:true
		});
		transitions.hide.css( {
			visible: true,
			scale: 100
		});
		
		
		Tweener.addTween(transitions.hide,{
			scale:50,
			time:.4,
			transition:'linear'
		});
		Tweener.addTween(transitions.show,{
			scale:100,
			opacity:100,
			time:.4,
			transition:'linear',
			onComplete:function() {
				$show.css({
					x:0,
					y:0,
					visible:true
				});
				
				View.transitions.hide.css('visible', false);
				View.transitions.show.css('visible',false);
			}
		});
	}
	
	private static function createPanels() {
		createPanels = Bada.doNothing;
		
		Dom.body.append([
			{
				_id: 'transitionHide',
				_css: {
					width:Bada.screen.width,
					height:Bada.screen.height,
					x:0,
					y:0
				}
			},
			{
				_id:'transitionShow',
				_css: {
					width: Bada.screen.width,
					height:Bada.screen.height,
					x:0,
					y:0
				}	
			}
		]);
		
		transitions = {
			hide: Dom.body.first('#transitionHide'),
			show: Dom.body.first('#transitionShow')
		};
	}
	
	private static function cloneCanvas(node:INode, source:MovieClip):BitmapData {
		node.empty();
		
		var target:MovieClip = node.movie;
		
		node._canvas = new BitmapData(Bada.screen.width, Bada.screen.height);
		node._canvas.draw(source);
		
		target.clear();
		target.beginBitmapFill(node._canvas);
		target.moveTo(0,0);
		target.lineTo(0,0);
		target.lineTo(Bada.screen.width,0);
		target.lineTo(Bada.screen.width,Bada.screen.height);
		target.lineTo(0,Bada.screen.height);
		target.lineTo(0,0);
		target.endFill();
		
		return node._canvas;
	}
	
	private static function back() {
		if (View._lastId != null) {
			View.open(View._lastId, 'back');
			View._lastId = null;
		}
	}
}