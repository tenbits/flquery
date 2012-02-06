import bada.dom.element.Div;
import bada.dom.Dom;
import bada.dom.element.INode;

/** cooker utensil selection */
class bada.Selection{
    
    private static var _rotator:Div = null;
    //utensil position in bada.CookerWidgets.cooker
    public static var position:Number;
    
    public static function select(pos:Number,x:Number,y:Number):Void{
        if (_rotator == null){
            _rotator = new Div(Dom.get('viewMain'),{
                _id:'divRotator',
                _css:{
                    x:x+62,
                    y:y+62,
                    backgroundImage:'external/800/selection.png',
                    backgroundPosition:[-62,-62]
                }
            });
        }
        else
        {
            _rotator.toggle(true).css( {
				x:x + 62,
				y:y + 62
			});
        }
        
        position = pos;
        rotate();
    }
    
    public static function deselect(){
        if (position != null){
            position = null;
            caurina.transitions.Tweener.removeTweens(_rotator.movie);
            _rotator.animate(false).toggle(false);
        }
    }
    
    private static function rotate(){
        caurina.transitions.Tweener.addTween(_rotator.movie,{
           _rotation:2880,
           time:16,
           transition:'linear',
           onComplete: rotate
        });
    }
    
}