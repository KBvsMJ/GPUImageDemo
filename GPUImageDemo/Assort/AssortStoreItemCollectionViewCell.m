//
//  AssortStoreItemCollectionViewCell.m
//  GPUImageDemo
//
//  Created by casa on 4/14/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortStoreItemCollectionViewCell.h"
#import "UIView+LayoutMethods.h"

@interface AssortStoreItemCollectionViewCell ()

@property (nonatomic, strong, readwrite) UIImageView *itemImageView;

@end

@implementation AssortStoreItemCollectionViewCell

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.itemImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.itemImageView leftInContainer:3 shouldResize:YES];
    [self.itemImageView rightInContainer:3 shouldResize:YES];
    [self.itemImageView topInContainer:3 shouldResize:YES];
    [self.itemImageView bottomInContainer:3 shouldResize:YES];
}

#pragma mark - getters and setters
- (UIImageView *)itemImageView
{
    if (_itemImageView == nil) {
        _itemImageView = [[UIImageView alloc] init];
        _itemImageView.contentMode = UIViewContentModeScaleAspectFit;
        _itemImageView.backgroundColor = [UIColor blueColor];
    }
    return _itemImageView;
}

@end
