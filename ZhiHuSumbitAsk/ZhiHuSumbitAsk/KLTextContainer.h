//
//  KLTextContainer.h
//  ZhiHuSumbitAsk
//
//  Created by fly on 16/4/14.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLTextContainer : NSObject

@property (nonatomic, strong) UIFont  *font;
@property (nonatomic, assign) CGFloat fitImageWidth;

- (NSAttributedString *)assemblyString:(NSAttributedString *)attributedText insertImage:(UIImage *)image atIndex:(NSUInteger)loc;

- (NSAttributedString *)assemblyString:(NSAttributedString *)attributedText replaceImage:(UIImage *)image replaceInRange:(NSRange)range;

- (NSAttributedString *)uploadFailureString:(NSAttributedString *)attributedText imageAtIndex:(NSUInteger)loc errorAttributes:(nullable NSDictionary<NSString *, id> *)attrs;

@end
NS_ASSUME_NONNULL_END