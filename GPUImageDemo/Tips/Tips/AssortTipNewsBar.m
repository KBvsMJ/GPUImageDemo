//
//  AssortTipNewsBar.m
//  GPUImageDemo
//
//  Created by casa on 4/16/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipNewsBar.h"
#import "UIView+LayoutMethods.h"

@interface AssortTipNewsBar () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *blueLable;
@property (nonatomic, strong) UILabel *redLabel;

@property (nonatomic, strong) UIView *contentBackgroundView;
@property (nonatomic, strong) UITextField *newsTitleTextField;
@property (nonatomic, strong) UITextField *subtitleTextField;

@end

@implementation AssortTipNewsBar

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.blueLable];
        [self addSubview:self.redLabel];
        [self addSubview:self.contentBackgroundView];
        [self addSubview:self.newsTitleTextField];
        [self addSubview:self.subtitleTextField];
    }
    return self;
}

- (void)layoutSubviews
{
    self.blueLable.size = CGSizeMake(75, 27);
    [self.blueLable leftInContainer:0 shouldResize:NO];
    [self.blueLable bottomInContainer:15 shouldResize:NO];
    
    self.redLabel.size = CGSizeMake(75, 15);
    [self.redLabel leftInContainer:0 shouldResize:NO];
    [self.redLabel bottomInContainer:0 shouldResize:NO];
    
    [self.contentBackgroundView topEqualToView:self.blueLable];
    [self.contentBackgroundView bottomInContainer:0 shouldResize:YES];
    [self.contentBackgroundView right:0 FromView:self.blueLable];
    [self.contentBackgroundView rightInContainer:0 shouldResize:YES];
    
    [self.newsTitleTextField heightEqualToView:self.blueLable];
    [self.newsTitleTextField right:10 FromView:self.blueLable];
    [self.newsTitleTextField rightInContainer:0 shouldResize:YES];
    [self.newsTitleTextField centerYEqualToView:self.blueLable];
    
    [self.subtitleTextField heightEqualToView:self.redLabel];
    [self.subtitleTextField right:10 FromView:self.redLabel];
    [self.subtitleTextField rightInContainer:0 shouldResize:YES];
    [self.subtitleTextField centerYEqualToView:self.redLabel];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.newsTitleTextField) {
        if (textField.text.length > 15) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 15)];
        }
    }
    
    if (textField == self.subtitleTextField) {
        if (textField.text.length > 30) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 30)];
        }
    }
}

#pragma mark - event response
- (void)didTappedTextField:(UITextField *)textField
{
    [textField becomeFirstResponder];
}

#pragma mark - getters and setters
- (UILabel *)blueLable
{
    if (_blueLable == nil) {
        _blueLable = [[UILabel alloc] init];
        _blueLable.textAlignment = NSTextAlignmentCenter;
        _blueLable.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:145.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        _blueLable.text = @"新闻";
        _blueLable.font = [UIFont boldSystemFontOfSize:18];
        _blueLable.textColor = [UIColor whiteColor];
    }
    return _blueLable;
}

- (UILabel *)redLabel
{
    if (_redLabel == nil) {
        _redLabel = [[UILabel alloc] init];
        _redLabel.textAlignment = NSTextAlignmentCenter;
        _redLabel.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:20.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
        _redLabel.font = [UIFont boldSystemFontOfSize:10];
        _redLabel.textColor = [UIColor whiteColor];
        
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm";
        _redLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:today]];
    }
    return _redLabel;
}

- (UIView *)contentBackgroundView
{
    if (_contentBackgroundView == nil) {
        _contentBackgroundView = [[UIView alloc] init];
        _contentBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    }
    return _contentBackgroundView;
}

- (UITextField *)newsTitleTextField
{
    if (_newsTitleTextField == nil) {
        _newsTitleTextField = [[UITextField alloc] init];
        _newsTitleTextField.textColor = [UIColor colorWithRed:218.0f/255.0f green:185.0f/255.0f blue:69.0f/255.0f alpha:1.0f];
        _newsTitleTextField.font = [UIFont systemFontOfSize:18];
        _newsTitleTextField.delegate = self;
        [_newsTitleTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _newsTitleTextField.text = @"土豪120万买电子表为哪般";
        _newsTitleTextField.backgroundColor = [UIColor clearColor];
    }
    return _newsTitleTextField;
}

- (UITextField *)subtitleTextField
{
    if (_subtitleTextField == nil) {
        _subtitleTextField = [[UITextField alloc] init];
        _subtitleTextField.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        _subtitleTextField.font = [UIFont systemFontOfSize:10];
        _subtitleTextField.delegate = self;
        [_subtitleTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _subtitleTextField.text = @"杭州 晴 9~15摄氏度 广大市民请注意天气变化";
        _subtitleTextField.backgroundColor = [UIColor clearColor];
    }
    return _subtitleTextField;
}

@end
