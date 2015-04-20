//
//  AssortTipFashionBaby.m
//  GPUImageDemo
//
//  Created by casa on 4/17/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipFashionBaby.h"
#import "UIView+LayoutMethods.h"

@interface AssortTipFashionBaby () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *barCodeImageView;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextField *detailTextField;

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
        [self addSubview:self.detailTextField];
    }
    return self;
}

- (void)layoutSubviews
{
    self.iconImageView.size = CGSizeMake(90, 90);
    [self.iconImageView topInContainer:18 shouldResize:NO];
    [self.iconImageView rightInContainer:18 shouldResize:NO];
    
    self.barCodeImageView.size = CGSizeMake(35, 20);
    [self.barCodeImageView bottomInContainer:18 shouldResize:NO];
    [self.barCodeImageView rightInContainer:24 shouldResize:NO];
    
    self.titleTextField.height = 27;
    [self.titleTextField bottomInContainer:38 shouldResize:NO];
    [self.titleTextField leftInContainer:0 shouldResize:YES];
    [self.titleTextField rightInContainer:0 shouldResize:YES];
    
    self.detailTextField.height = 8;
    [self.detailTextField bottomInContainer:18 shouldResize:NO];
    [self.detailTextField leftInContainer:0 shouldResize:YES];
    [self.detailTextField rightInContainer:100 shouldResize:YES];
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
    
    if (textField == self.detailTextField) {
        if (textField.text.length > 40) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 40)];
        }
    }
}

#pragma mark - event response
- (void)didTappedTextField:(UITextField *)textField
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
        _titleTextField.font = [UIFont fontWithName:@"STHeitiSC-Light" size:27.0f];
        _titleTextField.textAlignment = NSTextAlignmentCenter;
    }
    return _titleTextField;
}

- (UITextField *)detailTextField
{
    if (_detailTextField == nil) {
        _detailTextField = [[UITextField alloc] init];
        _detailTextField.delegate = self;
        [_detailTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _detailTextField.backgroundColor = [UIColor clearColor];
        _detailTextField.text = @"My skateboard shoes is the most fashion in the world.";
        _detailTextField.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        _detailTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:11.0f];
    }
    return _detailTextField;
}

@end
