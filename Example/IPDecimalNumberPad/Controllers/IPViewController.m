//
//  IPViewController.m
//  IPDecimalNumberPad
//
//  Created by Nick Servidio on 10/23/2015.
//  Copyright (c) 2015 Nick Servidio. All rights reserved.
//

#import "IPViewController.h"
#import "IPDecimalNumberPad.h"
#import "CAGradientLayer+IPGradients.h"
#import "UIFont+IPStyle.h"

@interface IPViewController () <IPDecimalNumberPadDelegate>

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet IPDecimalNumberPad *numberPad;
@property (strong, nonatomic) CAGradientLayer *backgroundLayer;

@end

@implementation IPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackgroundGradient];
    [self setupLabel];
    self.numberPad.delegate = self;
    self.numberLabel.text = @"";
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.backgroundLayer.frame = self.view.bounds;
}

#pragma mark - Setups

- (void)setupBackgroundGradient {
    self.backgroundLayer = [CAGradientLayer greenGradientLayer];
    [self.view.layer insertSublayer:self.backgroundLayer atIndex:0];
}

- (void)setupLabel {
    self.numberLabel.font = [UIFont ipLightDisplayFontWithSize:64.0];
}

#pragma mark - IPDecimalNumberPadDelegate

- (void)decimalNumberPadDidPressDeleteButton:(IPDecimalNumberPad *)decimalNumberPad {
    [self removeCharacterFromNumberLabel];
}

- (void)decimalNumberPadDidPressDecimalPointButton:(IPDecimalNumberPad *)decimalNumberPad {
    [self addCharacterToNumberLabel:@"."];
}

- (void)decimalNumberPad:(IPDecimalNumberPad *)decimalNumberPad didSelectValue:(NSUInteger)value {
    [self addCharacterToNumberLabel:[NSString stringWithFormat:@"%ld", value]];
}

#pragma mark - Text Handling

- (void)removeCharacterFromNumberLabel {
    NSString *numberText = self.numberLabel.text;
    if (numberText.length > 0) {
        numberText = [numberText substringToIndex:numberText.length - 1];
        self.numberLabel.text = numberText;
    }
}

- (void)addCharacterToNumberLabel:(NSString *)character {
    NSMutableString *mutableNumberText = [self.numberLabel.text mutableCopy];
    [mutableNumberText appendString:character];
    self.numberLabel.text = [mutableNumberText copy];
}

@end
