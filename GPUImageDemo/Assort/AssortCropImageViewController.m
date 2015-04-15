//
//  AssortCropImageViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/14/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortCropImageViewController.h"
#import "MZCroppableView.h"
#import "UIView+LayoutMethods.h"

@interface AssortCropImageViewController ()

@property (nonatomic, strong) UIImage *originImage;

@property (nonatomic, strong) MZCroppableView *croppableView;
@property (nonatomic, strong) UIImageView *croppedImageView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *cropButton;
@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation AssortCropImageViewController


#pragma mark - life cycle
- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.originImage = image;
        self.imageView.image = image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.croppedImageView];
    [self.view addSubview:self.cropButton];
    [self.view addSubview:self.resetButton];
    [self.view addSubview:self.confirmButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.imageView topInContainer:70 shouldResize:YES];
    [self.imageView bottomInContainer:200 shouldResize:YES];
    [self.imageView leftInContainer:10 shouldResize:YES];
    [self.imageView rightInContainer:10 shouldResize:YES];
    
    CGRect rect1 = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    CGRect rect2 = self.imageView.frame;
    [self.imageView setFrame:[MZCroppableView scaleRespectAspectFromRect1:rect1 toRect2:rect2]];
    
    [self.croppableView removeFromSuperview];
    self.croppableView = [[MZCroppableView alloc] initWithImageView:self.imageView];
    [self.view addSubview:self.croppableView];
    
    [self.croppedImageView top:10 FromView:self.imageView];
    [self.croppedImageView leftInContainer:10 shouldResize:YES];
    [self.croppedImageView rightInContainer:100 shouldResize:YES];
    [self.croppedImageView bottomInContainer:10 shouldResize:YES];
    
    self.cropButton.size = CGSizeMake(80, 40);
    [self.cropButton right:10 FromView:self.croppedImageView];
    [self.cropButton top:20 FromView:self.imageView];
    
    [self.resetButton sizeEqualToView:self.cropButton];
    [self.resetButton leftEqualToView:self.cropButton];
    [self.resetButton top:20 FromView:self.cropButton];
    
    [self.confirmButton sizeEqualToView:self.cropButton];
    [self.confirmButton leftEqualToView:self.cropButton];
    [self.confirmButton top:20 FromView:self.resetButton];
}

#pragma mark - event response
- (void)didTappedButton:(UIButton *)button
{
    self.croppedImageView.image = [self.croppableView deleteBackgroundOfImage:self.imageView];
}

- (void)didTappedResetButton:(UIButton *)button
{
    [self.croppableView removeFromSuperview];
    self.croppableView = [[MZCroppableView alloc] initWithImageView:self.imageView];
    [self.view addSubview:self.croppableView];
}

- (void)didTappedConfirmButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(cropImageViewController:didCroppedImage:)]) {
        [self.delegate cropImageViewController:self didCroppedImage:self.croppedImageView.image];
    }
}

#pragma mark - getters and setters
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIImageView *)croppedImageView
{
    if (_croppedImageView == nil) {
        _croppedImageView = [[UIImageView alloc] init];
        _croppedImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _croppedImageView;
}

- (UIButton *)cropButton
{
    if (_cropButton == nil) {
        _cropButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_cropButton setTitle:@"crop" forState:UIControlStateNormal];
        [_cropButton addTarget:self action:@selector(didTappedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cropButton;
}

- (UIButton *)resetButton
{
    if (_resetButton == nil) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_resetButton setTitle:@"reset" forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(didTappedResetButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}

- (UIButton *)confirmButton
{
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_confirmButton setTitle:@"confirm" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(didTappedConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


@end
