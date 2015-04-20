//
//  AssortTipNewsPerson.m
//  GPUImageDemo
//
//  Created by casa on 4/16/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipNewsPerson.h"
#import "UIView+LayoutMethods.h"

@interface AssortTipNewsPerson () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *labelGroundImageView;

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextField *speakTextField;

@end

@implementation AssortTipNewsPerson

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.labelGroundImageView];
        [self.labelGroundImageView addSubview:self.titleTextField];
        [self.labelGroundImageView addSubview:self.nameTextField];
        [self addSubview:self.speakTextField];
    }
    return self;
}

- (void)layoutSubviews
{
    self.iconImageView.size = CGSizeMake(75, 29);
    [self.iconImageView leftInContainer:18 shouldResize:NO];
    [self.iconImageView topInContainer:18 shouldResize:NO];
    
    self.labelGroundImageView.size = CGSizeMake(278, 35);
    [self.labelGroundImageView leftInContainer:18 shouldResize:NO];
    [self.labelGroundImageView bottomInContainer:45 shouldResize:NO];
    
    self.nameTextField.height = 23;
    [self.nameTextField leftInContainer:37 shouldResize:YES];
    [self.nameTextField rightInContainer:160 shouldResize:YES];
    [self.nameTextField centerYEqualToView:self.labelGroundImageView];
    
    self.titleTextField.height = 14;
    [self.titleTextField leftInContainer:126 shouldResize:YES];
    [self.titleTextField rightInContainer:0 shouldResize:YES];
    [self.titleTextField bottomEqualToView:self.nameTextField];
    
    self.speakTextField.height = 23;
    [self.speakTextField leftInContainer:18 shouldResize:YES];
    [self.speakTextField rightInContainer:0 shouldResize:YES];
    [self.speakTextField bottomInContainer:18 shouldResize:NO];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.nameTextField) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 6)];
        }
    }
    
    if (textField == self.titleTextField) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 10)];
        }
    }
    
    if (textField == self.speakTextField) {
        if (textField.text.length > 18) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 18)];
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
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssortTipNewsPersonIcon"]];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _iconImageView;
}

- (UIImageView *)labelGroundImageView
{
    if (_labelGroundImageView == nil) {
        _labelGroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssortTipNewsPersonLabelBackground"]];
        _labelGroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        _labelGroundImageView.userInteractionEnabled = YES;
        _labelGroundImageView.backgroundColor = [UIColor clearColor];
    }
    return _labelGroundImageView;
}

- (UITextField *)nameTextField
{
    if (_nameTextField == nil) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.delegate = self;
        [_nameTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _nameTextField.textColor = [UIColor whiteColor];
        _nameTextField.textAlignment = NSTextAlignmentCenter;
        _nameTextField.font = [UIFont systemFontOfSize:22];
        _nameTextField.text = @"JackMa";
        _nameTextField.backgroundColor = [UIColor clearColor];
    }
    return _nameTextField;
}

- (UITextField *)titleTextField
{
    if (_titleTextField == nil) {
        _titleTextField = [[UITextField alloc] init];
        _titleTextField.delegate = self;
        [_titleTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _titleTextField.textColor = [UIColor whiteColor];
        _titleTextField.textAlignment = NSTextAlignmentLeft;
        _titleTextField.font = [UIFont systemFontOfSize:13];
        _titleTextField.text = @"阿里巴巴董事局主席";
        _titleTextField.backgroundColor = [UIColor clearColor];
    }
    return _titleTextField;
}

- (UITextField *)speakTextField
{
    if (_speakTextField == nil) {
        _speakTextField = [[UITextField alloc] init];
        _speakTextField.delegate = self;
        [_speakTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _speakTextField.textColor = [UIColor whiteColor];
        _speakTextField.textAlignment = NSTextAlignmentLeft;
        _speakTextField.font = [UIFont systemFontOfSize:16];
        _speakTextField.text = @"很轻松 很有意思 很Duang~";
        _speakTextField.backgroundColor = [UIColor clearColor];
    }
    return _speakTextField;
}

@end
