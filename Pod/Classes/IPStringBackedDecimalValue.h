//
//  IPStringBackedDecimalValue.h
//  Pods
//
//  Created by Nicholas Servidio on 10/26/15.
//
//

#import <Foundation/Foundation.h>

@interface IPStringBackedDecimalValue : NSObject

@property (strong, nonatomic, readonly) NSMutableString *currentValue;
@property (nonatomic) NSUInteger maxNumberOfWholeNumberDigits;
@property (nonatomic) NSUInteger maxNumberOfDecimalDigits;

- (NSString *)currentValueFormattedAsPrice;

- (void)addDigitToCurrentValue:(NSUInteger)digit;
- (void)addDecimalPointToCurrentValue;
- (void)removeDigitFromCurrentValue;
- (BOOL)currentValueContainsDecimalPoint;

@end
