//
//  IPDecimalNumberPadController.h
//  Pods
//
//  Created by Nicholas Servidio on 10/26/15.
//
//

#import <UIKit/UIKit.h>
@class IPDecimalNumberPad;

extern UIEdgeInsets const kIPDefaultNumberPadEdgeInsets;

@interface IPDecimalNumberPadController : UIViewController

/**
 *  These edge insets define the distances between the left, bottom and right edges of the number pad and its superview. 
 *  It also defines the distance between the top of the number pad and the bottom of the amount label.
 */
@property (nonatomic) UIEdgeInsets numberPadEdgeInsets;

/**
 *  This label displays the current amount entered with the number pad. 
 *  You can customize this label's appearence, or hide the label and update a different UI element during handleCurrentAmountUpdate:
 */
@property (strong, nonatomic) UILabel *amountLabel;

/**
 *  The controller comes with a custom gradient background out of the box. You can hide this gradient by setting it to nil.
 */
@property (strong, nonatomic) CAGradientLayer *backgroundLayer;

/**
 *  You can customize the appearence of the number pad through its public interface.
 */
@property (strong, nonatomic) IPDecimalNumberPad *numberPad;

@property (nonatomic) NSUInteger maxNumberOfWholeNumberDigitsToDisplay;
@property (nonatomic) NSUInteger maxNumberOfDecimalDigitsToDisplay;

/**
 *  This method is called every time a button on the number pad is pressed. Override to customize the display of the amount or update your data model.
 *
 *  @param currentAmount The current value held by the controller.
 */
- (void)handleCurrentAmountUpdate:(NSString *)currentAmount;

@end
