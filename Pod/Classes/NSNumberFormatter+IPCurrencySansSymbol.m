//
//  NSNumberFormatter+IPCurrencySansSymbol.m
//  Pods
//
//  Created by Nicholas Servidio on 10/26/15.
//
//

#import "NSNumberFormatter+IPCurrencySansSymbol.h"

static NSNumberFormatter *_currencyFormatter;

@implementation NSNumberFormatter (IPCurrencySansSymbol)

+ (NSString *)valueFormattedAsPriceWithNoSymbol:(float)value {
    if (_currencyFormatter == nil) {
        _currencyFormatter = [[NSNumberFormatter alloc] init];
        [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [_currencyFormatter setCurrencySymbol:@""];
    }
    return [_currencyFormatter stringFromNumber:@(value)];
}
@end
