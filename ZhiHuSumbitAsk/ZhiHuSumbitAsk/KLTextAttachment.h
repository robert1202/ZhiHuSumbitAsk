//
//  KLTextAttachment.h
//  ZhiHuSumbitAsk
//
//  Created by fly on 16/4/18.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLTextAttachment : NSTextAttachment

@property (copy  , nonatomic) NSString   *selectFileName;
@property (assign, nonatomic) NSUInteger location;

- (NSString *)getHtmlFormatFileName;

@end
