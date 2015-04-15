//
//  AssortTipMagazine.m
//  GPUImageDemo
//
//  Created by casa on 4/15/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipMagazine.h"
#import "UIView+LayoutMethods.h"

@interface AssortTipMagazine ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextField *firstLineTextField;
@property (nonatomic, strong) UITextField *secondLineTextField;
@property (nonatomic, strong) UITextField *thirdLineTextField;

@end

@implementation AssortTipMagazine

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
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
    self.firstLineTextField.height = 84;
    [self.firstLineTextField bottomInContainer:45 shouldResize:NO];
    
    [self.secondLineTextField leftInContainer:10 shouldResize:YES];
    [self.secondLineTextField rightInContainer:10 shouldResize:YES];
    self.secondLineTextField.height = 15;
    [self.secondLineTextField bottomInContainer:42 shouldResize:NO];
    
    [self.thirdLineTextField leftInContainer:10 shouldResize:YES];
    [self.thirdLineTextField rightInContainer:10 shouldResize:YES];
    self.thirdLineTextField.height = 15;
    [self.thirdLineTextField bottomInContainer:30 shouldResize:NO];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

#pragma mark - event response
- (void)didTappedTextField:(UITextField *)textField
{
    [textField becomeFirstResponder];
}

#pragma mark - getters and setters

@end
