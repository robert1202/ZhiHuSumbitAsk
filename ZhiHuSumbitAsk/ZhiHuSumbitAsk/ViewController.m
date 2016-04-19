//
//  ViewController.m
//  ZhiHuSumbitAsk
//
//  Created by fly on 16/4/14.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+AssemblyAttributedText.h"
#import "UIActionSheet+MKBlockAdditions.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ShowViewController.h"
#import "UIImage+Utils.h"
#import "KLTextContainer.h"
#import "KLTextAttachment.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) KLTextContainer *textContainer;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation ViewController

- (void)loadView{
    TPKeyboardAvoidingScrollView *scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:[UIScreen mainScreen] .applicationFrame];
    self.view = scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showInputContentClick:)];
    
    [self.view addSubview:self.textView];
    UIToolbar *toolbar = [self textViewToolBar];
    self.textView.inputAccessoryView = toolbar;
    
}

- (UIToolbar *)textViewToolBar{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    UIBarButtonItem *hiddenItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_down"] style:UIBarButtonItemStylePlain target:self action:@selector(hiddenKeyboard)];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.hidesWhenStopped = YES;
    self.indicatorView = indicatorView;
    UIBarButtonItem *indicatorItem = [[UIBarButtonItem alloc] initWithCustomView:indicatorView];
    
    UIBarButtonItem *flexible1Item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    
    UIBarButtonItem *imageItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStylePlain target:self action:@selector(imageItemClick)];

    toolBar.items = @[hiddenItem,flexibleItem,indicatorItem,flexible1Item,imageItem];
    return toolBar;
}

- (void)hiddenKeyboard{
    [self.view endEditing:YES];
}

- (void)imageItemClick{
    [self hiddenKeyboard];
    
    [UIActionSheet photoPickerWithTitle:@"选择图片" showInView:self.view presentVC:self onPhotoPicked:^(UIImage *chosenImage) {
        
        [self insertToImage:[chosenImage fixOrientation]];
        
    } onCancel:nil];
}

- (void)showInputContentClick:(id)sender{
    [self hiddenKeyboard];
    
    ShowViewController *pushVC = [[ShowViewController alloc] init];
    [self.navigationController pushViewController:pushVC animated:YES];
    
    [pushVC showAttributedText:self.textView.attributedText];

}

- (void)insertToImage:(UIImage *)image{
    [self.indicatorView startAnimating];

    
    NSUInteger location = self.textView.selectedRange.location;
    
    NSAttributedString *attrString = [self.textContainer assemblyString:self.textView.attributedText insertImage:image atIndex:location];
    self.textView.attributedText = attrString;

    //模拟网络图片上传的可能失败的情况
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.indicatorView stopAnimating];
        
        if (arc4random() % 2 == 1) {
            
            NSDictionary *attributes = @{
                                         NSFontAttributeName : [UIFont systemFontOfSize:16],
                                         };
            self.textView.attributedText = [self.textContainer uploadFailureString:self.textView.attributedText imageAtIndex:location errorAttributes:attributes];
        }
    });
    
    self.textView.selectedRange = NSMakeRange(self.textView.selectedRange.location + 1, 1);
    [self.textView becomeFirstResponder];
    [self.textView scrollRangeToVisible:self.textView.selectedRange];
    
    NSLog(@"%@",self.textView.text);
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _textView;
}

- (KLTextContainer *)textContainer
{
    if (!_textContainer) {
        _textContainer = [[KLTextContainer alloc] init];
        _textContainer.fitImageWidth = SCREEN_WIDTH - 10;
        _textView.font = self.textView.font;
    }
    return _textContainer;
}


@end
