//
//  IPDecimalNumberPadController.m
//  Pods
//
//  Created by Nicholas Servidio on 10/26/15.
//
//

#import "IPDecimalNumberPadController.h"
#import "IPStringBackedDecimalValue.h"
#import "IPDecimalNumberPad.h"
#import "UIView+Constraints.h"
#import "CAGradientLayer+IPGradients.h"
#import "UIColor+IPStyle.h"
#import "NSNumberFormatter+IPCurrencySansSymbol.h"

CGFloat const kIPNumberPadBottomConstraintConstant = -83.0;
CGFloat const kIPNumberPadLeftConstraintConstant = 36.0;
CGFloat const kIPNumberPadRightConstraintConstant = -36.0;
CGFloat const kIPNumberPadTopConstraintConstant = -40.0;
CGFloat const kIPNumberPadAspectRatio = 1.0;
CGFloat const kIPAmountLabelToConstraintConstant = -24.0;

@interface IPDecimalNumberPadController () <IPDecimalNumberPadDelegate>

@property (strong, nonatomic) IPStringBackedDecimalValue *currentAmount;

@end

@implementation IPDecimalNumberPadController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackgroundGradient];
    [self setupNumberPad];
    [self setupAmountAndInstructionsLabels];
    self.currentAmount = [[IPStringBackedDecimalValue alloc] init];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.backgroundLayer.frame = self.view.bounds;
}

#pragma mark - Setups

- (void)setupBackgroundGradient {
    self.backgroundLayer = [self greenGradientLayer];
    [self.view.layer insertSublayer:self.backgroundLayer atIndex:0];
}

- (void)setupNumberPad {
    self.numberPad = [[IPDecimalNumberPad alloc] init];
    self.numberPad.delegate = self;
    [self.view addSubview:self.numberPad];
    [self.view constrainViewToBottom:self.numberPad withInset:kIPNumberPadBottomConstraintConstant];
    [self.view constrainViewToLeft:self.numberPad withInset:kIPNumberPadLeftConstraintConstant];
    [self.view constrainViewToRight:self.numberPad withInset:kIPNumberPadRightConstraintConstant];
    [self.view constrainView:self.numberPad toAspectRatio:kIPNumberPadAspectRatio];
}

- (void)setupAmountAndInstructionsLabels {
    self.amountLabel = [[UILabel alloc] init];
    self.amountLabel.font = [UIFont systemFontOfSize:64.0];
    self.amountLabel.textColor = [UIColor whiteColor];
    self.amountLabel.text = @"$";
    self.amountLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.amountLabel];
    [self.view constrainViewToHorizontalEdges:self.amountLabel];
    [self.view constrainView:self.amountLabel aboveView:self.numberPad withOffset:kIPNumberPadTopConstraintConstant];

    self.instructionsLabel = [[UILabel alloc] init];
    self.instructionsLabel.font = [UIFont systemFontOfSize:18.0];
    self.instructionsLabel.textColor = [UIColor whiteColor];
    self.instructionsLabel.text = @"Enter payment amount:";
    self.instructionsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.instructionsLabel];
    [self.view constrainViewToHorizontalEdges:self.instructionsLabel];
    [self.view constrainView:self.instructionsLabel aboveView:self.amountLabel withOffset:kIPAmountLabelToConstraintConstant];
}

#pragma mark - IPDecimalNumberPadDelegate

- (void)decimalNumberPadDidPressDeleteButton:(IPDecimalNumberPad *)decimalNumberPad {
    [self.currentAmount removeDigitFromCurrentValue];
    [self handleCurrentAmountUpdate:self.currentAmount.currentValue];
}

- (void)decimalNumberPadDidPressDecimalPointButton:(IPDecimalNumberPad *)decimalNumberPad {
    [self.currentAmount addDecimalPointToCurrentValue];
    [self handleCurrentAmountUpdate:self.currentAmount.currentValue];
}

- (void)decimalNumberPad:(IPDecimalNumberPad *)decimalNumberPad didSelectValue:(NSUInteger)value {
    [self.currentAmount addDigitToCurrentValue:value];
    [self handleCurrentAmountUpdate:self.currentAmount.currentValue];
}

- (void)handleCurrentAmountUpdate:(NSString *)currentAmount {
    self.amountLabel.text = [NSString stringWithFormat:@"$%@", currentAmount];
}

#pragma mark - Helpers

- (CAGradientLayer *)greenGradientLayer {
    return [CAGradientLayer gradentLayerWithTopColor:[UIColor ipShamrock] bottomColor:[UIColor ipGreenish]];
}

- (NSString *)currentValueFormattedAsPrice {
    return [NSNumberFormatter valueFormattedAsPriceWithNoSymbol:[self.currentAmount.currentValue floatValue]];
}

@end
