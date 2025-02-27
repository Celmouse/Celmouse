//
//  MouseController.swift
//  Runner
//
//  Created by marcelo viana on 19/01/25.
//
import CoreGraphics
import FlutterMacOS

class MouseController: NSObject {
    private let channel: FlutterMethodChannel

    init(channel: FlutterMethodChannel) {
        self.channel = channel
        super.init()
        setupMethodHandlers()
    }

    private func setupMethodHandlers() {
        channel.setMethodCallHandler { (call, result) in
            switch call.method {
            case "moveTo":
                if let arguments = call.arguments as? [String: Double],
                    let x = arguments["x"],
                    let y = arguments["y"]
                {
                    self.moveTo(to: CGPoint(x: x, y: y), result: result)
                }
            case "move":
                if let arguments = call.arguments as? [String: Double],
                    let x = arguments["x"],
                    let y = arguments["y"]
                {
                    self.move(x: x, y: y, result: result)
                }
            case "scroll":
                if let arguments = call.arguments as? [String: Double],
                    let x = arguments["x"],
                    let y = arguments["y"]
                {
                    self.scroll(x: x, y: y, result: result)
                }
            case "click":
                if let arguments = call.arguments as? Int {
                    self.click(arguments, result: result)
                }
            case "doubleClick":
                self.doubleClick(result: result)

            case "holdButton":
                if let arguments = call.arguments as? Int {
                    self.holdButton(arguments, result: result)
                }
            case "releaseButton":
                if let arguments = call.arguments as? Int {
                    self.releaseButton(arguments, result: result)
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private func moveTo(to point: CGPoint, result: @escaping FlutterResult) {
        if let event = CGEvent(
            mouseEventSource: nil,
            mouseType: .mouseMoved,
            mouseCursorPosition: point,
            mouseButton: .left
        ) {
            event.post(tap: .cghidEventTap)
        }
        result(nil)
    }

    private func move(x: Double, y: Double, result: @escaping FlutterResult) {
        if let event = CGEvent(source: nil) {
            let currentMousePosition = event.location

            // Calculate the new position
            let newX = currentMousePosition.x + CGFloat(x)
            let newY = currentMousePosition.y + CGFloat(y)

            let mouseEvent: CGEventType = .mouseMoved

            if let moveEvent = CGEvent(
                mouseEventSource: nil,
                mouseType: mouseEvent,
                mouseCursorPosition: CGPoint(x: newX, y: newY),
                mouseButton: .left
            ) {
                moveEvent.post(tap: .cghidEventTap)
            }
        }
        result(nil)
    }

    private func scroll(x: Double, y: Double, result: @escaping FlutterResult) {
        if let scrollEvent = CGEvent(
            scrollWheelEvent2Source: nil,
            units: .pixel,
            wheelCount: 2,
            wheel1: Int32(y),
            wheel2: Int32(x),
            wheel3: 0)
        {
            scrollEvent.post(tap: .cghidEventTap)
        }
        result(nil)
    }

    private func click(_ button: Int, result: @escaping FlutterResult) {
        let mouseButton: CGMouseButton
        let mousePressEventType: CGEventType
        let mouseReleaseEventType: CGEventType

        // Determine the button and event type based on the input value
        switch button {
        case 0:
            mouseButton = .left
            mousePressEventType = .leftMouseDown
            mouseReleaseEventType = .leftMouseUp
        case 1:
            mouseButton = .right
            mousePressEventType = .rightMouseDown
            mouseReleaseEventType = .rightMouseUp
        default:
            print(
                "Invalid button value. Use 0 for left button or 1 for right button."
            )
            return
        }

        // Get the current mouse position
        if let event = CGEvent(source: nil) {
            let currentMousePosition = event.location

            // Create a mouse down event
            if let mouseDownEvent = CGEvent(
                mouseEventSource: nil,
                mouseType: mousePressEventType,
                mouseCursorPosition: currentMousePosition,
                mouseButton: mouseButton
            ) {
                // Create a mouse up event
                if let mouseUpEvent = CGEvent(
                    mouseEventSource: nil,
                    mouseType: mouseReleaseEventType,
                    mouseCursorPosition: currentMousePosition,
                    mouseButton: mouseButton
                ) {
                    // Post the mouse down and mouse up events
                    mouseDownEvent.post(tap: .cghidEventTap)
                    mouseUpEvent.post(tap: .cghidEventTap)
                }
            }
        }
        result(nil)
    }

    private func doubleClick(result: @escaping FlutterResult) {
        //        self.click(button: 0)
        //        self.click(button: 0)
        result(nil)
    }

    private func holdButton(_ button: Int, result: @escaping FlutterResult) {
        let mouseButton: CGMouseButton
        let mouseEventType: CGEventType

        // Determine the button and event type based on the input value
        switch button {
        case 0:
            mouseButton = .left
            mouseEventType = .leftMouseDragged
        case 1:
            mouseButton = .right
            mouseEventType = .rightMouseDragged
        default:
            print(
                "Invalid button value. Use 0 for left button or 1 for right button."
            )
            return
        }

        // Get the current mouse position
        if let event = CGEvent(source: nil) {
            let currentMousePosition = event.location

            // Create and post the mouse down event
            if let mouseDownEvent = CGEvent(
                mouseEventSource: nil,
                mouseType: mouseEventType,
                mouseCursorPosition: currentMousePosition,
                mouseButton: mouseButton
            ) {
                mouseDownEvent.post(tap: .cghidEventTap)
            }
        }
        result(nil)
    }

    // Method to release the mouse button
    private func releaseButton(_ button: Int, result: @escaping FlutterResult) {
        let mouseButton: CGMouseButton
        let mouseEventType: CGEventType

        // Determine the button and event type based on the input value
        switch button {
        case 0:
            mouseButton = .left
            mouseEventType = .leftMouseUp
        case 1:
            mouseButton = .right
            mouseEventType = .rightMouseUp
        default:
            print(
                "Invalid button value. Use 0 for left button or 1 for right button."
            )
            return
        }

        // Get the current mouse position
        if let event = CGEvent(source: nil) {
            let currentMousePosition = event.location

            // Create and post the mouse up event
            if let mouseUpEvent = CGEvent(
                mouseEventSource: nil,
                mouseType: mouseEventType,
                mouseCursorPosition: currentMousePosition,
                mouseButton: mouseButton
            ) {
                mouseUpEvent.post(tap: .cghidEventTap)
            }
        }
        result(nil)
    }
}
