//
// Created by zorro on 15/3/7.
// Copyright (c) 2015 tutuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+KLTextAttachment.h"
#import "KLTextAttachment.h"

@implementation NSAttributedString (KLTextAttachment)

- (NSString *)getPlainString {
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;

    [self enumerateAttribute:NSAttachmentAttributeName
                     inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      if (value && [value isKindOfClass:[KLTextAttachment class]]) {
                          
                          KLTextAttachment *attachment = (KLTextAttachment *)value;
                          NSString *imgName = [attachment getHtmlFormatFileName];
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base,range.length)
                           withString:imgName];
                          base += imgName.length - 1;
                      }
                  }];

    return plainString;
}


@end