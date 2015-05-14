//
//  FunTipCollectionViewChildCell.m
//  GPUImageDemo
//
//  Created by casa on 5/14/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "FunTipCollectionViewChildCell.h"
#import "UIView+LayoutMethods.h"

@interface FunTipCollectionViewChildCell ()

@property (nonatomic, strong, readwrite) UIImageView *iconImageView;

@end

@implementation FunTipCollectionViewChildCell

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.iconImageView fill];
}

#pragma mark - getters and setters
- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
        _iconImageView.backgroundColor = [UIColor clearColor];
    }
    return _iconImageView;
}

@end
