//
//  AssortMainViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/14/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortMainViewController.h"
#import "UIView+LayoutMethods.h"
#import "BSAssortCanvasView.h"
#import "AssortStoreViewController.h"
#import "AssortCropImageViewController.h"

@interface AssortMainViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, AssortStoreViewControllerDelegate, AssortCropImageViewControllerDelegate>

@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) BSAssortCanvasView *canvasView;
@property (nonatomic, strong) UIImageView *generatedImageView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *generateButton;

@end

@implementation AssortMainViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.canvasView];
    [self.view addSubview:self.generatedImageView];
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.generateButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.canvasView leftInContainer:0 shouldResize:YES];
    [self.canvasView rightInContainer:0 shouldResize:YES];
    self.canvasView.height = self.canvasView.width;
    [self.canvasView topInContainer:70 shouldResize:NO];
    
    self.generatedImageView.size = CGSizeMake(200, 200);
    [self.generatedImageView top:5 FromView:self.canvasView];
    [self.generatedImageView centerXEqualToView:self.view];
    
    self.addButton.size = CGSizeMake(60, 40);
    [self.addButton bottomInContainer:0 shouldResize:NO];
    [self.addButton leftInContainer:10 shouldResize:NO];
    
    [self.generateButton sizeEqualToView:self.addButton];
    [self.generateButton topEqualToView:self.addButton];
    [self.generateButton right:10 FromView:self.addButton];
}

#pragma mark - event response
- (void)didTappedAddButton:(UIButton *)addButton
{
    [self.actionSheet showInView:self.view];
}

- (void)didTappedGenerateButton:(UIButton *)generateButton
{
    self.generatedImageView.image = [self.canvasView generateImage];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // camera
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate = self;
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    if (buttonIndex == 1) {
        // library
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate = self;
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    if (buttonIndex == 2) {
        // my store
        AssortStoreViewController *storeViewController = [[AssortStoreViewController alloc] init];
        storeViewController.delegate = self;
        [self presentViewController:storeViewController animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *fetchedImage = info[UIImagePickerControllerOriginalImage];
    AssortCropImageViewController *viewController = [[AssortCropImageViewController alloc] initWithImage:fetchedImage];
    viewController.delegate = self;
    [picker pushViewController:viewController animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - AssortCropImageViewControllerDelegate
- (void)cropImageViewController:(AssortCropImageViewController *)cropImageViewController didCroppedImage:(UIImage *)image
{
    [self.canvasView addView:[[UIImageView alloc] initWithImage:image] width:image.size.width height:image.size.height];
    [cropImageViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cropImageViewControllerDidCanceled:(AssortCropImageViewController *)cropImageController
{
    
}

#pragma mark - AssortStoreViewControllerDelegate
- (void)storeViewController:(AssortStoreViewController *)storeViewController didSelectedItem:(UIImage *)image
{
    [self.canvasView addView:[[UIImageView alloc] initWithImage:image] width:image.size.width height:image.size.height];
    [storeViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)storeViewControllerDidCanceled:(AssortStoreViewController *)storeViewController
{
    [storeViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getters and setters
- (UIActionSheet *)actionSheet
{
    if (_actionSheet == nil) {
        _actionSheet = [[UIActionSheet alloc] initWithTitle:@"add image" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"camera", @"library", @"my store", nil];
    }
    return _actionSheet;
}

- (UIButton *)addButton
{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_addButton setTitle:@"add" forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(didTappedAddButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (BSAssortCanvasView *)canvasView
{
    if (_canvasView == nil) {
        _canvasView = [[BSAssortCanvasView alloc] init];
        _canvasView.backgroundColor = [UIColor grayColor];
    }
    return _canvasView;
}

- (UIImageView *)generatedImageView
{
    if (_generatedImageView == nil) {
        _generatedImageView = [[UIImageView alloc] init];
        _generatedImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _generatedImageView;
}

- (UIButton *)generateButton
{
    if (_generateButton == nil) {
        _generateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_generateButton addTarget:self action:@selector(didTappedGenerateButton:) forControlEvents:UIControlEventTouchUpInside];
        [_generateButton setTitle:@"gen" forState:UIControlStateNormal];
    }
    return _generateButton;
}

@end
