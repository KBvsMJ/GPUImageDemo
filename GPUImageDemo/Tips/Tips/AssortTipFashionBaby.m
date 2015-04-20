//
//  AssortTipFashionBaby.m
//  GPUImageDemo
//
//  Created by casa on 4/17/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipFashionBaby.h"
#import "UIView+LayoutMethods.h"

@interface AssortTipFashionBaby () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *barCodeImageView;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextView *detailTextView;

@end

@implementation AssortTipFashionBaby

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.barCodeImageView];
        [self addSubview:self.titleTextField];
        [self addSubview:self.detailTextView];
    }
    return self;
}

- (void)layoutSubviews
{
    self.iconImageView.size = CGSizeMake(90, 90);
    [self.iconImageView topInContainer:18 shouldResize:NO];
    [self.iconImageView rightInContainer:18 shouldResize:NO];
    
    self.titleTextField.height = 27;
    [self.titleTextField bottomInContainer:38 shouldResize:NO];
    [self.titleTextField leftInContainer:0 shouldResize:YES];
    [self.titleTextField rightInContainer:0 shouldResize:YES];
    
    self.detailTextView.height = 27;
    [self.detailTextView top:0 FromView:self.titleTextField];
    [self.detailTextView leftInContainer:60 shouldResize:YES];
    [self.detailTextView rightInContainer:100 shouldResize:YES];
    
    self.barCodeImageView.size = CGSizeMake(35, 20);
    [self.barCodeImageView rightInContainer:60 shouldResize:NO];
    [self.barCodeImageView top:5 FromView:self.titleTextField];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.titleTextField) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 10)];
        }
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView scrollRangeToVisible:NSMakeRange(0, 0)];
    if (textView == self.detailTextView) {
        if (textView.text.length > 100) {
            textView.text = [textView.text substringWithRange:NSMakeRange(0, 60)];
        }
    }
}

#pragma mark - event response
- (void)didTappedTextField:(UIView *)textField
{
    [textField becomeFirstResponder];
}

#pragma mark - getters and setters
- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssortTipFashionBabyIcon"]];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _iconImageView;
}

- (UIImageView *)barCodeImageView
{
    if (_barCodeImageView == nil) {
        _barCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssortTipFashionBabyBarcode"]];
        _barCodeImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _barCodeImageView;
}

- (UITextField *)titleTextField
{
    if (_titleTextField == nil) {
        _titleTextField = [[UITextField alloc] init];
        _titleTextField.delegate = self;
        [_titleTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _titleTextField.backgroundColor = [UIColor clearColor];
        _titleTextField.text = @"我的滑板鞋时尚最时尚";
        _titleTextField.textColor = [UIColor whiteColor];
        _titleTextField.font = [UIFont fontWithName:@"FZLanTingHeiS-R-GB" size:23.0f];
        _titleTextField.textAlignment = NSTextAlignmentCenter;
    }
    return _titleTextField;
}

- (UITextView *)detailTextView
{
    if (_detailTextView == nil) {
        _detailTextView = [[UITextView alloc] init];
        _detailTextView.delegate = self;
        _detailTextView.backgroundColor = [UIColor clearColor];
        _detailTextView.text = @"My skateboard shoes is the most fashion in the world.";
        _detailTextView.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        _detailTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:11.0f];
    }
    return _detailTextView;
}

@end
