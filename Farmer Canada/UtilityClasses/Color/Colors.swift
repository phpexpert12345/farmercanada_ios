//
//  Colors.swift
//  HarpersKabab
//
//  Created by Arun Kumar Rathore on 01/06/20.
//  Copyright © 2020 arunkumar. All rights reserved.
//

import UIKit

class Colors: NSObject {

    
    static let APP_COLOR = "#E8626A"
    static let BUTTON_COLOR = "#E8626A"
    static let WHITE_SMOKE = "#F8F8F8"
    static let LIGHT_COLOR = "#E76169"
    static let DARK_COLOR = "#C9313A"
    
    //    Convert the hex string in UIColor
    static func colorWithHexString(_ hexString : String) -> UIColor {
        
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor.init(red:red, green:green, blue:blue, alpha:1.0)
    }
}
