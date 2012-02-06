import bada.dom.element.Div;
import bada.dom.element.INode;
class bada.dom.widgets.TabControl extends Div {

    private
    var _header: Div = null;
    private
    var _content: Div = null;

    public
    var currentId: Number = 0;
    function TabControl(parent: Div, data: Object) {
        super(parent, data);

        var width = data._css.width,
        height = data._css.height,
        headerHeight = data._css.headerHeight || 50,
        contentHeight = height - headerHeight;
	
        _header = new Div(Div(this), {
            _name: 'header',
            _css: {
                width: width,
                height: headerHeight
            }
        });
        _content = new Div(Div(this), {
            _css: {
                width: width,
                height: contentHeight,
                y: headerHeight
            }
        });

        var x = 0;
        for (var i = 0,
        length = data.tabs.length,
        item; item = data.tabs[i], i < length; i++) {

            var tabItem = (_header.append({
                _name: 'tab-' + i,
                _css: {
                    x: x,
                    y: 0,
                    height: headerHeight,
                    width: width / length
                },
                handler: {
                    touchEnd: Function.bind(onHeaderClicked, this)
                }
            })).first('tab-' + i);

            if (item.image) {
                tabItem.data('image', item.image);
                
                tabItem.append([{
                    _css:{
                        backgroundImage: item.image + '.png'
                    }
                },{
                    _name:'selected',
                    _css:{
                        backgroundImage: item.image + '-selected.png',
                        visible: i == 0
                    }
                }]);

                //tabItem.css('backgroundImage', item.image + (i == 0 ? '-selected.png': '.png'));
            }
            if (item.caption) {
                tabItem.append({
                    tag: 'span',
                    _css: {
                        height: headerHeight,
                        width: width / length,
                        autoSize: 'center'
                    },
                    _text: item.caption
                });
            }

            x += width / length;
            
            _content.append({
                _name: 'content-tab-' + i,
                _css: {
                    width: width,
                    height: contentHeight,
                    display: i > 0 ? 'none': 'block'
                    //,backgroundColor: 0xffffff - 100 * i
                }
            });
        }

        
    }

    public function getPanel(i: Number) : Div {
        return Div(_content.first('content-tab-' + i));
    }

    private function onHeaderClicked($node: Div) {

        var id = parseInt($node._name.substr( - 1));
        if (currentId == id) return;

        _header.first('tab-' + currentId).first('selected').css('visible',false);
        $node.first('selected').css('visible',true);
        
        currentId = id;
        
        _content.children().eval('toggle', false);
        var active:INode = _content.first('content-tab-' + currentId).toggle(true);

    }

}