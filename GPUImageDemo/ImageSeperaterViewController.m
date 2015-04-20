//
//  ImageSeperaterViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/9/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "ImageSeperaterViewController.h"
#import "MZCroppableView.h"
#import "UIView+LayoutMethods.h"
#import "ImageCanvasViewController.h"

@interface ImageSeperaterViewController ()

@property (nonatomic, strong) MZCroppableView *croppableView;
@property (nonatomic, strong) UIImageView *croppedImageView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *cropButton;
@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) UIButton *canvasButton;

@end

@implementation ImageSeperaterViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.croppedImageView];
    [self.view addSubview:self.cropButton];
    [self.view addSubview:self.resetButton];
    [self.view addSubview:self.canvasButton];
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
    
    [self.canvasButton sizeEqualToView:self.resetButton];
    [self.canvasButton leftEqualToView:self.resetButton];
    [self.canvasButton top:20 FromView:self.resetButton];
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

- (void)didTappedCanvasButton:(UIButton *)button
{
    ImageCanvasViewController *viewController = [[ImageCanvasViewController alloc] init];
    viewController.croppedImage = self.croppedImageView.image;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - getters and setters
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DemoImage"]];
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

- (UIButton *)canvasButton
{
    if (_canvasButton == nil) {
        _canvasButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_canvasButton setTitle:@"canvas" forState:UIControlStateNormal];
        [_canvasButton addTarget:self action:@selector(didTappedCanvasButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canvasButton;
}

@end
