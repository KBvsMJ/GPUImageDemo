//
//  AssortTipRound.m
//  GPUImageDemo
//
//  Created by casa on 4/20/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipRound.h"
#import "UIView+LayoutMethods.h"

@interface AssortTipRound () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *firstWordTextField;
@property (nonatomic, strong) UITextField *secondWordTextField;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *fashionBoyImageView;
@property (nonatomic, strong) UILabel *cityNameLabel;
@property (nonatomic, strong) UITextField *detailTextField;

@end

@implementation AssortTipRound

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.firstWordTextField];
        [self addSubview:self.secondWordTextField];
        [self addSubview:self.fashionBoyImageView];
        [self addSubview:self.cityNameLabel];
        [self addSubview:self.detailTextField];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.backgroundImageView fill];
    
    [self.firstWordTextField sizeToFit];
    [self.firstWordTextField leftInContainer:0 shouldResize:NO];
    [self.firstWordTextField topInContainer:13 shouldResize:NO];
    
    [self.secondWordTextField sizeToFit];
    [self.secondWordTextField leftInContainer:35 shouldResize:NO];
    [self.secondWordTextField topInContainer:44 shouldResize:NO];
    
    self.fashionBoyImageView.size = CGSizeMake(65, 65);
    [self.fashionBoyImageView leftInContainer:245 shouldResize:NO];
    [self.fashionBoyImageView topInContainer:222 shouldResize:NO];
    
    self.cityNameLabel.height = 16;
    [self.cityNameLabel topInContainer:320 shouldResize:NO];
    [self.cityNameLabel leftInContainer:0 shouldResize:YES];
    [self.cityNameLabel rightInContainer:0 shouldResize:YES];
    
    self.detailTextField.height = 13;
    [self.detailTextField top:3 FromView:self.cityNameLabel];
    [self.detailTextField leftInContainer:0 shouldResize:YES];
    [self.detailTextField rightInContainer:0 shouldResize:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger textLength = 20;
    if (textField == self.firstWordTextField) {
        textLength = 1;
    }
    
    if (textField == self.secondWordTextField) {
        textLength = 1;
    }
    
    if (textField == self.detailTextField) {
        textLength = 30;
    }
    
    if (textField.text.length > textLength) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, textLength)];
    }
}

#pragma mark - event response
- (void)didTappedTextField:(UITextField *)textField
{
    [textField becomeFirstResponder];
}

#pragma mark - getters and setters
- (UITextField *)firstWordTextField
{
    if (_firstWordTextField == nil) {
        _firstWordTextField = [[UITextField alloc] init];
        _firstWordTextField.delegate = self;
        [_firstWordTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _firstWordTextField.text = @"良";
        _firstWordTextField.textColor = [UIColor blackColor];
        _firstWordTextField.font = [UIFont fontWithName:@"FZQiTi-S14T" size:75];
    }
    return _firstWordTextField;
}

- (UITextField *)secondWordTextField
{
    if (_secondWordTextField == nil) {
        _secondWordTextField = [[UITextField alloc] init];
        _secondWordTextField.delegate = self;
        [_secondWordTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _secondWordTextField.text = @"品";
        _secondWordTextField.textColor = [UIColor blackColor];
        _secondWordTextField.font = [UIFont fontWithName:@"FZQiTi-S14T" size:75];
    }
    return _secondWordTextField;
}

- (UIImageView *)backgroundImageView
{
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssortTipRoundbackground"]];
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backgroundImageView;
}

- (UIImageView *)fashionBoyImageView
{
    if (_fashionBoyImageView == nil) {
        _fashionBoyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssortTipFashionBabyIcon"]];
        _fashionBoyImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _fashionBoyImageView;
}

- (UILabel *)cityNameLabel
{
    if (_cityNameLabel == nil) {
        _cityNameLabel = [[UILabel alloc] init];
        _cityNameLabel.textColor = [UIColor blackColor];
        _cityNameLabel.text = @"HANGZHOU";
        _cityNameLabel.font = [UIFont systemFontOfSize:15];
        _cityNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cityNameLabel;
}

- (UITextField *)detailTextField
{
    if (_detailTextField == nil) {
        _detailTextField = [[UITextField alloc] init];
        _detailTextField.delegate = self;
        [_detailTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _detailTextField.textAlignment = NSTextAlignmentCenter;
        _detailTextField.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1];
        _detailTextField.text = @"Life is real, life is earnist, just love it.";
        _detailTextField.font = [UIFont systemFontOfSize:12];
    }
    return _detailTextField;
}

@end
