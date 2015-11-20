//
//  IPDecimalNumberPad.h
//  MITMobius
//
//  Created by Nicholas Servidio on 10/21/15.
//  Copyright © 2015 Intrepid-Pursuits. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IPDecimalNumberPadDelegate;

/**
 *  A number pad control consisting of digits 0-9, a decimal point and a delete button.
 */
@interface IPDecimalNumberPad : UIControl

@property (weak, nonatomic) id<IPDecimalNumberPadDelegate> delegate;

/**
 *  This class will be used to instantiate the buttons for the number pad.
 */
@property (nonatomic) Class buttonClass;

@property (strong, nonatomic) UIImage *rowDividerImage;
@property (strong, nonatomic) UIImage *columnDividerImage;
@property (strong, nonatomic) UIImage *deleteButtonImage;

@property (nonatomic) CGFloat rowDividerInset;
@property (nonatomic) CGFloat columnDividerInset;

@end

@protocol IPDecimalNumberPadDelegate <NSObject>

- (void)decimalNumberPadDidPressDeleteButton:(IPDecimalNumberPad *)decimalNumberPad;
- (void)decimalNumberPadDidPressDecimalPointButton:(IPDecimalNumberPad *)decimalNumberPad;
- (void)decimalNumberPad:(IPDecimalNumberPad *)decimalNumberPad didSelectValue:(NSUInteger)value;

@end
