//
//  UIImage+Utils.h
//  HarkLive
//
//  Created by Fly on 15/6/27.
//  Copyright (c) 2015年 Fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

- (UIImage *)fixOrientation;

- (UIImage*)scaleFitOut:(CGSize)size;
- (UIImage*)scaleFitOutForControllerSize:(CGSize)size;


+ (UIImage*)createImageWithColor:(UIColor*)color;

@end
