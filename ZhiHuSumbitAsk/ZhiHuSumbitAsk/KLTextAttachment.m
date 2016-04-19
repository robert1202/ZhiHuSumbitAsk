//
//  KLTextAttachment.m
//  ZhiHuSumbitAsk
//
//  Created by fly on 16/4/18.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "KLTextAttachment.h"

@implementation KLTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer
                      proposedLineFragment:(CGRect)lineFrag
                             glyphPosition:(CGPoint)position
                            characterIndex:(NSUInteger)charIndex {
  CGRect showSize = CGRectZero;
  showSize.size = self.image.size;
  return showSize;
}


- (NSString *)getHtmlFormatFileName{
    return [NSString stringWithFormat:@"<img src=%@ />",self.selectFileName];
}

@end
