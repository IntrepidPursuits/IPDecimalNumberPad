//
//  UIImage+IPResizing.m
//  Pods
//
//  Created by Nicholas Servidio on 11/20/15.
//
//

#import "UIImage+IPResizing.h"

@implementation UIImage (IPResizing)

- (UIImage *)horizontallyStretchableImage {
    NSInteger horizontalInset = (self.size.width - 1) / 2;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(0, horizontalInset, 0, horizontalInset)];
}

- (UIImage *)verticallyStretchableImage {
    NSInteger verticalInset = (self.size.height - 1) / 2;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(verticalInset, 0, verticalInset, 0)];
}

@end
