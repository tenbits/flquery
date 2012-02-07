###Flash Lite Query Library###

StyleSheets.register(
			
			'#viewMenu > div', {
				backgroundColor:0xff0000,
				position:'static',
				height:100,
				borderRadius:20,
				margin:20,
				border:[10,0x00ff00, 50]
			},
			'#subRed', {
				height:200
			},
			'#viewMenu > span',{
				color:0xffffff,
				fontSize:40,
				position:'static',
				textAlign:'center'
			});
		
		Dom.body.append("
			<view id='viewMenu' background='carbon.png repeat'>
				<div id='subRed' background='gradient(0xff0000,0x00ff00,0x0000ff)'/>
				<div/>
				<span>Hello world!</span>
			</view>
			")
		.find('#subRed')
		.bind('touchEnd', Function.bind(this.doSmth,this));