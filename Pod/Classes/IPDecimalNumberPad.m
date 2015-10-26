//
//  IPDecimalNumberPad.m
//  MITMobius
//
//  Created by Nicholas Servidio on 10/21/15.
//  Copyright © 2015 Intrepid-Pursuits. All rights reserved.
//

#import "IPDecimalNumberPad.h"
#import "UIView+Constraints.h"

NSUInteger const kAmountOfColumnDividers = 2;
NSUInteger const kAmountOfRowDividers = 4;

NS_ENUM(NSInteger, MOBButtonTag) {
    MOBButtonTagZero,
    MOBButtonTagOne,
    MOBButtonTagTwo,
    MOBButtonTagThree,
    MOBButtonTagFour,
    MOBButtonTagFive,
    MOBButtonTagSix,
    MOBButtonTagSeven,
    MOBButtonTagEight,
    MOBButtonTagNine,
    MOBButtonTagDecimalPoint,
    MOBButtonTagDelete
};

@interface IPDecimalNumberPad ()

@property (strong, nonatomic) UIButton *deleteButton;

@end

@implementation IPDecimalNumberPad

#pragma mark - Initializers

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.buttonClass = [UIButton class];
    self.backgroundColor = [UIColor clearColor];
    self.columnDividerImage = [self imageFromAssetBundleNamed:@"verticalLine"];
    self.rowDividerImage = [self imageFromAssetBundleNamed:@"horizontalLine"];
    self.deleteButtonImage = [self imageFromAssetBundleNamed:@"backspace"];
    [self setupGeometryWithButtons:[self allButtons] columnDividers:[self columnDividers] rowDividers:[self rowDividers]];
}

#pragma mark - Properties

- (void)setButtonClass:(Class)buttonClass {
    _buttonClass = buttonClass;
    [self resetUI];
}

- (void)setColumnDividerImage:(UIImage *)columnDividerImage {
    _columnDividerImage = columnDividerImage;
    [self resetUI];
}

- (void)setRowDividerImage:(UIImage *)rowDividerImage {
    _rowDividerImage = rowDividerImage;
    [self resetUI];
}

- (void)setDeleteButtonImage:(UIImage *)deleteButtonImage {
    _deleteButtonImage = deleteButtonImage;
    [self.deleteButton setImage:deleteButtonImage forState:UIControlStateNormal];
}

#pragma mark - Configuration

- (void)resetUI {
    [self removeAllSubViews];
    [self setupGeometryWithButtons:[self allButtons] columnDividers:[self columnDividers] rowDividers:[self rowDividers]];
}

- (void)removeAllSubViews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)setupGeometryWithButtons:(NSArray *)buttons columnDividers:(NSArray *)columnDividers rowDividers:(NSArray *)rowDividers {
    for (NSUInteger row = 0; row < buttons.count; row++) {
        NSArray *buttonArray = buttons[row];
        for (NSUInteger column = 0; column < buttonArray.count; column++) {
            UIButton *button = buttonArray[column];
            [self addSubview:button];
            if (column == 0) {
                [self constrainViewToLeft:button];
            } else {
                UIView *columnDivider = columnDividers[column - 1];
                [self addSubview:columnDivider];
                UIButton *previousHorizontalButton = buttonArray[column - 1];
                [self constrainCurrentButton:button toPreviousHorizontalButton:previousHorizontalButton columnDivider:columnDivider];
                if (column == buttonArray.count - 1) {
                    [self constrainViewToRight:button];
                }
            }
        }
        UIButton *firstButtonInRow = ((NSArray *)buttons[row])[0];
        if (row == 0) {
            [self constrainViewToTop:firstButtonInRow];
        } else {
            UIView *rowDivider = rowDividers[row - 1];
            [self addSubview:rowDivider];
            UIButton *firstButtonInPreviousRow = ((NSArray *)buttons[row - 1])[0];
            [self constrainFirstButtonInRow:firstButtonInRow toFirstButtonInPreviousRow:firstButtonInPreviousRow rowDivider:rowDivider];
            if (row == buttons.count - 1) {
                [self constrainViewToBottom:firstButtonInRow];
            }
        }
    }
}

- (void)constrainCurrentButton:(UIButton *)currentButton toPreviousHorizontalButton:(UIButton *)previousHorizontalButton columnDivider:(UIView *)columnDivider {
    [self constrainView:previousHorizontalButton leftOfView:columnDivider];
    [self constrainView:columnDivider toWidth:self.columnDividerImage.size.width];
    [self constrainViewToBottom:columnDivider];
    [self constrainViewToTop:columnDivider];
    [self constrainView:currentButton rightOfView:columnDivider];
    [self constrainView:currentButton toTopOfView:previousHorizontalButton];
    [self constrainView:currentButton toWidthOfView:previousHorizontalButton];
    [self constrainView:currentButton toBottomOfView:previousHorizontalButton];
}

- (void)constrainFirstButtonInRow:(UIButton *)firstButtonInRow toFirstButtonInPreviousRow:(UIButton *)firstButtonInPreviousRow rowDivider:(UIView *)rowDivider {
    [self constrainView:rowDivider belowView:firstButtonInPreviousRow];
    [self constrainView:rowDivider toHeight:self.rowDividerImage.size.height];
    [self constrainViewToHorizontalEdges:rowDivider];
    [self constrainView:firstButtonInRow belowView:rowDivider];
    [self constrainView:firstButtonInRow toHeightOfView:firstButtonInPreviousRow];
}

- (NSArray *)allButtons {
    return @[
             [self buttonsForFirstRow],
             [self buttonsForSecondRow],
             [self buttonsForThirdRow],
             [self buttonsForFourthRow],
             ];
}

- (NSArray *)buttonsForFirstRow {
    UIButton *button1 = [[self.buttonClass alloc] init];

    [button1 setTitle:@"1" forState:UIControlStateNormal];
    button1.tag = MOBButtonTagOne;

    UIButton *button2 = [[self.buttonClass alloc] init];
    [button2 setTitle:@"2" forState:UIControlStateNormal];
    button2.tag = MOBButtonTagTwo;

    UIButton *button3 = [[self.buttonClass alloc] init];
    [button3 setTitle:@"3" forState:UIControlStateNormal];
    button3.tag = MOBButtonTagThree;

    NSArray *buttons = @[button1, button2, button3];
    [self addTargetActionForButtonsInRow:buttons];

    return buttons;
}

- (NSArray *)buttonsForSecondRow {
    UIButton *button1 = [[self.buttonClass alloc] init];
    [button1 setTitle:@"4" forState:UIControlStateNormal];
    button1.tag = MOBButtonTagFour;

    UIButton *button2 = [[self.buttonClass alloc] init];
    [button2 setTitle:@"5" forState:UIControlStateNormal];
    button2.tag = MOBButtonTagFive;

    UIButton *button3 = [[self.buttonClass alloc] init];
    [button3 setTitle:@"6" forState:UIControlStateNormal];
    button3.tag = MOBButtonTagSix;

    NSArray *buttons = @[button1, button2, button3];
    [self addTargetActionForButtonsInRow:buttons];

    return buttons;
}

- (NSArray *)buttonsForThirdRow {
    UIButton *button1 = [[self.buttonClass alloc] init];
    [button1 setTitle:@"7" forState:UIControlStateNormal];
    button1.tag = MOBButtonTagSeven;

    UIButton *button2 = [[self.buttonClass alloc] init];
    [button2 setTitle:@"8" forState:UIControlStateNormal];
    button2.tag = MOBButtonTagEight;

    UIButton *button3 = [[self.buttonClass alloc] init];
    [button3 setTitle:@"9" forState:UIControlStateNormal];
    button3.tag = MOBButtonTagNine;

    NSArray *buttons = @[button1, button2, button3];
    [self addTargetActionForButtonsInRow:buttons];

    return buttons;
}

- (NSArray *)buttonsForFourthRow {
    UIButton *button1 = [[self.buttonClass alloc] init];
    [button1 setTitle:@"." forState:UIControlStateNormal];
    button1.tag = MOBButtonTagDecimalPoint;

    UIButton *button2 = [[self.buttonClass alloc] init];
    [button2 setTitle:@"0" forState:UIControlStateNormal];
    button2.tag = MOBButtonTagZero;

    UIButton *button3 = [[self.buttonClass alloc] init];
    [button3 setImage:[UIImage new] forState:UIControlStateNormal];
    button3.tag = MOBButtonTagDelete;
    self.deleteButton = button3;

    NSArray *buttons = @[button1, button2, button3];
    [self addTargetActionForButtonsInRow:buttons];

    return buttons;
}

- (NSArray *)columnDividers {
    NSMutableArray *columnDividers = [@[] mutableCopy];
    for (NSUInteger i = 0; i < kAmountOfColumnDividers; i++) {
        UIImageView *columnDivider = [[UIImageView alloc] initWithImage:self.columnDividerImage];
        [columnDividers addObject:columnDivider];
    }
    return [columnDividers copy];
}

- (NSArray *)rowDividers {
    NSMutableArray *rowDividers = [@[] mutableCopy];
    for (NSUInteger i = 0; i < kAmountOfRowDividers; i++) {
        UIImageView *rowDivider = [[UIImageView alloc] initWithImage:self.rowDividerImage];
        [rowDividers addObject:rowDivider];
    }
    return [rowDividers copy];
}

- (void)addTargetActionForButtonsInRow:(NSArray *)buttons {
    for (UIButton *button in buttons) {
        [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - Actions

- (void)didTapButton:(UIButton *)sender {
    if (sender.tag == MOBButtonTagDelete) {
        [self.delegate decimalNumberPadDidPressDeleteButton:self];
    } else if (sender.tag == MOBButtonTagDecimalPoint) {
       [self.delegate decimalNumberPadDidPressDecimalPointButton:self];
    } else {
       [self.delegate decimalNumberPad:self didSelectValue:(NSUInteger)sender.tag];
    }
}

#pragma mark - Resources

- (UIImage *)imageFromAssetBundleNamed:(NSString *)imageName {
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"IPDecimalNumberPadAssets" ofType:@"bundle"];
    NSBundle *assetBundle = [NSBundle bundleWithPath:bundlePath];
    return [UIImage imageNamed:imageName inBundle:assetBundle compatibleWithTraitCollection:nil];
}

@end
