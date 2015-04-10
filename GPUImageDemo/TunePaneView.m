//
//  TunePaneView.m
//  GPUImageDemo
//
//  Created by casa on 4/9/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "TunePaneView.h"
#import <GPUImage/GPUImage.h>
#import "UIView+LayoutMethods.h"

@interface TunePaneView ()

@property (nonatomic, strong) GPUImagePicture *originPicture;

@property (nonatomic, strong) UISlider *brightnessSlider;
@property (nonatomic, strong) UILabel *brightnessSliderLabel;
@property (nonatomic, strong) GPUImageBrightnessFilter *brightnessFilter;

@property (nonatomic, strong) UISlider *saturationSlider;
@property (nonatomic, strong) UILabel *saturationSliderLabel;
@property (nonatomic, strong) GPUImageSaturationFilter *saturationFilter;

@property (nonatomic, strong) UISlider *excludeCircleRadiusSlider;
@property (nonatomic, strong) UILabel *excludeCircleRadiusSliderLabel;

@property (nonatomic, strong) UISlider *excludeBlurSizeSlider;
@property (nonatomic, strong) UILabel *excludeBlurSizeSliderLabel;

@property (nonatomic, strong) UISlider *aspectRatioSlider;
@property (nonatomic, strong) UILabel *aspectRatioSliderLabel;

@property (nonatomic, strong) UISlider *blurRadiusSlider;
@property (nonatomic, strong) UILabel *blurRadiusSliderLabel;

@property (nonatomic, strong) GPUImageGaussianSelectiveBlurFilter *blurFilter;

@property (nonatomic, strong) UILabel *sharpnessSliderLabel;
@property (nonatomic, strong) UISlider *sharpnessSlider;
@property (nonatomic, strong) GPUImageSharpenFilter *sharpenFilter;

@end

@implementation TunePaneView

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.brightnessSlider];
        [self addSubview:self.brightnessSliderLabel];
        
        [self addSubview:self.saturationSlider];
        [self addSubview:self.saturationSliderLabel];
        
        [self addSubview:self.blurRadiusSlider];
        [self addSubview:self.blurRadiusSliderLabel];
        
        [self addSubview:self.excludeCircleRadiusSlider];
        [self addSubview:self.excludeCircleRadiusSliderLabel];
        
        [self addSubview:self.excludeBlurSizeSlider];
        [self addSubview:self.excludeBlurSizeSliderLabel];
        
        [self addSubview:self.aspectRatioSlider];
        [self addSubview:self.aspectRatioSliderLabel];
        
        [self addSubview:self.sharpnessSlider];
        [self addSubview:self.sharpnessSliderLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.brightnessSliderLabel.width = 80.0f;
    self.brightnessSliderLabel.height = 20.0f;
    [self.brightnessSliderLabel leftInContainer:10 shouldResize:NO];
    [self.brightnessSliderLabel topInContainer:10 shouldResize:NO];
    
    [self.brightnessSlider topInContainer:10 shouldResize:NO];
    [self.brightnessSlider right:10 FromView:self.brightnessSliderLabel];
    [self.brightnessSlider rightInContainer:10 shouldResize:YES];
    
    self.saturationSliderLabel.width = 120.0f;
    self.saturationSliderLabel.height = 20.0f;
    [self.saturationSliderLabel top:10 FromView:self.brightnessSlider];
    [self.saturationSliderLabel leftInContainer:10 shouldResize:NO];
    
    [self.saturationSlider top:10 FromView:self.brightnessSlider];
    [self.saturationSlider right:10 FromView:self.brightnessSliderLabel];
    [self.saturationSlider rightInContainer:10 shouldResize:YES];
    
    self.excludeCircleRadiusSliderLabel.size = CGSizeMake(120.0f, 20.0f);
    [self.excludeCircleRadiusSliderLabel top:10 FromView:self.saturationSlider];
    [self.excludeCircleRadiusSliderLabel leftInContainer:10 shouldResize:NO];
    [self.excludeCircleRadiusSlider top:10 FromView:self.saturationSlider];
    [self.excludeCircleRadiusSlider right:10 FromView:self.brightnessSliderLabel];
    [self.excludeCircleRadiusSlider rightInContainer:10 shouldResize:YES];
    
    self.excludeBlurSizeSliderLabel.size = CGSizeMake(120, 20);
    [self.excludeBlurSizeSliderLabel top:10 FromView:self.excludeCircleRadiusSlider];
    [self.excludeBlurSizeSliderLabel leftInContainer:10 shouldResize:NO];
    [self.excludeBlurSizeSlider top:10 FromView:self.excludeCircleRadiusSlider];
    [self.excludeBlurSizeSlider right:10 FromView:self.brightnessSliderLabel];
    [self.excludeBlurSizeSlider rightInContainer:10 shouldResize:YES];
    
    self.aspectRatioSliderLabel.size = CGSizeMake(120, 20);
    [self.aspectRatioSliderLabel top:10 FromView:self.excludeBlurSizeSlider];
    [self.aspectRatioSliderLabel leftInContainer:10 shouldResize:NO];
    [self.aspectRatioSlider top:10 FromView:self.excludeBlurSizeSlider];
    [self.aspectRatioSlider right:10 FromView:self.brightnessSliderLabel];
    [self.aspectRatioSlider rightInContainer:10 shouldResize:YES];
    
    self.blurRadiusSliderLabel.size = CGSizeMake(120, 20);
    [self.blurRadiusSliderLabel top:10 FromView:self.aspectRatioSlider];
    [self.blurRadiusSliderLabel leftInContainer:10 shouldResize:NO];
    [self.blurRadiusSlider top:10 FromView:self.aspectRatioSlider];
    [self.blurRadiusSlider right:10 FromView:self.brightnessSliderLabel];
    [self.blurRadiusSlider rightInContainer:10 shouldResize:YES];
    
    self.sharpnessSliderLabel.size = CGSizeMake(120, 20);
    [self.sharpnessSliderLabel top:10 FromView:self.blurRadiusSlider];
    [self.sharpnessSliderLabel leftInContainer:10 shouldResize:NO];
    [self.sharpnessSlider top:10 FromView:self.blurRadiusSlider];
    [self.sharpnessSlider right:10 FromView:self.brightnessSliderLabel];
    [self.sharpnessSlider rightInContainer:10 shouldResize:YES];
}

#pragma mark - event response
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

- (void)excludeCircleRadiusChanged:(UISlider *)excludeCircleRadiusSlider
{
    self.excludeCircleRadiusSliderLabel.text = [NSString stringWithFormat:@"cr：%f", excludeCircleRadiusSlider.value];
    self.blurFilter.excludeCircleRadius = excludeCircleRadiusSlider.value;
    [self processImage];
}

- (void)blurRadiusChanged:(UISlider *)blurRadiusSlider
{
    self.blurRadiusSliderLabel.text = [NSString stringWithFormat:@"br：%f", blurRadiusSlider.value];
    self.blurFilter.blurRadiusInPixels = blurRadiusSlider.value;
    [self processImage];
}

- (void)excludeBlurSizeChanged:(UISlider *)excludeBlurSizeSlider
{
    self.excludeBlurSizeSliderLabel.text = [NSString stringWithFormat:@"bs：%f", excludeBlurSizeSlider.value];
    self.blurFilter.excludeBlurSize = excludeBlurSizeSlider.value;
    [self processImage];
}

- (void)aspectRatioChanged:(UISlider *)aspectRatioSlider
{
    self.aspectRatioSliderLabel.text = [NSString stringWithFormat:@"ar：%f", aspectRatioSlider.value];
    self.blurFilter.aspectRatio = aspectRatioSlider.value;
    [self processImage];
}

- (void)sharpnessChanged:(UISlider *)sharpnessSlider
{
    self.sharpnessSliderLabel.text = [NSString stringWithFormat:@"sh：%f", sharpnessSlider.value];
    self.sharpenFilter.sharpness = sharpnessSlider.value;
    [self processImage];
}

#pragma mark - private methods
- (void)processImage
{
    [self.originPicture removeAllTargets];
    
    [self.originPicture addTarget:self.brightnessFilter];
    [self.brightnessFilter addTarget:self.saturationFilter];
    [self.saturationFilter addTarget:self.sharpenFilter];
    [self.sharpenFilter addTarget:self.blurFilter];
    
    [self.blurFilter useNextFrameForImageCapture];
    [self.originPicture processImage];
    
    [self.delegate tunePaneView:self didProcessedImage:[self.blurFilter imageFromCurrentFramebufferWithOrientation:self.originImage.imageOrientation]];
}

#pragma mark - getters and setters
- (void)setOriginImage:(UIImage *)originImage
{
    _originImage = originImage;
    self.originPicture = [[GPUImagePicture alloc] initWithImage:originImage];
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

- (UILabel *)brightnessSliderLabel
{
    if (_brightnessSliderLabel == nil) {
        _brightnessSliderLabel = [[UILabel alloc] init];
        _brightnessSliderLabel.text = @"0.0";
        _brightnessSliderLabel.textColor = [UIColor redColor];
    }
    return _brightnessSliderLabel;
}

- (UILabel *)saturationSliderLabel
{
    if (_saturationSliderLabel == nil) {
        _saturationSliderLabel = [[UILabel alloc] init];
        _saturationSliderLabel.text = @"sat：1.0";
        _saturationSliderLabel.textColor = [UIColor redColor];
    }
    return _saturationSliderLabel;
}

- (UILabel *)blurRadiusSliderLabel
{
    if (_blurRadiusSliderLabel == nil) {
        _blurRadiusSliderLabel = [[UILabel alloc] init];
        _blurRadiusSliderLabel.text = @"br：";
        _blurRadiusSliderLabel.textColor = [UIColor redColor];
    }
    return _blurRadiusSliderLabel;
}

- (UISlider *)blurRadiusSlider
{
    if (_blurRadiusSlider == nil) {
        _blurRadiusSlider = [[UISlider alloc] init];
        [_blurRadiusSlider addTarget:self action:@selector(blurRadiusChanged:) forControlEvents:UIControlEventValueChanged];
        _blurRadiusSlider.minimumValue = 0.0f;
        _blurRadiusSlider.maximumValue = 30.0f;
    }
    return _blurRadiusSlider;
}

- (UISlider *)excludeCircleRadiusSlider
{
    if (_excludeCircleRadiusSlider == nil) {
        _excludeCircleRadiusSlider = [[UISlider alloc] init];
        [_excludeCircleRadiusSlider addTarget:self action:@selector(excludeCircleRadiusChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _excludeCircleRadiusSlider;
}

- (UILabel *)excludeCircleRadiusSliderLabel
{
    if (_excludeCircleRadiusSliderLabel == nil) {
        _excludeCircleRadiusSliderLabel = [[UILabel alloc] init];
        _excludeCircleRadiusSliderLabel.text = @"cr：";
        _excludeCircleRadiusSliderLabel.textColor = [UIColor redColor];
    }
    return _excludeCircleRadiusSliderLabel;
}

- (UISlider *)excludeBlurSizeSlider
{
    if (_excludeBlurSizeSlider == nil) {
        _excludeBlurSizeSlider = [[UISlider alloc] init];
        [_excludeBlurSizeSlider addTarget:self action:@selector(excludeBlurSizeChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _excludeBlurSizeSlider;
}

- (UILabel *)excludeBlurSizeSliderLabel
{
    if (_excludeBlurSizeSliderLabel == nil) {
        _excludeBlurSizeSliderLabel = [[UILabel alloc] init];
        _excludeBlurSizeSliderLabel.text = @"bs：";
        _excludeBlurSizeSliderLabel.textColor = [UIColor redColor];
    }
    return _excludeBlurSizeSliderLabel;
}

- (UISlider *)aspectRatioSlider
{
    if (_aspectRatioSlider == nil) {
        _aspectRatioSlider = [[UISlider alloc] init];
        [_aspectRatioSlider addTarget:self action:@selector(aspectRatioChanged:) forControlEvents:UIControlEventValueChanged];
        _aspectRatioSlider.minimumValue = 0;
        _aspectRatioSlider.maximumValue = 2;
    }
    return _aspectRatioSlider;
}

- (UILabel *)aspectRatioSliderLabel
{
    if (_aspectRatioSliderLabel == nil) {
        _aspectRatioSliderLabel = [[UILabel alloc] init];
        _aspectRatioSliderLabel.text = @"ar：";
        _aspectRatioSliderLabel.textColor = [UIColor redColor];
    }
    return _aspectRatioSliderLabel;
}

- (GPUImageGaussianSelectiveBlurFilter *)blurFilter
{
    if (_blurFilter == nil) {
        _blurFilter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
        _blurFilter.excludeBlurSize = 0;
        _blurFilter.excludeCircleRadius = 0;
        _blurFilter.aspectRatio = 0;
        _blurFilter.blurRadiusInPixels = 0;
    }
    return _blurFilter;
}

- (GPUImageSharpenFilter *)sharpenFilter
{
    if (_sharpenFilter == nil) {
        _sharpenFilter = [[GPUImageSharpenFilter alloc] init];
        _sharpenFilter.sharpness = 0;
    }
    return _sharpenFilter;
}

- (UISlider *)sharpnessSlider
{
    if (_sharpnessSlider == nil) {
        _sharpnessSlider = [[UISlider alloc] init];
        [_sharpnessSlider addTarget:self action:@selector(sharpnessChanged:) forControlEvents:UIControlEventValueChanged];
        _sharpnessSlider.minimumValue = -4.0f;
        _sharpnessSlider.maximumValue = 4.0f;
        _sharpnessSlider.value = 0.0f;
    }
    return _sharpnessSlider;
}

- (UILabel *)sharpnessSliderLabel
{
    if (_sharpnessSliderLabel == nil) {
        _sharpnessSliderLabel = [[UILabel alloc] init];
        _sharpnessSliderLabel.text = @"sh:0.0";
        _sharpnessSliderLabel.textColor = [UIColor redColor];
    }
    return _sharpnessSliderLabel;
}

@end
