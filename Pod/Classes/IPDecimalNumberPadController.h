//
//  IPDecimalNumberPadController.h
//  Pods
//
//  Created by Nicholas Servidio on 10/26/15.
//
//

#import <UIKit/UIKit.h>
@class IPDecimalNumberPad;

@interface IPDecimalNumberPadController : UIViewController

@property (strong, nonatomic) UILabel *instructionsLabel;
@property (strong, nonatomic) UILabel *amountLabel;
@property (strong, nonatomic) IPDecimalNumberPad *numberPad;
@property (strong, nonatomic) CAGradientLayer *backgroundLayer;

/**
 *  This method is called every time a button on the number pad is pressed. Override to customize the display of the amount or update your data model.
 *
 *  @param currentAmount The current value held by the controller.
 */
- (void)handleCurrentAmountUpdate:(NSString *)currentAmount;

@end
