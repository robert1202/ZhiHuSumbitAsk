//
//  KLParseEngine.h
//  ZhiHuSumbitAsk
//
//  Created by Fly on 16/4/19.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLParseEngine : NSObject

- (NSAttributedString *)parseToAttributedString:(NSString *)plainString;

@end
