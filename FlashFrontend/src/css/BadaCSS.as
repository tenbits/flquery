import bada.dom.StyleSheets;
/**
 * ...
 * @author tenbits
 */
class css.BadaCSS
{
	
	static function setup() {
		StyleSheets.register(
		'span', {
			fontFamily: 'src.resources.fonts.ciclegordita.ttf'
		},						
		'.header', {
			position:'absolute',
			borderImage:['src.resources.800.ex.background.header.bitmap.png', 32],
			height:50,				
			width: Bada.screen.width,
			color:0x141414,
			fontSize: 25,
			lineHeight: 50
			//,verticalAlign: 'middle'			
		},
		'.header > span', {
			width:'100%',
			textAlign:'center',
			y:'50%'
		},
		'.header > button', {
			y: '50%',
			x: 30,
			alpha: 90
		},
		'.group', {
			position:'static',
			borderRadius: 30,
			backgroundColor:0xcccccc,
			margin: 10,
			border:[1, 0x555555],
			boxShadow: '0 0 8 4 0'
		},
		'.group > div', {
			position:'static'				
		},
		'.group-header', {
			height: 50,
			lineHeight: 50,
			verticalAlign:'middle'	,
			borderRadius: [30, 30, 0, 0],	
			backgroundGradient: {
				colors:[0x333333, 0],
				alphas: [100, 0],
				radius: Math.PI / 4
			},
			border: {
				bottom: [1, 0x555555]
			}
		},
		'.group-header > span', {
			textAlign:'center',
			fontSize: 23,
			color:0xcccccc				
		},
		'_listview > .item', {
			position:'static',
			//backgroundColor:0xff0000,
			height:70,
			fontSize: 20
		},
		'_listview > .item.hover', {
			backgroundGradient: {
				colors:[0, 0x888888],
				alphas: [0, 100],
				radius: Math.PI / 2
			},
			border: {
				top:[1, 0],
				bottom: [1,0xffffff]
			}
		},
		'_listview > .divider', {
			position:'static',
			backgroundImage:'ex.list.list-item-divider.png',
			backgroundPosition: { x: 'center' },
			height:1,
			width:'100%'				
		},
		'button', {
			display:'inline-block',
			color:0xffffff,
			fontSize: 22,
			backgroundGradient: { colors: [0x555555, 0x303030], radius: Math.PI / 2 },
			borderRadius: 12,
			border: [1, 0]
		},		
		'button.red', {
			backgroundGradient: { colors: [0xC80606, 0x8E0404], radius: Math.PI / 2 }
		},
		'button.green', {
			backgroundGradient: { colors: [0x17AB1E, 0x0E6812], radius: Math.PI / 2 }
		},
		'button.red.hover', {
			backgroundGradient: { colors: [0x8E0404, 0xC80606] },
			scale: 95
		},
		'button.green.hover', {
			backgroundGradient: { colors: [0x0E6812, 0x17AB1E] },
			scale: 95
		},
		'button.hover', {
			backgroundGradient: { colors: [0x111111, 0x444444] },
			scale: 95
		},
		'.spinner', {
			backgroundImage: 'ex.spinner-large.png'
		}
		
		);
	}
	
}