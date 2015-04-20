//
//  AssortTipMagazine.m
//  GPUImageDemo
//
//  Created by casa on 4/15/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipMagazine.h"
#import "UIView+LayoutMethods.h"

@interface AssortTipMagazine () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextField *firstLineTextField;
@property (nonatomic, strong) UITextField *secondLineTextField;
@property (nonatomic, strong) UILabel *thirdLineTextField;

@end

@implementation AssortTipMagazine

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.imageView];
        [self addSubview:self.firstLineTextField];
        [self addSubview:self.secondLineTextField];
        [self addSubview:self.thirdLineTextField];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.imageView fill];
    
    [self.firstLineTextField leftInContainer:10 shouldResize:YES];
    [self.firstLineTextField rightInContainer:10 shouldResize:YES];
    self.firstLineTextField.height = 60;
    [self.firstLineTextField bottomInContainer:45 shouldResize:NO];
    
    [self.secondLineTextField leftInContainer:10 shouldResize:YES];
    [self.secondLineTextField rightInContainer:10 shouldResize:YES];
    self.secondLineTextField.height = 15;
    [self.secondLineTextField bottomInContainer:35 shouldResize:NO];
    
    [self.thirdLineTextField sizeToFit];
    CGFloat width = self.thirdLineTextField.width;
    width += 9;
    self.thirdLineTextField.width = width;
    [self.thirdLineTextField centerXEqualToView:self];
    [self.thirdLineTextField bottomInContainer:15 shouldResize:NO];
}

- (void)resetThirdTextField
{
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - event response
- (void)didTappedTextField:(UITextField *)textField
{
    [textField becomeFirstResponder];
}

#pragma mark - getters and setters
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssortMagazine"]];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

- (UITextField *)firstLineTextField
{
    if (_firstLineTextField == nil) {
        _firstLineTextField = [[UITextField alloc] init];
        _firstLineTextField.delegate = self;
        [_firstLineTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _firstLineTextField.textColor = [UIColor whiteColor];
        _firstLineTextField.font = [UIFont systemFontOfSize:50];
        _firstLineTextField.text = @"NiuBility";
        _firstLineTextField.textAlignment = NSTextAlignmentCenter;
        _firstLineTextField.backgroundColor = [UIColor clearColor];
    }
    return _firstLineTextField;
}

- (UITextField *)secondLineTextField
{
    if (_secondLineTextField == nil) {
        _secondLineTextField = [[UITextField alloc] init];
        _secondLineTextField.delegate = self;
        [_secondLineTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _secondLineTextField.textColor = [UIColor whiteColor];
        _secondLineTextField.font = [UIFont systemFontOfSize:12];
        _secondLineTextField.text = @"Life is real, life is earnest, just love it.";
        _secondLineTextField.textAlignment = NSTextAlignmentCenter;
        _secondLineTextField.backgroundColor = [UIColor clearColor];
    }
    return _secondLineTextField;
}

- (UILabel *)thirdLineTextField
{
    if (_thirdLineTextField == nil) {
        _thirdLineTextField = [[UILabel alloc] init];
        _thirdLineTextField.textColor = [UIColor whiteColor];
        _thirdLineTextField.font = [UIFont systemFontOfSize:14];
        _thirdLineTextField.text = @"HANGZHOU";
        _thirdLineTextField.backgroundColor = [UIColor redColor];
        _thirdLineTextField.textAlignment = NSTextAlignmentCenter;
    }
    return _thirdLineTextField;
}

@end
