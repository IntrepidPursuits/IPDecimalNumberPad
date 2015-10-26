//
//  UIFont+IPStyle.m
//  IPDecimalNumberPad
//
//  Created by Nicholas Servidio on 10/26/15.
//  Copyright © 2015 Nick Servidio. All rights reserved.
//

#import "UIFont+IPStyle.h"

@implementation UIFont (IPStyle)

+ (UIFont *)ipLightDisplayFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SanFranciscoDisplay-Light" size:size];
}

+ (UIFont *)ipLightTextFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SanFranciscoText-Light" size:size];
}

@end
