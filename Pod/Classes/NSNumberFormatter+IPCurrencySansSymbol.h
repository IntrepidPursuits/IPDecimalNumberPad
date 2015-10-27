//
//  NSNumberFormatter+IPCurrencySansSymbol.h
//  Pods
//
//  Created by Nicholas Servidio on 10/26/15.
//
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (IPCurrencySansSymbol)

+ (NSString *)valueFormattedAsPriceWithNoSymbol:(float)value;

@end
