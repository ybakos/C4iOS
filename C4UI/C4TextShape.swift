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
        //create a mutable path to hold individual character paths
        let textPath = CGPathCreateMutable()

        let ctfont = font.CTFont
        
        //get the unichar array from the text
        var unichars = [UniChar](text.utf16)
        
        //allocate an empty glyph array
        var glyphs = [CGGlyph](count: unichars.count, repeatedValue: 0)

        //attempt to get the actualy glyphs for the unicode characters
        if CTFontGetGlyphsForCharacters(ctfont, &unichars, &glyphs, unichars.count) {
            //if successful
            
            //create an invert transform
            var invert = CGAffineTransformMakeScale(1,-1)
            
            //create an origin point to keep track of the new glphy path position
            var origin = CGPointZero
            
            //for each glyph
            for glyph in glyphs {
                //create a path for the current glyph
                let currentPath = CTFontCreatePathForGlyph(ctfont, glyph, &invert)
                //create an array
                var glyphArr = [glyph]
                //create a translation for the current glyph path
                var translation = CGAffineTransformMakeTranslation(origin.x, origin.y);
                //add the current path, with the translation, to the mutable textPath
                CGPathAddPath(textPath, &translation, currentPath)
                //calculate the advance for the current glyph
                var advance = CTFontGetAdvancesForGlyphs(ctfont, .OrientationDefault, &glyphArr, nil, 1);
                //update the origin for the new glyph
                origin.x += CGFloat(advance)
            }
        }
        
        //continue with initialization
        var frame = CGPathGetBoundingBox(textPath)
        self.init(frame: C4Rect(frame))
        self.path = C4Path(path: textPath)
        adjustToFitPath()
        self.origin = C4Point(0,0)
    }
}