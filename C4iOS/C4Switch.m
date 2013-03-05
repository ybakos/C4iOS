//
//  C4Switch.m
//  C4iOS
//
//  Created by moi on 13-03-05.
//  Copyright (c) 2013 POSTFL. All rights reserved.
//

#import "C4Switch.h"

@implementation C4Switch
@synthesize on = _on, onImage = _onImage, onTintColor = _onTintColor, offImage = _offImage, tintColor = _tintColor, thumbTintColor = _thumbTintColor;

+(C4Switch *)switch:(CGRect)frame {
    C4Switch *s = [[C4Switch alloc] initWithFrame:frame];
    return s;
}

+(C4Switch *)switch {
    C4Switch *s = [[C4Switch alloc] initWithFrame:CGRectZero];
    return s;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        _UISwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 63, 23)];
        [self setFrameFromUISwitch:_UISwitch];
        [self setupFromDefaults];
        [self addSubview:_UISwitch];
        [self setup];
    }
    return self;
}

-(void)setupFromDefaults {
    
}

+(C4Switch *)defaultStyle {
    return (C4Switch *)[C4Switch appearance];
}

-(C4Switch *)copyWithZone:(NSZone *)zone {
    C4Switch *s = [[C4Switch allocWithZone:zone] initWithFrame:self.frame];
    s.style = self.style;
    return s;
}

-(UIColor *)onTintColor {
    return _UISwitch.onTintColor;
}

-(void)setOnTintColor:(UIColor *)onTintColor {
    _onTintColor = onTintColor;
    _UISwitch.onTintColor = onTintColor;
}

-(UIColor *)tintColor {
    return _UISwitch.tintColor;
}

-(void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    _UISwitch.tintColor = tintColor;
}

-(UIColor *)thumbTintColor {
    return _UISwitch.thumbTintColor;
}

-(void)setThumbTintColor:(UIColor *)thumbTintColor {
    _thumbTintColor = thumbTintColor;
    _UISwitch.thumbTintColor = thumbTintColor;
}

-(C4Image *)onImage {
    return [C4Image imageWithUIImage:_UISwitch.onImage];
}

-(void)setOnImage:(C4Image *)onImage {
    _onImage = onImage;
    _UISwitch.onImage = onImage.UIImage;
}

-(C4Image *)offImage {
    return [C4Image imageWithUIImage:_UISwitch.offImage];
}

-(void)setOffImage:(C4Image *)offImage {
    _offImage = offImage;
    _UISwitch.offImage = offImage.UIImage;
}

-(BOOL)on {
    return _UISwitch.isOn;
}

-(void)setOn:(BOOL)on {
    _UISwitch.on = on;
}

-(void)setOn:(BOOL)on animated:(BOOL)animated {
    [_UISwitch setOn:on animated:animated];
}

-(NSDictionary *)style {
    //mutable local styles
    NSMutableDictionary *localStyle = [[NSMutableDictionary alloc] initWithCapacity:0];
    [localStyle addEntriesFromDictionary:@{@"switch":self.UISwitch}];
    
    NSDictionary *controlStyle = [super style];
    
    NSMutableDictionary *localAndControlStyle = [NSMutableDictionary dictionaryWithDictionary:localStyle];
    [localAndControlStyle addEntriesFromDictionary:controlStyle];
    
    localStyle = nil;
    controlStyle = nil;
    
    return (NSDictionary *)localAndControlStyle;
}

-(void)setStyle:(NSDictionary *)newStyle {
    self.tintColor = self.thumbTintColor = self.onTintColor = nil;
    self.offImage = self.onImage = nil;
    self.on = NO;
    
    [super setStyle:newStyle];
    
    UISwitch *s = [newStyle objectForKey:@"switch"];
    if(s != nil) {
        self.frame = (CGRect){self.origin,s.frame.size};
        _UISwitch.tintColor = s.tintColor;
        _UISwitch.onTintColor = s.onTintColor;
        _UISwitch.thumbTintColor = s.thumbTintColor;
        _UISwitch.onImage = s.onImage;
        _UISwitch.offImage = s.offImage;
        s = nil;
    }
}

-(void)setFrameFromUISwitch:(UISwitch *)s {
    CGRect frame = s.frame;
    self.frame = frame;
    _UISwitch.center = CGPointMake(floorf(self.width/2),floorf(self.height/2));
}

#pragma mark other C4UIElement (target:action)
-(void)runMethod:(NSString *)methodName target:(id)object forEvent:(C4ControlEvents)event {
    [self.UISwitch addTarget:object action:NSSelectorFromString(methodName) forControlEvents:(UIControlEvents)event];
}

-(void)stopRunningMethod:(NSString *)methodName target:(id)object forEvent:(C4ControlEvents)event {
    [self.UISwitch removeTarget:object action:NSSelectorFromString(methodName) forControlEvents:(UIControlEvents)event];
}
@end
