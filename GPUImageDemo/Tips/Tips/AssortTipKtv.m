//
//  AssortTipKtv.m
//  GPUImageDemo
//
//  Created by casa on 4/15/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipKtv.h"
#import "UIView+LayoutMethods.h"

@interface AssortTipKtv () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *lyricLine1TextField;
@property (nonatomic, strong) UITextField *lyricLine2TextField;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation AssortTipKtv

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.lyricLine1TextField];
        [self addSubview:self.lyricLine2TextField];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.lyricLine1TextField leftInContainer:80 shouldResize:YES];
    [self.lyricLine1TextField rightInContainer:10 shouldResize:YES];
    self.lyricLine1TextField.height = 20;
    [self.lyricLine1TextField bottomInContainer:25 shouldResize:NO];
    
    [self.lyricLine2TextField leftInContainer:10 shouldResize:YES];
    [self.lyricLine2TextField rightInContainer:10 shouldResize:YES];
    self.lyricLine2TextField.height = 20;
    [self.lyricLine2TextField bottomInContainer:2 shouldResize:NO];
    
    self.imageView.size = CGSizeMake(35, 14);
    [self.imageView leftInContainer:27 shouldResize:NO];
    [self.imageView centerYEqualToView:self.lyricLine1TextField];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.lyricLine1TextField) {
        if (textField.text.length > 15) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 4)];
        }
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textField.text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:192.0f/255.0f blue:55.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 2)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(2, textField.text.length - 2)];
        self.lyricLine1TextField.attributedText = attributedString;
    }
    
    if (textField == self.lyricLine2TextField) {
        if (textField.text.length > 15) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 20)];
        }
    }
}

#pragma mark - event response
- (void)didTappedTextField:(UITextField *)textField
{
    [textField becomeFirstResponder];
}

#pragma mark - getters and setters
- (UITextField *)lyricLine1TextField
{
    if (_lyricLine1TextField == nil) {
        _lyricLine1TextField = [[UITextField alloc] init];
        [_lyricLine1TextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _lyricLine1TextField.textAlignment = NSTextAlignmentLeft;
        _lyricLine1TextField.userInteractionEnabled = YES;
        _lyricLine1TextField.delegate = self;
        _lyricLine1TextField.enabled = YES;
        _lyricLine1TextField.backgroundColor = [UIColor clearColor];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"爱在迷迷糊糊盘古初开便开始"];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:192.0f/255.0f blue:55.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 2)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(2, attributedString.length - 2)];
        _lyricLine1TextField.attributedText = attributedString;
    }
    return _lyricLine1TextField;
}

- (UITextField *)lyricLine2TextField
{
    if (_lyricLine2TextField == nil) {
        _lyricLine2TextField = [[UITextField alloc] init];
        [_lyricLine2TextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _lyricLine2TextField.textAlignment = NSTextAlignmentRight;
        _lyricLine2TextField.text = @"这浪浪漫漫旧故事";
        _lyricLine2TextField.userInteractionEnabled = YES;
        _lyricLine2TextField.delegate = self;
        _lyricLine2TextField.enabled = YES;
        _lyricLine2TextField.textColor = [UIColor whiteColor];
        _lyricLine2TextField.backgroundColor = [UIColor clearColor];
    }
    return _lyricLine2TextField;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssortKtv"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end
