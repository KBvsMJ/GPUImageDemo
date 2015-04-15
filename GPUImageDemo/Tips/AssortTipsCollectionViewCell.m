//
//  AssortTipsCollectionViewCell.m
//  GPUImageDemo
//
//  Created by casa on 4/15/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipsCollectionViewCell.h"
#import "UIView+LayoutMethods.h"

@interface AssortTipsCollectionViewCell ()

@property (nonatomic, strong, readwrite) UILabel *contentLabel;

@end

@implementation AssortTipsCollectionViewCell

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.contentLabel fill];
}

#pragma mark - getters and setters
- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

@end
