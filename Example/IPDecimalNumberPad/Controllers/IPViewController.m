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
#import "IPStringBackedDecimalValue.h"

@interface IPViewController () <IPDecimalNumberPadDelegate>

@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet IPDecimalNumberPad *numberPad;
@property (strong, nonatomic) CAGradientLayer *backgroundLayer;
@property (strong, nonatomic) IPStringBackedDecimalValue *currentAmount;

@end

@implementation IPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackgroundGradient];
    [self setupLabel];
    self.numberPad.delegate = self;
    self.currentAmount = [[IPStringBackedDecimalValue alloc] init];
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
    self.numberLabel.font = [UIFont systemFontOfSize:64.0];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.text = @"$";
    self.instructionLabel.font = [UIFont systemFontOfSize:18.0];
    self.instructionLabel.textColor = [UIColor whiteColor];
    self.instructionLabel.text = @"Enter payment amount:";
}

#pragma mark - IPDecimalNumberPadDelegate

- (void)decimalNumberPadDidPressDeleteButton:(IPDecimalNumberPad *)decimalNumberPad {
    [self.currentAmount removeDigitFromCurrentValue];
    [self configureNumberLabel];
}

- (void)decimalNumberPadDidPressDecimalPointButton:(IPDecimalNumberPad *)decimalNumberPad {
    [self.currentAmount addDecimalPointToCurrentValue];
    [self configureNumberLabel];
}

- (void)decimalNumberPad:(IPDecimalNumberPad *)decimalNumberPad didSelectValue:(NSUInteger)value {
    [self.currentAmount addDigitToCurrentValue:value];
    [self configureNumberLabel];
}

- (void)configureNumberLabel {
    self.numberLabel.text = [NSString stringWithFormat:@"$%@", self.currentAmount.currentValue];
}

@end
