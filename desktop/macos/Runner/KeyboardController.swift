import Cocoa
import FlutterMacOS
import Carbon.HIToolbox

class KeyboardController: NSObject {
    private let channel: FlutterMethodChannel
    
    init(channel: FlutterMethodChannel) {
        self.channel = channel
        super.init()
        setupMethodHandlers()
    }
    
    private func setupMethodHandlers() {
        channel.setMethodCallHandler { (call, result) in
            
            switch call.method {
            case "pressKey":
                if let key = call.arguments as? String {
                    self.pressKey(key, result: result)
                }
            case "releaseKey":
                if let key = call.arguments as? String {
                    self.releaseKey(key, result: result)
                }
            case "pressSpecialKey":
                if let key = call.arguments as? String {
                    self.pressSpecialKey(key, result: result)
                }
            case "releaseSpecialKey":
                if let key = call.arguments as? String {
                    self.releaseSpecialKey(key, result: result)
                }
            case "convertDartKeyToSwift":
                if let key = call.arguments as? String {
                    self.convertDartKeyToSwift(key, result: result)
                }
            case "convertSwiftKeyToDart":
                if let key = call.arguments as? String {
                    self.convertSwiftKeyToDart(key, result: result)
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    private func pressKey(_ key: String, result: @escaping FlutterResult) {
        let source = CGEventSource(stateID: .hidSystemState)
        
        if let keyCode = charToCGKeyCode(Character(key)){
            if let event = CGEvent(keyboardEventSource: source,
                                   virtualKey: keyCode,
                                   keyDown: true) {
                event.post(tap: .cghidEventTap)
            }
        }
        result(nil)
    }
    
    private func releaseKey(_ key: String, result: @escaping FlutterResult) {
        let source = CGEventSource(stateID: .hidSystemState)
        
        if let keyCode = charToCGKeyCode(Character(key)){
            if let event = CGEvent(keyboardEventSource: source,
                                   virtualKey: keyCode,
                                   keyDown: false) {
                event.post(tap: .cghidEventTap)
            }
        }
        result(nil)
    }
    
    
    private func pressSpecialKey(_ key: String, result: @escaping FlutterResult) {
        let source = CGEventSource(stateID: .hidSystemState)
        let keyCode = self.getSpecialKeyCode(key)
        
        if let event = CGEvent(keyboardEventSource: source,
                               virtualKey: keyCode,
                               keyDown: true) {
            event.post(tap: .cghidEventTap)
        }
        
        result(nil)
    }
    
    private func releaseSpecialKey(_ key: String, result: @escaping FlutterResult) {
        let source = CGEventSource(stateID: .hidSystemState)
        let keyCode = self.getSpecialKeyCode(key)
        
        if let event = CGEvent(keyboardEventSource: source,
                               virtualKey: keyCode,
                               keyDown: false) {
            event.post(tap: .cghidEventTap)
        }
        
        result(nil)
    }
    
    private func charToCGKeyCode(_ char: Character) -> CGKeyCode? {
        guard let currentKeyboard = TISCopyCurrentKeyboardLayoutInputSource()?.takeUnretainedValue(),
              let rawLayoutData = TISGetInputSourceProperty(currentKeyboard, kTISPropertyUnicodeKeyLayoutData) else {
            return nil
        }
        
        let layoutData = Unmanaged<CFData>.fromOpaque(rawLayoutData).takeUnretainedValue()
        let keyboardLayout = unsafeBitCast(CFDataGetBytePtr(layoutData), to: UnsafePointer<UCKeyboardLayout>.self)
        
        let charAsString = String(char)
        guard let unicodeScalar = charAsString.unicodeScalars.first else { return nil }
        
        let charCode = UInt16(unicodeScalar.value)
        var keyCode: CGKeyCode = 0
        var deadKeyState: UInt32 = 0
        var charBuffer: [UniChar] = [0]
        var actualStringLength: Int = 0
        
        for possibleKeyCode in CGKeyCode(0)...CGKeyCode(127) {
            let status = UCKeyTranslate(
                keyboardLayout,
                possibleKeyCode,
                UInt16(kUCKeyActionDown),
                0,
                UInt32(LMGetKbdType()),
                OptionBits(kUCKeyTranslateNoDeadKeysBit),
                &deadKeyState,
                charBuffer.count,
                &actualStringLength,
                &charBuffer
            )
            
            if status == noErr, actualStringLength > 0, charBuffer[0] == charCode {
                keyCode = possibleKeyCode
                return keyCode
            }
        }
        
        return nil
    }

    
    private func getSpecialKeyCode(_ key: String) -> CGKeyCode {
        switch key.lowercased() {
        case "return": return 0x24
        case "tab": return 0x30
        case "space": return 0x31
        case "delete", "backspace": return 0x33
        case "escape", "esc": return 0x35
        case "command": return 0x37
        case "shift": return 0x38
        case "capslock": return 0x39
        case "option": return 0x3A
        case "control", "ctrl": return 0x3B
        case "rightshift": return 0x3C
        case "rightoption": return 0x3D
        case "rightcontrol": return 0x3E
        case "leftarrow": return 0x7B
        case "rightarrow": return 0x7C
        case "downarrow": return 0x7D
        case "uparrow": return 0x7E
        default: return 0x00
        }
    }
    
    private func convertDartKeyToSwift(_ dartKey: String, result: @escaping FlutterResult) {
        let swiftKey: String
        
        switch dartKey {
            // Letters
        case "KeyA" ... "KeyZ":
            swiftKey = String(dartKey.last!).lowercased()
            
            // Numbers
        case "Digit0" ... "Digit9":
            swiftKey = String(dartKey.last!)
            
            // Special Keys
        case "Enter": swiftKey = "return"
        case "Tab": swiftKey = "tab"
        case "Space": swiftKey = "space"
        case "Backspace": swiftKey = "delete"
        case "Escape": swiftKey = "escape"
        case "MetaLeft", "MetaRight": swiftKey = "command"
        case "ShiftLeft": swiftKey = "shift"
        case "ShiftRight": swiftKey = "rightshift"
        case "CapsLock": swiftKey = "capslock"
        case "AltLeft": swiftKey = "option"
        case "AltRight": swiftKey = "rightoption"
        case "ControlLeft": swiftKey = "control"
        case "ControlRight": swiftKey = "rightcontrol"
        case "ArrowLeft": swiftKey = "leftarrow"
        case "ArrowRight": swiftKey = "rightarrow"
        case "ArrowDown": swiftKey = "downarrow"
        case "ArrowUp": swiftKey = "uparrow"
            
            // Function Keys
        case "F1" ... "F12": swiftKey = dartKey.lowercased()
            
        default:
            result(FlutterError(code: "INVALID_KEY",
                                message: "Unsupported Dart key: \(dartKey)",
                                details: nil))
            return
        }
        
        result(swiftKey)
    }
    
    private func convertSwiftKeyToDart(_ swiftKey: String, result: @escaping FlutterResult) {
        let dartKey: String
        
        switch swiftKey.lowercased() {
            // Letters
        case "a" ... "z":
            dartKey = "Key\(swiftKey.uppercased())"
            
            // Numbers
        case "0" ... "9":
            dartKey = "Digit\(swiftKey)"
            
            // Special Keys
        case "return": dartKey = "Enter"
        case "tab": dartKey = "Tab"
        case "space": dartKey = "Space"
        case "delete": dartKey = "Backspace"
        case "escape": dartKey = "Escape"
        case "command": dartKey = "MetaLeft"
        case "shift": dartKey = "ShiftLeft"
        case "rightshift": dartKey = "ShiftRight"
        case "capslock": dartKey = "CapsLock"
        case "option": dartKey = "AltLeft"
        case "rightoption": dartKey = "AltRight"
        case "control": dartKey = "ControlLeft"
        case "rightcontrol": dartKey = "ControlRight"
        case "leftarrow": dartKey = "ArrowLeft"
        case "rightarrow": dartKey = "ArrowRight"
        case "downarrow": dartKey = "ArrowDown"
        case "uparrow": dartKey = "ArrowUp"
            
            // Function Keys
        case "f1" ... "f12": dartKey = swiftKey.uppercased()
            
        default:
            result(FlutterError(code: "INVALID_KEY",
                                message: "Unsupported Swift key: \(swiftKey)",
                                details: nil))
            return
        }
        
        result(dartKey)
    }
}
