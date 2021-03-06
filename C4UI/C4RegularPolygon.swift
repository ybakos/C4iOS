// Copyright © 2014 C4
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions: The above copyright
// notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

import Foundation
import CoreGraphics
import C4Core

public class C4RegularPolygon: C4Shape {
    @IBInspectable
    public var sides: Int = 6 {
        didSet {
            updatePath()
        }
    }
    
    @IBInspectable
    public var phase: Double = 0 {
        didSet {
            updatePath()
        }
    }
    
    convenience public init(frame: C4Rect) {
        self.init()
        self.view.frame = CGRect(frame)
        view.layer.addSublayer(shapeLayer)
        updatePath()
    }
    
    public override init() {
        super.init()
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func updatePath() {
        let rect = inset(C4Rect(view.frame), lineWidth, lineWidth)
        let rx = rect.size.width / 2.0
        let ry = rect.size.height / 2.0
        if sides == 0 || rx <= 0 || ry <= 0 {
            // Don't try to generate invalid polygons, we'll get undefined behaviour
            return
        }
    
        let center = rect.center
        let delta = 2.0*M_PI / Double(sides)
        var newPath = C4Path()
        
        for i in 0..<sides {
            let angle = phase + delta*Double(i)
            let point = C4Point(center.x + rx*cos(angle), center.y + ry*sin(angle))
            if i == 0 {
                newPath.moveToPoint(point)
            } else {
                newPath.addLineToPoint(point)
            }
        }
        newPath.closeSubpath()
        path = newPath
    }
}
