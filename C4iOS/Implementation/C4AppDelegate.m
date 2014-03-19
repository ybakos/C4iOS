// Copyright © 2012 Travis Kirton
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

#import "C4AppDelegate.h"
#import "C4AssertionHandler.h"

@implementation C4AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    launchOptions = launchOptions;
    
    [C4View class];
    
    C4AssertionHandler* customAssertionHandler = [[C4AssertionHandler alloc] init];
    [[[NSThread currentThread] threadDictionary] setValue:customAssertionHandler forKey:NSAssertionHandlerKey];
    // NB: your windowing code goes here - e.g. self.window.rootViewController = self.viewController;
    
    application.statusBarHidden = YES;
    self.window = [[C4Window alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.workspace = [[C4WorkSpace alloc] init];
    _window.rootViewController = self.workspace;
    
    [self.window makeKeyAndVisible];
    
    //strangely, if the following call to set the background color isn't made, then the view doesn't receive touch events...
    self.workspace.view.backgroundColor = [UIColor whiteColor];
    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [self.workspace setup];
    return YES;
}

+(void)initialize {
    //set these before everything else.
    C4Control* controlStyle = [C4Control defaultStyle];
    controlStyle.alpha = 1.0f;
    controlStyle.animationDuration = 0.0f;
    controlStyle.animationDelay = 0.0f;
    controlStyle.animationOptions = BEGINCURRENT;
    controlStyle.backgroundColor = [UIColor clearColor];
    controlStyle.cornerRadius = 0.0f;
    controlStyle.layer.delegate = self;
    controlStyle.shadowColor = C4GREY;
    controlStyle.shadowOpacity = 0.0f;
    controlStyle.shadowOffset = CGSizeZero;
    controlStyle.repeatCount = 0;
    
    NSDictionary *basicStyle = @{
      @"alpha":@1.f,
      @"animationDuration":@0.f,
      @"animationDelay":@0.f,
      @"animationOptions":@(BEGINCURRENT),
      @"backgroundColor":[UIColor clearColor],
      @"cornerRadius":@0.f,
      @"shadowColor":C4GREY,
      @"shadowOpacity":@0.f,
      @"shadowOffset":[NSValue valueWithCGSize:CGSizeZero],
      @"repeatCount":@0
    };
    
    [C4Control defaultStyle].style = basicStyle;
    [C4ActivityIndicator defaultStyle].color = C4BLUE;
    
    [C4Button defaultStyle].style = basicStyle;
    [C4Button defaultStyle].tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"darkBluePattern@2x"]];
    
    [C4Label defaultStyle].style = basicStyle;
    [C4Label defaultStyle].textColor = C4GREY;
    [C4Label defaultStyle].highlightedTextColor = C4RED;
    [C4Label defaultStyle].backgroundColor = [UIColor clearColor];
    
    C4Shape* shapeStyle = [C4Shape defaultStyle];
    shapeStyle.style = basicStyle;
    shapeStyle.fillColor = C4GREY;
    shapeStyle.fillRule = FILLNORMAL;
    shapeStyle.lineCap = CAPBUTT;
    shapeStyle.lineDashPattern = nil;
    shapeStyle.lineDashPhase = 0.0f;
    shapeStyle.lineJoin = JOINMITER;
    shapeStyle.lineWidth = 5.0f;
    shapeStyle.miterLimit = 10.0f; //this doesn't like being set here...
    shapeStyle.strokeColor = C4BLUE;
    shapeStyle.strokeEnd = 1.0f;
    shapeStyle.strokeStart = 0.0f;
    
    [C4Slider defaultStyle].style = basicStyle;
    [C4Slider defaultStyle].thumbTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"darkBluePattern"]];
    [C4Slider defaultStyle].minimumTrackTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lightGrayPattern"]];
    [C4Slider defaultStyle].maximumTrackTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lightGrayPattern"]];
    
    [C4Stepper defaultStyle].style = basicStyle;
    [C4Stepper defaultStyle].tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lightGrayPattern"]];
    [[C4Stepper defaultStyle] setDecrementImage:[C4Image imageNamed:@"decrementDisabled"] forState:DISABLED];
    [[C4Stepper defaultStyle] setDecrementImage:[C4Image imageNamed:@"decrementNormal"] forState:NORMAL];
    [[C4Stepper defaultStyle] setIncrementImage:[C4Image imageNamed:@"incrementDisabled"] forState:DISABLED];
    [[C4Stepper defaultStyle] setIncrementImage:[C4Image imageNamed:@"incrementNormal"] forState:NORMAL];
    
    [C4Switch defaultStyle].style = basicStyle;
    [C4Switch defaultStyle].onTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lightBluePattern"]];
    [C4Switch defaultStyle].tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lightRedPattern"]];
    [C4Switch defaultStyle].thumbTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lightGrayPattern"]];
    [[C4Switch defaultStyle] setOffImage:[C4Image imageNamed:@"switchOff"]];
    [[C4Switch defaultStyle] setOnImage:[C4Image imageNamed:@"switchOn"]];
}

@end