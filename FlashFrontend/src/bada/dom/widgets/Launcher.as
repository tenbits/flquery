class bada.dom.widgets.Launcher{
    
    private static var $overlay:MovieClip;
    private static var $progress:caurina.ProgressIndicator;
    
    public static function setup(){
        $overlay = bada.Utils.createMovieClip(_root,'launcherOverlay')
        var fillType = "linear",
        colors = [0x373737, 0x000000],
        alphas = [50, 80],
        ratios = [0, 255],
        matrix = {matrixType:"box", x:200, y:450, w:150, h:100, r:45/180*Math.PI};
        
        
        $overlay.lineStyle(1, 0x000000, 100);
        $overlay.beginGradientFill(fillType, colors, alphas, ratios, matrix);
        $overlay.moveTo(0, 0);
        $overlay.lineTo(Bada.screen.width, 0);
        $overlay.lineTo(Bada.screen.width, Bada.screen.height);
        $overlay.lineTo(0, Bada.screen.height);
        $overlay.lineTo(0, 0);
        $overlay.endFill();
        
        $progress = new caurina.ProgressIndicator(_root,null,null,null,null,0xFEECE2,40);
    }
    
    public static function remove(){
        $progress.kill();
        $overlay.removeMovieClip();
        $progress = null;
        $overlay = null;
    }
}