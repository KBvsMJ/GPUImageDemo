//
//  AssortTipTimes.m
//  GPUImageDemo
//
//  Created by casa on 4/16/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipTimes.h"
#import "UIView+LayoutMethods.h"

@interface AssortTipTimes () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *leftBar;
@property (nonatomic, strong) UIView *rightBar;
@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIView *bottomBar;

@property (nonatomic, strong) UILabel *timesLabel;
@property (nonatomic, strong) UILabel *itisLabel;

@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextField *subtitleTextField;
@property (nonatomic, strong) UITextField *detailTextField;

@end

@implementation AssortTipTimes

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.leftBar];
        [self addSubview:self.rightBar];
        [self addSubview:self.topBar];
        [self addSubview:self.bottomBar];
        
        [self addSubview:self.timesLabel];
        [self addSubview:self.itisLabel];
        
        [self addSubview:self.titleTextField];
        [self addSubview:self.subtitleTextField];
        [self addSubview:self.detailTextField];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat barWidth = 10;
    
    self.leftBar.width = barWidth;
    [self.leftBar leftInContainer:0 shouldResize:NO];
    [self.leftBar topInContainer:0 shouldResize:YES];
    [self.leftBar bottomInContainer:0 shouldResize:YES];
    
    self.rightBar.width = barWidth;
    [self.rightBar rightInContainer:0 shouldResize:NO];
    [self.rightBar topInContainer:0 shouldResize:YES];
    [self.rightBar bottomInContainer:0 shouldResize:YES];
    
    self.topBar.height = barWidth;
    [self.topBar topInContainer:0 shouldResize:YES];
    [self.topBar leftInContainer:0 shouldResize:YES];
    [self.topBar rightInContainer:0 shouldResize:YES];
    
    self.bottomBar.height = barWidth;
    [self.bottomBar bottomInContainer:0 shouldResize:NO];
    [self.bottomBar leftInContainer:0 shouldResize:YES];
    [self.bottomBar rightInContainer:0 shouldResize:YES];
    
    [self.timesLabel sizeToFit];
    [self.timesLabel top:0 FromView:self.topBar];
    [self.timesLabel centerXEqualToView:self];
    
    [self.itisLabel sizeToFit];
    [self.itisLabel right:10 FromView:self.leftBar];
    [self.itisLabel bottomInContainer:100 shouldResize:NO];
    
    self.titleTextField.height = 31;
    [self.titleTextField leftEqualToView:self.itisLabel];
    [self.titleTextField top:3 FromView:self.itisLabel];
    [self.titleTextField rightInContainer:20 shouldResize:YES];
    
    self.subtitleTextField.height = 31;
    [self.subtitleTextField leftEqualToView:self.itisLabel];
    [self.subtitleTextField top:3 FromView:self.titleTextField];
    [self.subtitleTextField rightInContainer:20 shouldResize:YES];
    
    self.detailTextField.height = 20;
    [self.detailTextField right:11 FromView:self.leftBar];
    [self.detailTextField top:2 FromView:self.subtitleTextField];
    [self.detailTextField rightInContainer:20 shouldResize:YES];
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
        if (textField.text.length > 5) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 5)];
        }
    }
    
    if (textField == self.subtitleTextField) {
        if (textField.text.length > 5) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 5)];
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
- (UIView *)leftBar
{
    if (_leftBar == nil) {
        _leftBar = [[UIView alloc] init];
        _leftBar.backgroundColor = [UIColor colorWithRed:229.0f/255.0f green:63.0f/255.0f blue:51.0f/255.0f alpha:1];
    }
    return _leftBar;
}

- (UIView *)rightBar
{
    if (_rightBar == nil) {
        _rightBar = [[UIView alloc] init];
        _rightBar.backgroundColor = [UIColor colorWithRed:229.0f/255.0f green:63.0f/255.0f blue:51.0f/255.0f alpha:1];
    }
    return _rightBar;
}

- (UIView *)topBar
{
    if (_topBar == nil) {
        _topBar = [[UIView alloc] init];
        _topBar.backgroundColor = [UIColor colorWithRed:229.0f/255.0f green:63.0f/255.0f blue:51.0f/255.0f alpha:1];
    }
    return _topBar;
}

- (UIView *)bottomBar
{
    if (_bottomBar == nil) {
        _bottomBar = [[UIView alloc] init];
        _bottomBar.backgroundColor = [UIColor colorWithRed:229.0f/255.0f green:63.0f/255.0f blue:51.0f/255.0f alpha:1];
    }
    return _bottomBar;
}

- (UILabel *)timesLabel
{
    if (_timesLabel == nil) {
        _timesLabel = [[UILabel alloc] init];
        _timesLabel.text = @"TIME";
        _timesLabel.font = [UIFont fontWithName:@"Cochin" size:50];
        _timesLabel.backgroundColor = [UIColor clearColor];
        _timesLabel.textAlignment = NSTextAlignmentCenter;
        _timesLabel.textColor = [UIColor colorWithRed:230.0f/255.0f green:63.0f/255.0f blue:52.0f/255.0f alpha:1];
    }
    return _timesLabel;
}

- (UILabel *)itisLabel
{
    if (_itisLabel == nil) {
        _itisLabel = [[UILabel alloc] init];
        _itisLabel.text = @"IT'S";
        _itisLabel.font = [UIFont fontWithName:@"Zapf Dingbats" size:40];
        _itisLabel.backgroundColor = [UIColor clearColor];
        _itisLabel.textAlignment = NSTextAlignmentCenter;
        _itisLabel.textColor = [UIColor colorWithRed:230.0f/255.0f green:63.0f/255.0f blue:52.0f/255.0f alpha:1];
    }
    return _itisLabel;
}

- (UITextField *)titleTextField
{
    if (_titleTextField == nil) {
        _titleTextField = [[UITextField alloc] init];
        _titleTextField.delegate = self;
        [_titleTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _titleTextField.textAlignment = NSTextAlignmentLeft;
        _titleTextField.font = [UIFont fontWithName:@"FZLanTingHeiS-R-GB" size:30];
        _titleTextField.text = @"跨时代";
        _titleTextField.textColor = [UIColor whiteColor];
    }
    return _titleTextField;
}

- (UITextField *)subtitleTextField
{
    if (_subtitleTextField == nil) {
        _subtitleTextField = [[UITextField alloc] init];
        _subtitleTextField.delegate = self;
        [_subtitleTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _subtitleTextField.textAlignment = NSTextAlignmentLeft;
        _subtitleTextField.font = [UIFont fontWithName:@"FZLanTingHeiS-R-GB" size:30];
        _subtitleTextField.text = @"伟大发明";
        _subtitleTextField.textColor = [UIColor whiteColor];
    }
    return _subtitleTextField;
}

- (UITextField *)detailTextField
{
    if (_detailTextField == nil) {
        _detailTextField = [[UITextField alloc] init];
        _detailTextField.delegate = self;
        [_detailTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _detailTextField.textAlignment = NSTextAlignmentLeft;
        _detailTextField.font = [UIFont fontWithName:@"Cochin" size:12];
        _detailTextField.text = @"Sharing Is Good Morals, Just Do It.";
        _detailTextField.textColor = [UIColor colorWithRed:194.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0f];
    }
    return _detailTextField;
}

@end
