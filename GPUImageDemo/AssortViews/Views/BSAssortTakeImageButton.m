//
//  BSAssortTakeImageButton.m
//  GPUImageDemo
//
//  Created by casa on 4/13/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "BSAssortTakeImageButton.h"

@interface BSAssortTakeImageButton ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BSAssortTakeImageButton

- (instancetype)initWithTitle:(NSString *)title backgroundImage:(UIImage *)backgroundImage iconImage:(UIImage *)iconImage
{
    self = [super init];
    if (self) {
    }
    return self;
}

@end
