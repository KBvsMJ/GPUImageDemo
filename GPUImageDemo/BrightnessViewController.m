//
//  BrightnessViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/3/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "BrightnessViewController.h"
#import "UIView+LayoutMethods.h"

@interface BrightnessViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *brightnessLabel;
@property (nonatomic, strong) UIButton *fetchImageButton;
@property (nonatomic, strong) UIActionSheet *actionSheet;

@end

@implementation BrightnessViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.fetchImageButton];
    [self.view addSubview:self.actionSheet];
    [self.view addSubview:self.brightnessLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.imageView leftInContainer:10 shouldResize:YES];
    [self.imageView rightInContainer:10 shouldResize:YES];
    self.imageView.height = self.imageView.width;
    [self.imageView topInContainer:70 shouldResize:NO];
    
    [self.brightnessLabel leftInContainer:10 shouldResize:YES];
    [self.brightnessLabel rightInContainer:10 shouldResize:YES];
    self.brightnessLabel.height = 20;
    [self.brightnessLabel top:10 FromView:self.imageView];
    
    [self.fetchImageButton leftInContainer:10 shouldResize:YES];
    [self.fetchImageButton rightInContainer:10 shouldResize:YES];
    self.fetchImageButton.height = 60;
    [self.fetchImageButton top:10 FromView:self.brightnessLabel];
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

#pragma mark - UIActionSheetDelegate
// Called when a button is clicked. The view will be automatically dismissed after this call returns
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
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getters and setters
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)brightnessLabel
{
    if (_brightnessLabel == nil) {
        _brightnessLabel = [[UILabel alloc] init];
    }
    return _brightnessLabel;
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

@end
