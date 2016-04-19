//
//  KLTextContainer.m
//  ZhiHuSumbitAsk
//
//  Created by fly on 16/4/14.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "KLTextContainer.h"
#import "KLTextAttachment.h"

@implementation KLTextContainer

#pragma mark - LifeCycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.font = [UIFont systemFontOfSize:14];
        self.fitImageWidth = ([UIScreen mainScreen].bounds.size.width);
    }
    return self;
}

#pragma mark - Public

- (NSAttributedString *)assemblyString:(NSAttributedString *)attributedText insertImage:(UIImage *)image atIndex:(NSUInteger)loc{
    return [self assemblyString:attributedText replaceImage:image replaceInRange:NSMakeRange(loc, 0)];
}

- (NSAttributedString *)assemblyString:(NSAttributedString *)attributedText replaceImage:(UIImage *)image replaceInRange:(NSRange)range{
    NSMutableAttributedString *attributedString = nil;
    if (!attributedText) {
        attributedString = [[NSMutableAttributedString alloc] init];
    }else{
        attributedString = [attributedText mutableCopy];
    }
    
    KLTextAttachment *imgAttachment = [self getImageAttachment:image];
    if (imgAttachment) {
        NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:imgAttachment];
        [attributedString replaceCharactersInRange:range withAttributedString:attrStringWithImage];
        imgAttachment.location = range.location;
    }
    [attributedString addAttributes:@{NSFontAttributeName:self.font} range:NSMakeRange(0, [attributedString.string length])];
    return attributedString;
}

- (NSAttributedString *)uploadFailureString:(NSAttributedString *)attributedText imageAtIndex:(NSUInteger)loc errorAttributes:(nullable NSDictionary<NSString *, id> *)attrs{
    NSMutableAttributedString *attributedString = [attributedText mutableCopy];
    if (!attributedString) {
        return attributedText;
    }
    
    NSAttributedString *failureString = [[NSAttributedString alloc] initWithString:@"[上传失败]" attributes:attrs];
    
    [attributedString replaceCharactersInRange:NSMakeRange(loc, 1) withAttributedString:failureString];

    return attributedString;
}

#pragma mark - Private

- (KLTextAttachment *)getImageAttachment:(UIImage *)image{
    if (!image) {
        return nil;
    }
    KLTextAttachment *textAttachment = [[KLTextAttachment alloc] init];
    textAttachment.image = image;
    NSString *fileName = [NSString stringWithFormat:@"%@/%@/%@/%@.jpg", @"xiangxuedev/img",@"companyId", @"userId", [[NSUUID UUID] UUIDString]];
    textAttachment.selectFileName = fileName;
    
    CGFloat oldWidth = textAttachment.image.size.width;
    CGFloat scaleFactor = oldWidth / _fitImageWidth;
    
    textAttachment.image = [UIImage imageWithCGImage:image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
    
    return textAttachment;
}

@end
