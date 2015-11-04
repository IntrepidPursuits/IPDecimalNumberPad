//
//  IPDecimalNumberPadButton.m
//  Pods
//
//  Created by Nicholas Servidio on 10/26/15.
//
//

#import "IPDecimalNumberPadButton.h"

@implementation IPDecimalNumberPadButton

#pragma mark - Initializers

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    self.titleLabel.font = [UIFont systemFontOfSize:32.0];
}

@end
