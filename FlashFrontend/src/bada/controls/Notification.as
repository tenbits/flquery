class bada.controls.Notification{
    
    private static
    var $panel:bada.dom.element.Div;
    private static
    var $text:bada.dom.element.Span;
    
    private static
    var hideTimeout:Number;
    
    public static function setup(){
        $panel = new bada.dom.element.Div(bada.dom.Dom.body,{
            _css:{
                width:500,
                height:50,
                x: 150,
                y:-70,
                backgroundColor:0x000000,
                opacity:.9,
                alpha:50,
                borderRadius:[0,0,12,12]
            },
            _children:[{
                tag:'span',
                _name:'text',
                _text:'',
                _css:{
                    alpha:30,
                    fontSize:30,
                    width:500,
                    height:100,
                    autoSize:'center',
                    color:0xfafafa
                }
            }]
        });
        $text = $panel.first('text').asSpan();
    }
    
    public static function show(message:String){
        $text.text(message);
        if (hideTimeout){
            clearTimeout(hideTimeout);
            hideTimeout = setTimeout(hide,3000);
            return;
        }
        hideTimeout = setTimeout(hide,3000);
        $panel.animate({
            y:0,
            time:.3,
            transition:'linear'
        });
    }
    
    public static function hide(){
        bada.controls.Notification.hideTimeout = null;
        bada.controls.Notification.$panel.animate({
            y:-70,
            time:.5
        });
    }
}