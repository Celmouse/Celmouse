import FlutterMacOS

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)
        
        let mouseChannel = FlutterMethodChannel(
            name: "com.celmouse.plugins/mouse",
            binaryMessenger: flutterViewController.engine.binaryMessenger
        )
        
        let _ = MouseController(channel: mouseChannel)
        
        let keyboardChannel = FlutterMethodChannel(
            name: "com.celmouse.plugins/keyboard",
            binaryMessenger: flutterViewController.engine.binaryMessenger
        )
        
        let _ = KeyboardController(channel: keyboardChannel)
        
        RegisterGeneratedPlugins(registry: flutterViewController)
        
        super.awakeFromNib()
    }
}
