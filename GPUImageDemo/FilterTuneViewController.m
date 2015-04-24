//
//  FilterTuneViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/9/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "FilterTuneViewController.h"
#import "UIView+LayoutMethods.h"
#import "TunePaneView.h"
#import "ImageAnalyzer.h"

@interface FilterTuneViewController () <TunePaneViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *originImageView;
@property (nonatomic, strong) UIImageView *processedImageView;

@property (nonatomic, strong) UIBarButtonItem *fetchImageButton;
@property (nonatomic, strong) UIBarButtonItem *tunePaneButton;

@property (nonatomic, strong) TunePaneView *tunePaneView;
@property (nonatomic, strong) UIActionSheet *actionSheet;

@property (nonatomic, strong) UILabel *brightnessLabel;
@property (nonatomic, strong) UILabel *saturationLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;

@property (nonatomic, strong) ImageAnalyzer *imageAnalyzer;

@end

@implementation FilterTuneViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.originImageView];
    [self.scrollView addSubview:self.processedImageView];
    
    [self.view addSubview:self.tunePaneView];
    
    [self.originImageView addSubview:self.brightnessLabel];
    [self.originImageView addSubview:self.saturationLabel];
    [self.originImageView addSubview:self.temperatureLabel];
    
    self.navigationItem.rightBarButtonItems = @[self.fetchImageButton, self.tunePaneButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.scrollView topInContainer:64 shouldResize:YES];
    [self.scrollView bottomInContainer:0 shouldResize:YES];
    [self.scrollView leftInContainer:0 shouldResize:YES];
    [self.scrollView rightInContainer:0 shouldResize:YES];
    
    self.originImageView.width = self.view.width;
    [self.originImageView leftInContainer:0 shouldResize:YES];
    [self.originImageView topInContainer:0 shouldResize:YES];
    [self.originImageView bottomInContainer:0 shouldResize:YES];
    
    [self.processedImageView sizeEqualToView:self.originImageView];
    [self.processedImageView right:0 FromView:self.originImageView];
    [self.processedImageView topEqualToView:self.originImageView];
    
    [self.tunePaneView top:0 FromView:self.view];
    [self.tunePaneView bottomEqualToView:self.view];
    [self.tunePaneView leftInContainer:0 shouldResize:YES];
    [self.tunePaneView rightInContainer:0 shouldResize:YES];
    
    self.brightnessLabel.height = 20.0f;
    [self.brightnessLabel leftInContainer:0 shouldResize:YES];
    [self.brightnessLabel rightInContainer:0 shouldResize:YES];
    [self.brightnessLabel topInContainer:3 shouldResize:NO];
    
    [self.saturationLabel sizeEqualToView:self.brightnessLabel];
    [self.saturationLabel top:0 FromView:self.brightnessLabel];
    [self.saturationLabel leftInContainer:0 shouldResize:NO];
    
    [self.temperatureLabel sizeEqualToView:self.brightnessLabel];
    [self.temperatureLabel top:0 FromView:self.saturationLabel];
    [self.temperatureLabel leftInContainer:0 shouldResize:NO];
    
    self.scrollView.contentSize = CGSizeMake(self.view.width * 2, self.scrollView.height);
    self.scrollView.contentOffset = CGPointMake(self.view.width, 0);
}

#pragma mark - TunePaneViewDelegate
- (void)tunePaneView:(TunePaneView *)tunePaneView didProcessedImage:(UIImage *)image
{
    self.processedImageView.image = image;
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
    self.processedImageView.image = info[UIImagePickerControllerOriginalImage];
    self.originImageView.image = info[UIImagePickerControllerOriginalImage];
    self.tunePaneView.originImage = info[UIImagePickerControllerOriginalImage];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSDictionary *imageInfo = [strongSelf.imageAnalyzer analyzeImage:info[UIImagePickerControllerOriginalImage]];
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.brightnessLabel.text = [NSString stringWithFormat:@"brt:%@", imageInfo[@"brightness"]];
            strongSelf.saturationLabel.text = [NSString stringWithFormat:@"sat:%@", imageInfo[@"saturation"]];
            strongSelf.temperatureLabel.text = [NSString stringWithFormat:@"tmp:%@", imageInfo[@"temperature"]];
        });
    });
}

#pragma mark - event response
- (void)didTappedFetchImageButton:(UIBarButtonItem *)fetchImageButton
{
    [self.actionSheet showInView:self.view];
}

- (void)didTappedTunePaneButton:(UIBarButtonItem *)tunePaneButton
{
    [UIView animateWithDuration:0.3f animations:^{
        if (self.tunePaneView.isShowing) {
            self.tunePaneView.isShowing = NO;
            [self.tunePaneView top:0 FromView:self.view];
        } else {
            self.tunePaneView.isShowing = YES;
            [self.tunePaneView topInContainer:260 shouldResize:YES];
        }
    }];
}

#pragma mark - getters and setters
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.directionalLockEnabled = YES;
    }
    return _scrollView;
}

- (UIImageView *)originImageView
{
    if (_originImageView == nil) {
        _originImageView = [[UIImageView alloc] init];
        _originImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _originImageView;
}

- (UIImageView *)processedImageView
{
    if (_processedImageView == nil) {
        _processedImageView = [[UIImageView alloc] init];
        _processedImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _processedImageView;
}

- (UIBarButtonItem *)fetchImageButton
{
    if (_fetchImageButton == nil) {
        _fetchImageButton = [[UIBarButtonItem alloc] initWithTitle:@"照片" style:UIBarButtonItemStylePlain target:self action:@selector(didTappedFetchImageButton:)];
    }
    return _fetchImageButton;
}

- (UIBarButtonItem *)tunePaneButton
{
    if (_tunePaneButton == nil) {
        _tunePaneButton = [[UIBarButtonItem alloc] initWithTitle:@"调试" style:UIBarButtonItemStylePlain target:self action:@selector(didTappedTunePaneButton:)];
    }
    return _tunePaneButton;
}

- (TunePaneView *)tunePaneView
{
    if (_tunePaneView == nil) {
        _tunePaneView = [[TunePaneView alloc] init];
        _tunePaneView.delegate = self;
        _tunePaneView.isShowing = NO;
    }
    return _tunePaneView;
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

- (UILabel *)brightnessLabel
{
    if (_brightnessLabel == nil) {
        _brightnessLabel = [[UILabel alloc] init];
        _brightnessLabel.textColor = [UIColor redColor];
    }
    return _brightnessLabel;
}

- (UILabel *)saturationLabel
{
    if (_saturationLabel == nil) {
        _saturationLabel = [[UILabel alloc] init];
        _saturationLabel.textColor = [UIColor redColor];
    }
    return _saturationLabel;
}

- (UILabel *)temperatureLabel
{
    if (_temperatureLabel == nil) {
        _temperatureLabel = [[UILabel alloc] init];
        _temperatureLabel.textColor = [UIColor redColor];
    }
    return _temperatureLabel;
}
@end
