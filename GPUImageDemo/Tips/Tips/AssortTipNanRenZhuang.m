//
//  AssortTipNanRenZhuang.m
//  GPUImageDemo
//
//  Created by casa on 4/17/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipNanRenZhuang.h"
#import "UIView+LayoutMethods.h"

@interface AssortTipNanRenZhuang () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UILabel *verticalLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UITextField *firstLineTextField;
@property (nonatomic, strong) UITextField *secondLineTextField;
@property (nonatomic, strong) UIImageView *barcodeImageView;

@end

@implementation AssortTipNanRenZhuang

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.titleTextField];
        [self addSubview:self.verticalLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.firstLineTextField];
        [self addSubview:self.secondLineTextField];
        [self addSubview:self.barcodeImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    self.titleTextField.size = CGSizeMake(224, 102);
    [self.titleTextField topInContainer:0 shouldResize:NO];
    [self.titleTextField leftInContainer:12 shouldResize:NO];

    self.verticalLabel.size = CGSizeMake(87, 9);
    self.verticalLabel.layer.transform = CATransform3DMakeRotation((90.0f/180.0f*M_PI), 0, 0, 1);
    [self.verticalLabel right:2 FromView:self.titleTextField];
    [self.verticalLabel topInContainer:15 shouldResize:NO];

    [self.dateLabel sizeToFit];
    [self.dateLabel leftInContainer:16 shouldResize:NO];
    [self.dateLabel bottomInContainer:40 shouldResize:NO];

    self.firstLineTextField.height = 12;
    [self.firstLineTextField leftInContainer:17 shouldResize:YES];
    [self.firstLineTextField rightInContainer:100 shouldResize:YES];
    [self.firstLineTextField top:3 FromView:self.dateLabel];

    self.secondLineTextField.height = 12;
    [self.secondLineTextField leftEqualToView:self.firstLineTextField];
    [self.secondLineTextField rightInContainer:100 shouldResize:YES];
    [self.secondLineTextField top:3 FromView:self.firstLineTextField];

    self.barcodeImageView.size = CGSizeMake(35, 20);
    [self.barcodeImageView bottomEqualToView:self.secondLineTextField];
    [self.barcodeImageView rightInContainer:18 shouldResize:NO];
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
    if (textField == self.titleTextField) {
        textLength = 3;
    }
    
    if (textField == self.firstLineTextField) {
        textLength = 12;
    }
    
    if (textField == self.secondLineTextField) {
        textLength = 20;
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
- (UITextField *)titleTextField
{
    if (_titleTextField == nil) {
        _titleTextField = [[UITextField alloc] init];
        _titleTextField.text = @"男人装";
        _titleTextField.font = [UIFont fontWithName:@"FZDaBiaoSong-B06S" size:72];
        _titleTextField.textColor = [UIColor whiteColor];
        _titleTextField.delegate = self;
        [_titleTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _titleTextField.textAlignment = NSTextAlignmentLeft;
    }
    return _titleTextField;
}

- (UILabel *)verticalLabel
{
    if (_verticalLabel == nil) {
        _verticalLabel = [[UILabel alloc] init];
        _verticalLabel.text = @"FOR HIM MAGAZINE";
        _verticalLabel.font = [UIFont systemFontOfSize:7];
        _verticalLabel.textColor = [UIColor whiteColor];
    }
    return _verticalLabel;
}

- (UILabel *)dateLabel
{
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc] init];
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"YYYY/MM/dd";
        _dateLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:today]];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = [UIColor whiteColor];
    }
    return _dateLabel;
}

- (UITextField *)firstLineTextField
{
    if (_firstLineTextField == nil) {
        _firstLineTextField = [[UITextField alloc] init];
        _firstLineTextField.delegate = self;
        [_firstLineTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _firstLineTextField.textAlignment = NSTextAlignmentLeft;
        _firstLineTextField.textColor = [UIColor whiteColor];
        _firstLineTextField.font = [UIFont systemFontOfSize:12];
        _firstLineTextField.text = @"Life is real.";
    }
    return _firstLineTextField;
}

- (UITextField *)secondLineTextField
{
    if (_secondLineTextField == nil) {
        _secondLineTextField = [[UITextField alloc] init];
        _secondLineTextField.delegate = self;
        [_secondLineTextField addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
        _secondLineTextField.textAlignment = NSTextAlignmentLeft;
        _secondLineTextField.textColor = [UIColor whiteColor];
        _secondLineTextField.font = [UIFont systemFontOfSize:12];
        _secondLineTextField.text = @"Happy.Angry";
    }
    return _secondLineTextField;
}

- (UIImageView *)barcodeImageView
{
    if (_barcodeImageView == nil) {
        _barcodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssortTipFashionBabyBarcode"]];
        _barcodeImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _barcodeImageView;
}

@end
