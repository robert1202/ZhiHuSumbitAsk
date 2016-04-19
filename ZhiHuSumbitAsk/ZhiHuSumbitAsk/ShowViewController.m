//
//  ShowViewController.m
//  ZhiHuSumbitAsk
//
//  Created by fly on 16/4/14.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "ShowViewController.h"
#import "UIView+ViewUtils.h"
#import "NSAttributedString+KLTextAttachment.h"
#import "KLParseEngine.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ShowViewController()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ShowViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.label];
    
}

- (void)showAttributedText:(NSAttributedString *)attributedText{
    NSString *plainString = [NSString stringWithFormat:@"转义过的内容:\n%@\n\n富文本的显示方式:\n",[attributedText getPlainString]];
    
    NSString *showString = [KLParseEngine parseToAttributedString:plainString];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[plainString stringByAppendingFormat:@"\nShowString:\n%@",showString]];
    
    [attributedString appendAttributedString:attributedText];
    
    self.label.attributedText = attributedString;
    
    self.label.width = SCREEN_WIDTH - 20;
    self.label.left = 10;
    [self.label sizeToFit];
    self.scrollView.contentSize = CGSizeMake(0, self.label.bottom + 10);
}

- (UILabel *)label
{
    if (!_label) {
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 64 - 10)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16.0f];
        label.numberOfLines = 0;
        label.preferredMaxLayoutWidth = SCREEN_WIDTH - 20;
        
        
        _label = label;
    }
    return _label;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _scrollView;
}



@end
