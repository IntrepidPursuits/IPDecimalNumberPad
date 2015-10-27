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

@interface IPViewController () <IPDecimalNumberPadDelegate>

@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
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
    if ([self shouldRemoveCharacterFromNumberLabel]) {
        [self removeCharacterFromNumberLabel];
    }
}

- (void)decimalNumberPadDidPressDecimalPointButton:(IPDecimalNumberPad *)decimalNumberPad {
    if ([self shouldAddCharacterToNumberLabel:@"."]) {
        [self addCharacterToNumberLabel:@"."];
    }
}

- (void)decimalNumberPad:(IPDecimalNumberPad *)decimalNumberPad didSelectValue:(NSUInteger)value {
    if ([self shouldAddCharacterToNumberLabel:[NSString stringWithFormat:@"%ld", value]]) {
        [self addCharacterToNumberLabel:[NSString stringWithFormat:@"%ld", value]];
    }
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

#pragma mark - Helpers

- (BOOL)shouldAddCharacterToNumberLabel:(NSString *)character {
    NSString *currentText = self.numberLabel.text;
    if ([self characterWouldBeSecondDecimalPoint:character forCurrentText:currentText] ||
        [self characterWouldCauseALeadingZeroAtFrontOfWholeNumber:character forCurrentText:currentText] ||
        [self characterWouldMakeMoreThanTwoDecimalPlaces:character forCurrentText:currentText] ||
        [self characterWouldAddFifthWholeNumberDigit:character toCurrentText:currentText]) {
        return NO;
    }
    return YES;
}

- (BOOL)shouldRemoveCharacterFromNumberLabel {
    return self.numberLabel.text.length > 1;
}

- (BOOL)characterWouldBeSecondDecimalPoint:(NSString *)character forCurrentText:(NSString *)currentText {
    return [character isEqualToString:@"."] && [currentText containsString:@"."];
}

- (BOOL)characterWouldCauseALeadingZeroAtFrontOfWholeNumber:(NSString *)character forCurrentText:(NSString *)currentText {
    return (currentText.length < 3) && ![character isEqualToString:@"."] && [currentText containsString:@"0"];
}

- (BOOL)characterWouldMakeMoreThanTwoDecimalPlaces:(NSString *)character forCurrentText:(NSString *)currentText {
    NSArray *amountArray = [currentText componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSString *decimal = amountArray.count > 1 ? [amountArray lastObject] : nil;
    return decimal.length > 1;
}

- (BOOL)characterWouldAddFifthWholeNumberDigit:(NSString *)character toCurrentText:(NSString *)currentText {
    return (currentText.length > 4) && ![currentText containsString:@"."] && ![character isEqualToString:@"."];
}

@end
