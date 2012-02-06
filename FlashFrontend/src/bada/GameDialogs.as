import bada.dom.widgets.Dialog;
import bada.dom.widgets.View;
import bada.Game;
/**
 * ...
 * @author tenbits
 */
class bada.GameDialogs
{
	
	public static function setup() {
		return;
		Dialog.register('gameOver', {
			_css: {
				width:'70%',
				height:300,
				y:60,
				backgroundColor:0x555555,
				opacity:.9,
				borderRadius:[14, 14, 14, 14],
				border:[5,0x000000,70]
			},
			_children:[{
				tag:'span',
				_text:'Game Over',
				_css: {
					width:'90%',
					y:10,
					color:0xff1010,
					alpha:10,
					fontSize:45,
					autoSize:'center',
					textShadow:0xa0a0a0
				}
			},{
				tag:'button',
				_data: {
					istop:true
				},
				_css: {
					bottom: 100,
					right: 220,
					backgroundImage: 'buttons.btnMenu_small.png'
				},
				handler: {
					touchEnd:function() {
						Dialog.close();
						View.open('viewMenu');
					}
				}
			},{
				tag:'button',
				_data: {
					istop:true
				},
				_css: {
					bottom: 100,
					left: 12,
					backgroundImage: 'buttons.btnNew_small.png'
				},
				handler: {
					touchEnd:function() {
						Dialog.close();
					}
				}
			}]
		});
		
		//Dialog.show('gameOver');
	}
}