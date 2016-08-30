//
//  SauceCode+UIFont.swift
//  gotago
//
//  Created by Atin Amit on 6/10/16.
//  Copyright © 2016 Atin Amit. All rights reserved.
//

import UIKit

public extension UIFont {
    
    public func stringSize(string: String, constrainedToWidth width: Double) -> CGSize {
        return string.boundingRectWithSize(CGSize(width: width, height: DBL_MAX), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: self], context: nil).size
    }
}
