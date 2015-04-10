//
//  CTCroppableView.m
//  GPUImageDemo
//
//  Created by casa on 4/9/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "CTCroppableView.h"

@interface CTCroppableView ()

@property (nonatomic, strong) UIBezierPath *bezierPath;

@end

@implementation CTCroppableView

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - public methods
- (UIImage *)croppedImage
{
    return nil;
}

#pragma mark - Event Response

@end
