import bada.dom.CSS;
import bada.dom.element.Div;
import bada.dom.helper.XmlParser;
import bada.dom.element.Span;
import bada.dom.widgets.BadaMenu;
import bada.dom.widgets.View;
import bada.Helper;

/**
 * ...
 * @author tenbits
 */
class bada.views.InfoView extends View
{
	
	public function InfoView(parent: Div, data: Object) 
	{
		super(parent, data);
	}
	
	
	public function activate() {
		activate = Bada.doNothing;
		
		this.css('padding', 50);
		
		var container:Div = (new Div( {_name:'infoScroller',_css:{
			x:30,
			y:120,
			width:420,
			height:580,//650,
			backgroundGradient: {
				colors: [0x555555, 0x333333, 0x111111],
				ratios: [0, 50, 255],
				radius: Math.PI / 2,
				alphas: [90,90,90]
			},
			borderRadius:12,
			border: [2,0xffffff,70],
			padding:[10, 10, 10, 10],
			overflow:'scroll'
		}}))
		.appendTo(this)
		.append([
			/*new Span('Denkreactor',{
				position:'static',
				color:0xffffff,
				autoSize:true,
				fontSize:40
			}),*/
			new Span('Version 1.0',{
				position: 'static',
				color:0xffffff,
				autoSize:true,
				fontSize:20,
				fontFamily:''
			}),
			new Span('Appsfactory - a division of<br>Smartrunner GmbH', {
				position:'static',
				color:0xffffff,
				autoSize:true,
				marginTop:20,
				fontSize:23	,
				fontFamily:''			
			}),
			new Span(['Harkortsraße 7',
						'04107 Leipzig',
						'Deutschland',
						'Telefon: +49 (0)341 247 93 03',
						'Fax: +49 (0)341 247 32 82',
						'E-Mail: info@appsfactory.de',
						'Internet: http://www.appsfactory.de'].join('<br>'),{
				position:'static',
				color:0xffffff,
				autoSize:true,
				marginTop:20,
				fontSize:23,
				fontFamily:''
			}),
			new Span('Handelsregister:<br>Amtsgericht Leipzig HRB 25568<br>USt-IdNr: DE 267330436', {
				position:'static',
				color:0xffffff,
				autoSize:true,
				marginTop:20,
				fontSize:23,
				fontFamily:''
			}),
			new Span('Geschäftsführer:<br>Dr. Alexander Trommen (CEO), Roman Belter (CPO), Rolf Kluge (CTO)', {
				position:'static',
				color:0xffffff,
				autoSize:true,
				marginTop:20,
				fontSize:23,
				fontFamily:''
			}),
			new Span('Copyright 2011: Appsfactory - a division of Smartrunner GmbH', {
				position:'static',
				color:0xffffff,
				autoSize:true,
				marginTop:20,
				fontSize:23,
				fontFamily:''
			})
		]);
		
		
		
		this.append([{
				tag:'button',
				_id:'btnInfoBack',
				_css: {
					width:64,
					height:54,
					bottom: 20,
					right: 20,
					backgroundImage: 'buttons.btnBack.png'
			},
			handler: {
				touchEnd: function() {
					View.open('viewMenu');					
				}
			}
		}
		]);		
	}
}