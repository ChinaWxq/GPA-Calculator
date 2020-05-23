//
//  Extension.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

/*
 扩展文件
 iPhone X的数据 375, 812
 */

import Foundation
import UIKit

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

extension Double {
    var fit: CGFloat {
        return CGFloat(self/375.0) * UIScreen.main.bounds.width
    }
    var fitW: CGFloat {
        return CGFloat(self/375.0) * UIScreen.main.bounds.width
    }
    var fitH: CGFloat {
        return CGFloat(self/812.0) * UIScreen.main.bounds.width
    }
}
extension Int {
    var fit: Int {
        return Int(CGFloat(self)/375.0 * UIScreen.main.bounds.width)
    }
    var fitW: Int {
        return Int(CGFloat(self)/375.0 * UIScreen.main.bounds.width)
    }
    var fitH: Int {
        return Int(CGFloat(self)/812.0 * UIScreen.main.bounds.width)
    }
}
extension CGFloat {
    var fitScreen: CGFloat {
        return CGFloat(self/375.0 * UIScreen.main.bounds.size.width)
    }
    var fit: CGFloat {
        return CGFloat(self/375.0) * UIScreen.main.bounds.width
    }
    var fitW: CGFloat {
        return CGFloat(self/375.0) * UIScreen.main.bounds.width
    }
    var fitH: CGFloat {
        return CGFloat(self/812.0) * UIScreen.main.bounds.width
    }
}

public extension UIColor {
    
    // Init color without divide 255.0
    //
    // - Parameters:
    //   - r: (0 ~ 255) red
    //   - g: (0 ~ 255) green
    //   - b: (0 ~ 255) blue
    //   - a: (0 ~ 1) alpha
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: a)
    }
    
    // Init color with hex code
    //
    // - Parameter hex: hex code (eg. 0x00eeee)
    convenience init(hex: Int) {
        self.init(r: (hex & 0xff0000) >> 16, g: (hex & 0xff00) >> 8, b: (hex & 0xff), a: 1)
    }
}
