class bada.controls.Info{
    
    private static var ready:Boolean = false;
    private static var controls:Object = new Object();
    
    private static function hide($btnHide:MovieClip){
        controls.divInfo._visible = false;
        
        controls.btnBack = $btnHide;
        caurina.transitions.Tweener.addTween(controls.btnBack, {
					_y: controls.btnBack._y + 150,
					time: .3,
					transition: 'linear'
				});
        bada.Game.resume();
		
		bada.Controls.get('divInfo')._visible = true;
		bada.Controls.get('divPause')._visible = true;
		bada.Controls.get('divPlay')._visible = true;
    }
    public static function show(){
        
        if (typeof controls.divInfo == 'undefined'){
            controls.divInfo = _root['divInfo'];   
        }
        
        if (controls.divInfo._visible == true) return;
		
		bada.Controls.get('divInfo')._visible = false;
		bada.Controls.get('divPause')._visible = false;
		bada.Controls.get('divPlay')._visible = false;
        
        bada.Game.pause(false);
        controls.divInfo.swapDepths(_root.getNextHighestDepth());
        
        if (controls.btnBack)
        {
            controls.btnBack.swapDepths(_root.getNextHighestDepth());
            caurina.transitions.Tweener.addTween(controls.btnBack, {
					_y: controls.btnBack._y - 150,
					time: .3,
					transition: 'linear'
				});
        }
        
        if (ready){
            controls.divInfo._visible = true;
            return;
        }
        
        ready = true;
        
        //controls.divInfo.onPress = function(){}
        
        bada.Events.touch(controls.divInfo,'touchEnd',function(){});
        controls.divInfo.useHandCursor = false;

        
        var data = {
            x: 10,
            y: 100,
            width: 440,
            height: 20,
            autoSize: 'center',
            bold: true,
            fontSize: 30
        };

        data.y += bada.Utils.renderText(controls.divInfo, 'Tassen Fallen', data) + 20;

        data.autoSize = 'left';
        data.bold = false;
        data.fontSize = Math.round(data.fontSize * 2 / 3);

        data.x += 20;
        data.y += bada.Utils.renderText(controls.divInfo, 'Appsfactory – a division of Smartrunner GmbH', data) + 20;

        data.y += bada.Utils.renderText(controls.divInfo, 'Harkortstraße 7\n04107 Leipzig\nDeutschland\nTelefon: +49 (0)341 247 93 03\nFax: +49 (0)341 247 3282', data) + 20;

        data.y += bada.Utils.renderText(controls.divInfo, 'Handelsregister:\t Amtsgericht Leipzig HRB 25568', data) + 10;
        data.y += bada.Utils.renderText(controls.divInfo, 'USt-IdNr.:\t\t\t DE 267330436', data) + 10;
        data.y += bada.Utils.renderText(controls.divInfo, 'Geschäftsführer:\t Dr. Alexander Trommen (CEO), \n\t\t\t\t\t\tRoman Belter (CPO),\n\t\t\t\t\t\tRolf Kluge (CTO)', data) + 10;
        data.y += bada.Utils.renderText(controls.divInfo, 'Copyright 2011: \t Appsfactory – \n\t\t\t\t\ta division of Smartrunner GmbH', data) + 10;


        bada.Button.create(_root, 'external/800/buttons/btn_back.swf', {
			right: 20,
			bottom: 30
		},
		{
			touchEnd: hide
		},'btnInfoBack');

        controls.divInfo._visible = true;
    }
}