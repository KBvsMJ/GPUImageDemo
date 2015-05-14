//
//  FunTipCollectionViewMainCell.m
//  GPUImageDemo
//
//  Created by casa on 5/14/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "FunTipCollectionViewMainCell.h"
#import "UIView+LayoutMethods.h"

@interface FunTipCollectionViewMainCell ()

@property (nonatomic, strong) UIImageView *borderImageView;
@property (nonatomic, strong, readwrite) UIImageView *iconImageView;
@property (nonatomic, strong, readwrite) UIImageView *cornerIconImageView;

@end

@implementation FunTipCollectionViewMainCell

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView addSubview:self.cornerIconImageView];
        [self.contentView addSubview:self.borderImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    self.iconImageView.size = CGSizeMake(105, 105);
    [self.iconImageView leftInContainer:0 shouldResize:NO];
    [self.iconImageView topInContainer:0 shouldResize:NO];
    
    self.cornerIconImageView.size = CGSizeMake(22, 22);
    [self.cornerIconImageView rightInContainer:0 shouldResize:NO];
    [self.cornerIconImageView topInContainer:0 shouldResize:NO];
    
    self.borderImageView.size = CGSizeMake(105, 105);
    [self.borderImageView topInContainer:5 shouldResize:NO];
    [self.borderImageView leftInContainer:5 shouldResize:NO];
    [self.borderImageView rightInContainer:0 shouldResize:NO];
}

#pragma mark - getters and setters
- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _iconImageView;
}

- (UIImageView *)cornerIconImageView
{
    if (_cornerIconImageView == nil) {
        _cornerIconImageView = [[UIImageView alloc] init];
        _cornerIconImageView.contentMode = UIViewContentModeScaleToFill;
        _cornerIconImageView.backgroundColor = [UIColor clearColor];
    }
    return _cornerIconImageView;
}

- (UIImageView *)borderImageView
{
    if (_borderImageView == nil) {
        _borderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FunTipCellBorder"]];
        _borderImageView.contentMode = UIViewContentModeScaleToFill;
        _borderImageView.backgroundColor = [UIColor clearColor];
        _borderImageView.hidden = YES;
    }
    return _borderImageView;
}

- (void)setIsAlbum:(BOOL)isAlbum
{
    _isAlbum = isAlbum;
    self.borderImageView.hidden = isAlbum ? NO : YES;
}

@end
