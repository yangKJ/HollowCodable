//
//  Logger.swift
//  CodableExample
//
//  Created by Condy on 2024/6/17.
//

import Foundation

extension Hollow {
    public struct Logger {
        public enum DebugMode: Int {
            case release = 0
            case debug = 1
        }
    }
}

extension Hollow.Logger {
    
    /// Set debug mode
    public static var debugMode: DebugMode {
        get { _mode }
        set { _mode = newValue }
    }
    
    /// Whether to enable assertions (effective in debug mode).
    /// Once enabled, an assertion will be performed where parsing fails, providing a more direct reminder to the user that parsing has failed at this point.
    public static var openErrorAssert: Bool = false
    
    private static var _mode = {
        #if DEBUG
        DebugMode.debug
        #else
        DebugMode.release
        #endif
    }()
    
    static var logIfNeeded: Bool {
        debugMode.rawValue > Hollow.Logger.DebugMode.release.rawValue
    }
    
    static func logDebug(_ error: Error) {
        if !logIfNeeded {
            return
        }
        if openErrorAssert {
            assert(false, "\(error)")
        }
        if let error = error as? DecodingError {
            switch error {
            case .keyNotFound:
                print("No value associated with key.")
            case .valueNotFound( _, let context):
                print(context.debugDescription)
            case .typeMismatch( _, let context):
                print(context.debugDescription)
            case .dataCorrupted(let context):
                print(context.debugDescription)
            default:
                break
            }
        } else {
            print(error.localizedDescription)
        }
    }
}
