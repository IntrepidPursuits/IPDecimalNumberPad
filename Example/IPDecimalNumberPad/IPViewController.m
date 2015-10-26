//
//  IPViewController.m
//  IPDecimalNumberPad
//
//  Created by Nick Servidio on 10/23/2015.
//  Copyright (c) 2015 Nick Servidio. All rights reserved.
//

#import "IPViewController.h"
#import "IPDecimalNumberPad.h"

@interface IPViewController () <IPDecimalNumberPadDelegate>

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet IPDecimalNumberPad *numberPad;

@end

@implementation IPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberPad.delegate = self;
    self.numberLabel.text = @"";
}

- (void)decimalNumberPadDidPressDeleteButton:(IPDecimalNumberPad *)decimalNumberPad {
    [self removeCharacterFromNumberLabel];
}

- (void)decimalNumberPadDidPressDecimalPointButton:(IPDecimalNumberPad *)decimalNumberPad {
    [self addCharacterToNumberLabel:@"."];
}

- (void)decimalNumberPad:(IPDecimalNumberPad *)decimalNumberPad didSelectValue:(NSUInteger)value {
    [self addCharacterToNumberLabel:[NSString stringWithFormat:@"%ld", value]];
}

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
