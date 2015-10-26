//
//  CAGradientLayer+IPGradients.m
//  IPDecimalNumberPad
//
//  Created by Nicholas Servidio on 10/26/15.
//  Copyright © 2015 Nick Servidio. All rights reserved.
//

#import "CAGradientLayer+IPGradients.h"
#import "UIColor+IPStyle.h"

@implementation CAGradientLayer (IPGradients)

+ (CAGradientLayer *)greenGradientLayer {
    return [self gradentLayerWithTopColor:[UIColor ipShamrock] bottomColor:[UIColor ipGreenish]];
}

+ (CAGradientLayer *)gradentLayerWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor {
    NSArray *gradientColors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
    NSArray *gradientLocations = @[@0.0, @1.0];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
    
    return gradientLayer;
}

@end
