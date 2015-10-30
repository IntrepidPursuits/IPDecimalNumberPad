//
//  IPStringBackedDecimalValue.m
//  Pods
//
//  Created by Nicholas Servidio on 10/26/15.
//
//

#import "IPStringBackedDecimalValue.h"
#import "NSNumberFormatter+IPCurrencySansSymbol.h"

NSUInteger const kIPDefaultMaxNumberOfWholeNumberDigits = 3;
NSUInteger const kIPDefaultMaxNumberOfDecimalDigits = 2;

@interface IPStringBackedDecimalValue ()

@property (strong, nonatomic, readwrite) NSMutableString *currentValue;

@end

@implementation IPStringBackedDecimalValue

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentValue = [@"" mutableCopy];
        _maxNumberOfWholeNumberDigits = kIPDefaultMaxNumberOfWholeNumberDigits;
        _maxNumberOfDecimalDigits = kIPDefaultMaxNumberOfDecimalDigits;
    }
    return self;
}

- (void)addDigitToCurrentValue:(NSUInteger)digit {
    if ([self canAddDigitToCurrentValue:digit]) {
        [self.currentValue appendString:[NSString stringWithFormat:@"%ld", digit]];
    }
}

- (void)addDecimalPointToCurrentValue {
    if ([self canAddDecimalPointToCurrentValue]) {
        if (self.currentValue.length == 0) {
            [self addDigitToCurrentValue:0];
        }
        [self.currentValue appendString:@"."];
    }
}

- (void)removeDigitFromCurrentValue {
    if ([self canRemoveDigitFromCurrentValue]) {
        [self.currentValue deleteCharactersInRange:NSMakeRange(self.currentValue.length - 1, 1)];
    }
}

#pragma mark - Helpers

- (BOOL)canAddDigitToCurrentValue:(NSUInteger)digit {
    return (![self currentValueContainsDecimalPoint] && [self canAddDigitToWholeNumber]) || ([self currentValueContainsDecimalPoint] && [self canAddDigitToDecimalNumber]);
}

- (BOOL)canAddDecimalPointToCurrentValue {
    return ![self currentValueContainsDecimalPoint];
}

- (BOOL)canRemoveDigitFromCurrentValue {
    return self.currentValue.length > 0;
}

- (BOOL)canAddDigitToWholeNumber {
    return  [self amountOfWholeNumberDigits] + 1 <= self.maxNumberOfWholeNumberDigits && ![self firstDigitIsZero];
}

- (BOOL)canAddDigitToDecimalNumber {
    return [self amountOfDecimalDigits] + 1 <= self.maxNumberOfDecimalDigits;
}

- (BOOL)firstDigitIsZero {
    if (self.currentValue.length > 0) {
        return [[self.currentValue substringToIndex:1] isEqualToString:@"0"];
    }
    return NO;
}

- (BOOL)currentValueContainsDecimalPoint {
    return [self.currentValue containsString:@"."];
}

- (NSUInteger)amountOfWholeNumberDigits {
    NSArray *amountArray = [self.currentValue componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSString *wholeNumber = amountArray.count > 0 ? [amountArray firstObject] : nil;
    return wholeNumber.length;
}

- (NSUInteger)amountOfDecimalDigits {
    NSArray *amountArray = [self.currentValue componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSString *decimal = amountArray.count > 1 ? [amountArray lastObject] : nil;
    return decimal.length;
}

@end
