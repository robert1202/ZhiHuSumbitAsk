//
//  KLParseEngine.m
//  ZhiHuSumbitAsk
//
//  Created by Fly on 16/4/19.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "KLParseEngine.h"

@implementation KLParseEngine

+ (NSString *)parseToAttributedString:(NSString *)plainString{
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:
                                  @"<img(\\S*?)[^>]*>.*?</>|<img.*? />" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *resultList = [regex matchesInString:plainString options:NSMatchingReportProgress range:NSMakeRange(0, [plainString length])];
    NSLog(@"%@",resultList);
    NSMutableString *mutableStr = [plainString mutableCopy];
    
    NSLog(@"plainString ＝ %@",plainString);

    for (NSTextCheckingResult *result in resultList) {
        [mutableStr replaceCharactersInRange:result.range withString:@"[上传图片]"];
    }
    NSLog(@"mutableStr ＝ %@",mutableStr);

    return mutableStr;
}

@end
