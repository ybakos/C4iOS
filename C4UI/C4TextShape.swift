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

import QuartzCore
import UIKit
import C4Core
import Foundation

public class C4TextShape : C4Shape {
    convenience public init(text: String, font: C4Font) {
        let textPath = CGPathCreateMutable()
        let ctfont = font.CTFont
        var unichars = [UniChar](text.utf16)
        var glyphs = [CGGlyph](count: unichars.count, repeatedValue: 0)
        let count = unichars.count

        if CTFontGetGlyphsForCharacters(ctfont, &unichars, &glyphs, unichars.count) {
            var invert = CGAffineTransformMakeScale(1,-1)
            var origin = CGPointZero
            for glyph in glyphs {
                let currentPath = CTFontCreatePathForGlyph(ctfont, glyph, &invert)
                var glyphArr = [glyph]
                var translation = CGAffineTransformMakeTranslation(origin.x, origin.y);
                CGPathAddPath(textPath, &translation, currentPath)
                var advance = CTFontGetAdvancesForGlyphs(ctfont, .OrientationDefault, &glyphArr, nil, 1);
                origin.x += CGFloat(advance)
            }
        }
        
        var stringRect = CGPathGetBoundingBox(textPath)
        self.init(frame: C4Rect(stringRect))
        self.path = C4Path(path: textPath)
        adjustToFitPath()
        self.origin = C4Point(0,0)
    }
}