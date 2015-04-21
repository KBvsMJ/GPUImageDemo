//
//  ImageAutoFilterViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/21/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "ImageAutoFilterViewController.h"
#import "BSAutoImageFilter.h"
#import "UIView+LayoutMethods.h"

@interface ImageAutoFilterViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, BSAutoImageFilterDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *originImageView;
@property (nonatomic, strong) UIButton *fetchImageButton;

@property (nonatomic, strong) UIImageView *processedImageView;
@property (nonatomic, strong) UIButton *optimizeButton;

@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong) BSAutoImageFilter *autoImageFilter;

@end

@implementation ImageAutoFilterViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.scrollView addSubview:self.originImageView];
    [self.scrollView addSubview:self.processedImageView];
    [self.scrollView addSubview:self.fetchImageButton];
    [self.scrollView addSubview:self.optimizeButton];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.activityIndicatorView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.scrollView topInContainer:70 shouldResize:YES];
    [self.scrollView leftInContainer:0 shouldResize:YES];
    [self.scrollView rightInContainer:0 shouldResize:YES];
    [self.scrollView bottomInContainer:0 shouldResize:YES];
    
    self.scrollView.contentSize = CGSizeMake(self.view.width*2, self.scrollView.height);
    
    [self.originImageView topInContainer:0 shouldResize:YES];
    [self.originImageView leftInContainer:0 shouldResize:YES];
    [self.originImageView rightInContainer:0 shouldResize:YES];
    [self.originImageView bottomInContainer:60 shouldResize:YES];
    
    [self.fetchImageButton top:5 FromView:self.originImageView];
    [self.fetchImageButton leftInContainer:10 shouldResize:YES];
    [self.fetchImageButton rightInContainer:10 shouldResize:YES];
    [self.fetchImageButton bottomInContainer:5 shouldResize:YES];
    
    [self.processedImageView sizeEqualToView:self.originImageView];
    [self.processedImageView topEqualToView:self.originImageView];
    [self.processedImageView right:0 FromView:self.originImageView];
    
    [self.optimizeButton sizeEqualToView:self.fetchImageButton];
    [self.optimizeButton topEqualToView:self.fetchImageButton];
    [self.optimizeButton centerXEqualToView:self.processedImageView];
    
    [self.activityIndicatorView centerXEqualToView:self.view];
    [self.activityIndicatorView centerYEqualToView:self.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height) animated:YES];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    
    UIImagePickerController *viewController = [[UIImagePickerController alloc] init];
    viewController.delegate = self;
    
    if (buttonIndex == 0) {
        viewController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    if (buttonIndex == 1) {
        viewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.originImageView.image = info[UIImagePickerControllerOriginalImage];
    self.processedImageView.image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - BSAutoImageFilterDelegate
- (void)autoImageFilter:(BSAutoImageFilter *)autoImageFilter didFinishedWithOriginImage:(UIImage *)originImage processedImage:(UIImage *)processedImage
{
    [self.activityIndicatorView stopAnimating];
    self.processedImageView.image = processedImage;
}

#pragma mark - event response
- (void)didTappedFetchImageButton:(UIButton *)button
{
    [self.actionSheet showInView:self.view];
}

- (void)didTappedOptimizeButton:(UIButton *)button
{
    [self.activityIndicatorView startAnimating];
    [self.autoImageFilter autoFiltWithImage:self.originImageView.image];
}

#pragma mark - getters and setters
- (UIActionSheet *)actionSheet
{
    if (_actionSheet == nil) {
        _actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机", @"相册", nil];
    }
    return _actionSheet;
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

- (UIButton *)fetchImageButton
{
    if (_fetchImageButton == nil) {
        _fetchImageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_fetchImageButton setTitle:@"选择照片" forState:UIControlStateNormal];
        [_fetchImageButton addTarget:self action:@selector(didTappedFetchImageButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fetchImageButton;
}

- (UIButton *)optimizeButton
{
    if (_optimizeButton == nil) {
        _optimizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_optimizeButton setTitle:@"一键优化" forState:UIControlStateNormal];
        [_optimizeButton addTarget:self action:@selector(didTappedOptimizeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _optimizeButton;
}

- (BSAutoImageFilter *)autoImageFilter
{
    if (_autoImageFilter == nil) {
        _autoImageFilter = [[BSAutoImageFilter alloc] init];
        _autoImageFilter.delegate = self;
    }
    return _autoImageFilter;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.directionalLockEnabled = YES;
    }
    return _scrollView;
}

- (UIActivityIndicatorView *)activityIndicatorView
{
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_activityIndicatorView stopAnimating];
    }
    return _activityIndicatorView;
}

@end
