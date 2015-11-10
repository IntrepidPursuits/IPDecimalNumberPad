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

UIEdgeInsets const kIPDefaultNumberPadEdgeInsets = (UIEdgeInsets){40.0, 36.0, 83.0, 36.0};

CGFloat const kIPNumberPadAspectRatio = 1.0;

NSUInteger kIPDefaultNumberOfWholeNumberDigits = 4;
NSUInteger kIPDefaultNumberOfDecimalDigits = 2;

@interface IPDecimalNumberPadController () <IPDecimalNumberPadDelegate>

@property (strong, nonatomic) IPStringBackedDecimalValue *currentAmount;
@property (strong, nonatomic) NSLayoutConstraint *numberPadTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *numberPadLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *numberPadBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *numberPadRightConstraint;

@end

@implementation IPDecimalNumberPadController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCurrentAmount];
    [self setupBackgroundGradient];
    [self setupAmountLabel];
    [self setupNumberPad];
    [self setNumberPadEdgeInsets:kIPDefaultNumberPadEdgeInsets];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.backgroundLayer.frame = self.view.bounds;
}

#pragma mark - Properties 

- (void)setNumberPadEdgeInsets:(UIEdgeInsets)numberPadEdgeInsets {
    _numberPadEdgeInsets = numberPadEdgeInsets;
    [self configureNumberPadConstraintsForEdgeInsets:numberPadEdgeInsets];
}

- (void)setMaxNumberOfWholeNumberDigitsToDisplay:(NSUInteger)maxNumberOfWholeNumberDigitsToDisplay {
    _maxNumberOfWholeNumberDigitsToDisplay = maxNumberOfWholeNumberDigitsToDisplay;
    self.currentAmount.maxNumberOfWholeNumberDigits = _maxNumberOfWholeNumberDigitsToDisplay;
}

- (void)setMaxNumberOfDecimalDigitsToDisplay:(NSUInteger)maxNumberOfDecimalDigitsToDisplay {
    _maxNumberOfDecimalDigitsToDisplay = maxNumberOfDecimalDigitsToDisplay;
    self.currentAmount.maxNumberOfDecimalDigits = _maxNumberOfDecimalDigitsToDisplay;
}

- (void)configureNumberPadConstraintsForEdgeInsets:(UIEdgeInsets)edgeInsets {
    self.numberPadTopConstraint.constant = -edgeInsets.top;
    self.numberPadLeftConstraint.constant = edgeInsets.left;
    self.numberPadBottomConstraint.constant = -edgeInsets.bottom;
    self.numberPadRightConstraint.constant = -edgeInsets.right;
}

#pragma mark - Setups

- (void)setupCurrentAmount {
    self.currentAmount = [[IPStringBackedDecimalValue alloc] init];
    self.maxNumberOfWholeNumberDigitsToDisplay = kIPDefaultNumberOfWholeNumberDigits;
    self.maxNumberOfDecimalDigitsToDisplay = kIPDefaultNumberOfDecimalDigits;
}

- (void)setupBackgroundGradient {
    self.backgroundLayer = [self greenGradientLayer];
    [self.view.layer insertSublayer:self.backgroundLayer atIndex:0];
}

- (void)setupAmountLabel {
    self.amountLabel = [[UILabel alloc] init];
    self.amountLabel.font = [UIFont systemFontOfSize:64.0];
    self.amountLabel.textColor = [UIColor whiteColor];
    self.amountLabel.text = @"$";
    self.amountLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.amountLabel];
    [self.view constrainViewToHorizontalEdges:self.amountLabel];
}

- (void)setupNumberPad {
    self.numberPad = [[IPDecimalNumberPad alloc] init];
    self.numberPad.delegate = self;
    [self.view addSubview:self.numberPad];
    [self setupNumberPadConstraints];
    [self configureNumberPadConstraintsForEdgeInsets:kIPDefaultNumberPadEdgeInsets];
}

- (void)setupNumberPadConstraints {
    self.numberPadTopConstraint = [self.view constrainView:self.amountLabel aboveView:self.numberPad];
    self.numberPadLeftConstraint = [self.view constrainViewToLeft:self.numberPad];
    self.numberPadBottomConstraint = [self.view constrainViewToBottom:self.numberPad];
    self.numberPadRightConstraint = [self.view constrainViewToRight:self.numberPad];
    [self.view constrainView:self.numberPad toAspectRatio:kIPNumberPadAspectRatio];
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

@end
