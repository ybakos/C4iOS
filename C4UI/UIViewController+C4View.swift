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
import C4Core
import C4UI
import ObjectiveC

private var canvasAssociationKey: UInt8 = 0

public extension UIViewController {
    
    public var canvas : C4View {
        get {
            var optionalObject:AnyObject? = objc_getAssociatedObject(self, &canvasAssociationKey)
            if let object:AnyObject = optionalObject {
                return object as C4View
            } else {
                return C4View() // default value when uninitialized
            }
        }
    }
    
    public func loadView() {
        objc_setAssociatedObject(
            self,
            &canvasAssociationKey,
            C4View(frame: C4Rect(UIScreen.mainScreen().bounds)),
            objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        canvas.backgroundColor = white
        self.view = canvas.view
    }
}