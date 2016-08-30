//
//  SauceCodeFont.swift
//  gotago
//
//  Created by Atin Amit on 6/10/16.
//  Copyright © 2016 Atin Amit. All rights reserved.
//

import UIKit

public protocol SauceCodeFontType {}

public struct SauceCodeFont : SauceCodeFontType {
    
    // Size of font
    public static let pointSize: CGFloat = 16
    
    // Retrieves the system font with specified size
    public static func systemFontWithSize(size: CGFloat) -> UIFont {
        return UIFont.systemFontOfSize(size)
    }
    
    // Retrieve the bold system font with specified size
    public static func boldSystemFontWithSize(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFontOfSize(size)
    }
    
    // Retireve the italic system font of specific size
    public static func italicSystemFontWithSize(size: CGFloat) -> UIFont {
        return UIFont.italicSystemFontOfSize(size)
    }
    
    // Load a font if needed
    public static func loadFontIfNeeded(fontName: String) {
        SauceCodeFontLoader.loadFontIfNeeded(fontName)
    }
}

// Load SauceCode Font Package
private class SauceCodeFontLoader {
    // Dictionary of fonts already loaded
    static var loadedFonts: Dictionary<String, String> = Dictionary<String, String>()
    
    // Load a font specified if needed
    static func loadFontIfNeeded(fontName: String) {
        let loadedFont: String? = SauceCodeFontLoader.loadedFonts[fontName]
        
        if nil == loadedFont && nil == UIFont(name: fontName, size: 1) {
            SauceCodeFontLoader.loadedFonts[fontName] = fontName
            
            let bundle: NSBundle = NSBundle(forClass: SauceCodeFontLoader.self)
//            let identifier: String? = bundle.bundleIdentifier
            
            let fontURL: NSURL? = bundle.URLForResource(fontName, withExtension: "ttf")
            
            if let v: NSURL = fontURL {
                let data: NSData = NSData(contentsOfURL: v)!
                let provider: CGDataProvider = CGDataProviderCreateWithCFData(data)!
                let font: CGFont = CGFontCreateWithDataProvider(provider)!
                
//                NSLog("CGFontGetStemV(font) = \(CGFontGetStemV(font))")
                NSLog("CGFontCopyFullName(font) = \(CGFontCopyFullName(font))")
                
                
                var error: Unmanaged<CFError>?
                if !CTFontManagerRegisterGraphicsFont(font, &error) {
                    let errorDescription: CFStringRef = CFErrorCopyDescription(error!.takeUnretainedValue())
                    let nsError: NSError = error!.takeUnretainedValue() as AnyObject as! NSError
                    
                    NSException(name: NSInternalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
                }
                
            }
        }
    }
}
