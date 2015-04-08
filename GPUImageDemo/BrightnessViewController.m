//
//  BrightnessViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/3/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "BrightnessViewController.h"
#import "UIView+LayoutMethods.h"
#import "ImageAnalyzer.h"
#import <GPUImage/GPUImage.h>

@interface BrightnessViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImageView *originImageView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *fetchImageButton;
@property (nonatomic, strong) UIActionSheet *actionSheet;

@property (nonatomic, strong) UISlider *brightnessSlider;
@property (nonatomic, strong) GPUImageBrightnessFilter *brightnessFilter;

@property (nonatomic, strong) UISlider *saturationSlider;
@property (nonatomic, strong) GPUImageSaturationFilter *saturationFilter;

@property (nonatomic, strong) UISlider *blurSizeSlider;
@property (nonatomic, strong) UISlider *blurCenterXSlider;
@property (nonatomic, strong) UISlider *blurCenterYSlider;
@property (nonatomic, strong) UISlider *blurRadiusSlider;
@property (nonatomic, strong) GPUImageGaussianBlurPositionFilter *blurFilter;

@property (nonatomic, strong) GPUImagePicture *originPicture;

@property (nonatomic, strong) ImageAnalyzer *imageAnalyzer;

@property (nonatomic, strong) UILabel *brightnessLabel;
@property (nonatomic, strong) UILabel *saturationLabel;

@property (nonatomic, strong) UILabel *brightnessSliderLabel;
@property (nonatomic, strong) UILabel *saturationSliderLabel;

@property (nonatomic, strong) UILabel *blurSizeSliderLabel;
@property (nonatomic, strong) UILabel *blurCenterXSliderLabel;
@property (nonatomic, strong) UILabel *blurCenterYSliderLabel;
@property (nonatomic, strong) UILabel *blurRadiusSliderLabel;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation BrightnessViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.originImageView];
    [self.view addSubview:self.fetchImageButton];
    [self.view addSubview:self.actionSheet];
    [self.view addSubview:self.brightnessSlider];
    [self.view addSubview:self.saturationSlider];
    
    [self.view addSubview:self.brightnessLabel];
    [self.view addSubview:self.saturationLabel];
    [self.view addSubview:self.brightnessSliderLabel];
    [self.view addSubview:self.saturationSliderLabel];
    
    [self.view addSubview:self.blurRadiusSlider];
    [self.view addSubview:self.blurRadiusSliderLabel];
    [self.view addSubview:self.blurCenterXSlider];
    [self.view addSubview:self.blurCenterXSliderLabel];
    [self.view addSubview:self.blurCenterYSlider];
    [self.view addSubview:self.blurCenterYSliderLabel];
    [self.view addSubview:self.blurSizeSlider];
    [self.view addSubview:self.blurSizeSliderLabel];
    
    [self.view addSubview:self.activityIndicator];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.imageView leftInContainer:100 shouldResize:YES];
    [self.imageView rightInContainer:100 shouldResize:YES];
    self.imageView.height = self.imageView.width;
    [self.imageView topInContainer:70 shouldResize:NO];
    
    [self.originImageView sizeEqualToView:self.imageView];
    [self.originImageView centerYEqualToView:self.imageView];
    
    self.originImageView.centerX = self.view.width / 4.0f;
    self.imageView.centerX = self.view.width / 4.0f * 3;
    
    CGFloat labelWidth = (self.view.width - 30.0f) / 2.0f;
    self.brightnessLabel.width = labelWidth;
    self.brightnessLabel.height = 20;
    [self.brightnessLabel top:10 FromView:self.imageView];
    
    self.saturationLabel.width = labelWidth;
    self.saturationLabel.height = 20;
    [self.saturationLabel centerYEqualToView:self.brightnessLabel];
    [self.saturationLabel right:10 FromView:self.brightnessLabel];
    
    [self.fetchImageButton leftInContainer:10 shouldResize:YES];
    [self.fetchImageButton rightInContainer:10 shouldResize:YES];
    self.fetchImageButton.height = 60;
    [self.fetchImageButton top:10 FromView:self.brightnessLabel];
    
    self.brightnessSliderLabel.width = 80.0f;
    self.brightnessSliderLabel.height = 20.0f;
    [self.brightnessSliderLabel leftInContainer:10 shouldResize:NO];
    [self.brightnessSliderLabel top:10 FromView:self.fetchImageButton];
    
    [self.brightnessSlider top:10 FromView:self.fetchImageButton];
    [self.brightnessSlider right:10 FromView:self.brightnessSliderLabel];
    [self.brightnessSlider rightInContainer:10 shouldResize:YES];
    
    self.saturationSliderLabel.width = 120.0f;
    self.saturationSliderLabel.height = 20.0f;
    [self.saturationSliderLabel top:10 FromView:self.brightnessSlider];
    [self.saturationSliderLabel leftInContainer:10 shouldResize:NO];
    
    [self.saturationSlider top:10 FromView:self.brightnessSlider];
    [self.saturationSlider right:10 FromView:self.brightnessSliderLabel];
    [self.saturationSlider rightInContainer:10 shouldResize:YES];
    
    self.blurSizeSliderLabel.size = CGSizeMake(120.0f, 20.0f);
    [self.blurSizeSliderLabel top:10 FromView:self.saturationSlider];
    [self.blurSizeSliderLabel leftInContainer:10 shouldResize:NO];
    [self.blurSizeSlider top:10 FromView:self.saturationSlider];
    [self.blurSizeSlider right:10 FromView:self.brightnessSliderLabel];
    [self.blurSizeSlider rightInContainer:10 shouldResize:YES];
    
    self.blurCenterXSliderLabel.size = CGSizeMake(120, 20);
    [self.blurCenterXSliderLabel top:10 FromView:self.blurSizeSlider];
    [self.blurCenterXSliderLabel leftInContainer:10 shouldResize:NO];
    [self.blurCenterXSlider top:10 FromView:self.blurSizeSlider];
    [self.blurCenterXSlider right:10 FromView:self.brightnessSliderLabel];
    [self.blurCenterXSlider rightInContainer:10 shouldResize:YES];
    
    self.blurCenterYSliderLabel.size = CGSizeMake(120, 20);
    [self.blurCenterYSliderLabel top:10 FromView:self.blurCenterXSlider];
    [self.blurCenterYSliderLabel leftInContainer:10 shouldResize:NO];
    [self.blurCenterYSlider top:10 FromView:self.blurCenterXSlider];
    [self.blurCenterYSlider right:10 FromView:self.brightnessSliderLabel];
    [self.blurCenterYSlider rightInContainer:10 shouldResize:YES];
    
    self.blurRadiusSliderLabel.size = CGSizeMake(120, 20);
    [self.blurRadiusSliderLabel top:10 FromView:self.blurCenterYSlider];
    [self.blurRadiusSliderLabel leftInContainer:10 shouldResize:NO];
    [self.blurRadiusSlider top:10 FromView:self.blurCenterYSlider];
    [self.blurRadiusSlider right:10 FromView:self.brightnessSliderLabel];
    [self.blurRadiusSlider rightInContainer:10 shouldResize:YES];
    
    [self.activityIndicator centerXEqualToView:self.view];
    [self.activityIndicator centerYEqualToView:self.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma mark - event response
- (void)didTappedFetchImageButton:(UIButton *)button
{
    [self.actionSheet showInView:self.view];
}

- (void)brightnessChanged:(UISlider *)brightnessSlider
{
    self.brightnessSliderLabel.text = [NSString stringWithFormat:@"%f", brightnessSlider.value];
    self.brightnessFilter.brightness = brightnessSlider.value;
    [self processImage];
}

- (void)saturationChanged:(UISlider *)saturationSlider
{
    self.saturationSliderLabel.text = [NSString stringWithFormat:@"sat：%f", saturationSlider.value];
    self.saturationFilter.saturation = saturationSlider.value;
    [self processImage];
}

- (void)blurSizeChanged:(UISlider *)blurSizeSlider
{
    self.blurSizeSliderLabel.text = [NSString stringWithFormat:@"s：%f", blurSizeSlider.value];
    self.blurFilter.blurSize = blurSizeSlider.value;
    [self processImage];
}

- (void)blurRadiusChanged:(UISlider *)blurRadiusSlider
{
    self.blurRadiusSliderLabel.text = [NSString stringWithFormat:@"r：%f", blurRadiusSlider.value];
    self.blurFilter.blurRadius = blurRadiusSlider.value;
    [self processImage];
}

- (void)blurCenterXChanged:(UISlider *)blurCenterXSlider
{
    self.blurCenterXSliderLabel.text = [NSString stringWithFormat:@"X：%f", blurCenterXSlider.value];
    CGPoint center = self.blurFilter.blurCenter;
    center.x = blurCenterXSlider.value;
    self.blurFilter.blurCenter = center;
    [self processImage];
}

- (void)blurCenterYChanged:(UISlider *)blurCenterYSlider
{
    self.blurCenterYSliderLabel.text = [NSString stringWithFormat:@"Y：%f", blurCenterYSlider.value];
    CGPoint center = self.blurFilter.blurCenter;
    center.y = blurCenterYSlider.value;
    self.blurFilter.blurCenter = center;
    [self processImage];
}

#pragma mark - private methods
- (void)processImage
{
    [self.originPicture removeAllTargets];
    [self.originPicture addTarget:self.brightnessFilter];
    [self.brightnessFilter addTarget:self.saturationFilter];
    [self.saturationFilter addTarget:self.blurFilter];
    
    [self.blurFilter useNextFrameForImageCapture];
    [self.originPicture processImage];
    
    self.imageView.image = [self.blurFilter imageFromCurrentFramebufferWithOrientation:self.imageView.image.imageOrientation];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    
    if (buttonIndex == 0) {
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    if (buttonIndex == 1) {
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:pickerController animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
    self.originImageView.image = info[UIImagePickerControllerOriginalImage];
    self.originPicture = [[GPUImagePicture alloc] initWithImage:self.imageView.image];
    [self.activityIndicator startAnimating];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSDictionary *imageInfo = [strongSelf.imageAnalyzer analyzeImage:strongSelf.imageView.image];
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.brightnessLabel.text = [NSString stringWithFormat:@"%@", imageInfo[@"brightness"]];
            strongSelf.saturationLabel.text = [NSString stringWithFormat:@"sat：%@", imageInfo[@"saturation"]];
            [strongSelf.activityIndicator stopAnimating];
        });
    });
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

- (UIImageView *)originImageView
{
    if (_originImageView == nil) {
        _originImageView = [[UIImageView alloc] init];
        _originImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _originImageView;
}

- (UIButton *)fetchImageButton
{
    if (_fetchImageButton == nil) {
        _fetchImageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_fetchImageButton addTarget:self action:@selector(didTappedFetchImageButton:) forControlEvents:UIControlEventTouchUpInside];
        [_fetchImageButton setTitle:@"fetch image" forState:UIControlStateNormal];
    }
    return _fetchImageButton;
}

- (UIActionSheet *)actionSheet
{
    if (_actionSheet == nil) {
        _actionSheet = [[UIActionSheet alloc] initWithTitle:@"fetch image" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"camera", @"library", nil];
    }
    return _actionSheet;
}

- (ImageAnalyzer *)imageAnalyzer
{
    if (_imageAnalyzer == nil) {
        _imageAnalyzer = [[ImageAnalyzer alloc] init];
    }
    return _imageAnalyzer;
}

- (UISlider *)brightnessSlider
{
    if (_brightnessSlider == nil) {
        _brightnessSlider = [[UISlider alloc] init];
        [_brightnessSlider addTarget:self action:@selector(brightnessChanged:) forControlEvents:UIControlEventValueChanged];
        _brightnessSlider.minimumValueImage = [UIImage imageNamed:@"minBrightness"];
        _brightnessSlider.maximumValueImage = [UIImage imageNamed:@"maxBrightness"];
        _brightnessSlider.minimumValue = -1.0f;
        _brightnessSlider.maximumValue = 1.0f;
        _brightnessSlider.value = 0.0f;
    }
    return _brightnessSlider;
}

- (GPUImageBrightnessFilter *)brightnessFilter
{
    if (_brightnessFilter == nil) {
        _brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    }
    return _brightnessFilter;
}

- (UISlider *)saturationSlider
{
    if (_saturationSlider == nil) {
        _saturationSlider = [[UISlider alloc] init];
        [_saturationSlider addTarget:self action:@selector(saturationChanged:) forControlEvents:UIControlEventValueChanged];
        _saturationSlider.minimumValue = 0.0f;
        _saturationSlider.maximumValue = 2.0f;
        _saturationSlider.value = 1.0f;
    }
    return _saturationSlider;
}

- (GPUImageSaturationFilter *)saturationFilter
{
    if (_saturationFilter == nil) {
        _saturationFilter = [[GPUImageSaturationFilter alloc] init];
    }
    return _saturationFilter;
}

- (UILabel *)brightnessLabel
{
    if (_brightnessLabel == nil) {
        _brightnessLabel = [[UILabel alloc] init];
        _brightnessLabel.text = @"亮度：";
    }
    return _brightnessLabel;
}

- (UILabel *)saturationLabel
{
    if (_saturationLabel == nil) {
        _saturationLabel = [[UILabel alloc] init];
        _saturationLabel.text = @"sat：";
    }
    return _saturationLabel;
}

- (UILabel *)brightnessSliderLabel
{
    if (_brightnessSliderLabel == nil) {
        _brightnessSliderLabel = [[UILabel alloc] init];
        _brightnessSliderLabel.text = @"0.0";
    }
    return _brightnessSliderLabel;
}

- (UILabel *)saturationSliderLabel
{
    if (_saturationSliderLabel == nil) {
        _saturationSliderLabel = [[UILabel alloc] init];
        _saturationSliderLabel.text = @"sat：1.0";
    }
    return _saturationSliderLabel;
}

- (UISlider *)blurSizeSlider
{
    if (_blurSizeSlider == nil) {
        _blurSizeSlider = [[UISlider alloc] init];
        [_blurSizeSlider addTarget:self action:@selector(blurSizeChanged:) forControlEvents:UIControlEventValueChanged];
        _blurSizeSlider.minimumValue = 0.0f;
        _blurSizeSlider.maximumValue = 10.0f;
    }
    return _blurSizeSlider;
}

- (UILabel *)blurSizeSliderLabel
{
    if (_blurSizeSliderLabel == nil) {
        _blurSizeSliderLabel = [[UILabel alloc] init];
        _blurSizeSliderLabel.text = @"s：";
    }
    return _blurSizeSliderLabel;
}

- (UILabel *)blurRadiusSliderLabel
{
    if (_blurRadiusSliderLabel == nil) {
        _blurRadiusSliderLabel = [[UILabel alloc] init];
        _blurRadiusSliderLabel.text = @"r：";
    }
    return _blurRadiusSliderLabel;
}

- (UISlider *)blurRadiusSlider
{
    if (_blurRadiusSlider == nil) {
        _blurRadiusSlider = [[UISlider alloc] init];
        [_blurRadiusSlider addTarget:self action:@selector(blurRadiusChanged:) forControlEvents:UIControlEventValueChanged];
        _blurRadiusSlider.minimumValue = 0.0f;
        _blurRadiusSlider.maximumValue = 1.0f;
    }
    return _blurRadiusSlider;
}

- (UILabel *)blurCenterXSliderLabel
{
    if (_blurCenterXSliderLabel == nil) {
        _blurCenterXSliderLabel = [[UILabel alloc] init];
        _blurCenterXSliderLabel.text = @"X：";
    }
    return _blurCenterXSliderLabel;
}

- (UISlider *)blurCenterXSlider
{
    if (_blurCenterXSlider == nil) {
        _blurCenterXSlider = [[UISlider alloc] init];
        [_blurCenterXSlider addTarget:self action:@selector(blurCenterXChanged:) forControlEvents:UIControlEventValueChanged];
        _blurCenterXSlider.minimumValue = 0.0f;
        _blurCenterXSlider.maximumValue = 1.0f;
        _blurCenterXSlider.value = 0.5f;
    }
    return _blurCenterXSlider;
}

- (UILabel *)blurCenterYSliderLabel
{
    if (_blurCenterYSliderLabel == nil) {
        _blurCenterYSliderLabel = [[UILabel alloc] init];
        _blurCenterYSliderLabel.text = @"Y：";
    }
    return _blurCenterYSliderLabel;
}

- (UISlider *)blurCenterYSlider
{
    if (_blurCenterYSlider == nil) {
        _blurCenterYSlider = [[UISlider alloc] init];
        [_blurCenterYSlider addTarget:self action:@selector(blurCenterYChanged:) forControlEvents:UIControlEventValueChanged];
        _blurCenterYSlider.minimumValue = 0.0f;
        _blurCenterYSlider.maximumValue = 1.0f;
        _blurCenterYSlider.value = 0.5f;
    }
    return _blurCenterYSlider;
}

- (GPUImageGaussianBlurPositionFilter *)blurFilter
{
    if (_blurFilter == nil) {
        _blurFilter = [[GPUImageGaussianBlurPositionFilter alloc] init];
        _blurFilter.blurSize = 0;
        _blurFilter.blurRadius = 0;
    }
    return _blurFilter;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _activityIndicator;
}

@end
