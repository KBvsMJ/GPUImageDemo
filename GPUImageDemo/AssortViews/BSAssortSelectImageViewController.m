//
//  BSAssortSelectImageViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/13/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "BSAssortSelectImageViewController.h"

@interface BSAssortSelectImageViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *albumButton;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BSAssortSelectImageViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.cameraButton];
    [self.view addSubview:self.albumButton];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - event response
- (void)didTappedCameraButton:(UIButton *)cameraButton
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)didTappedAlbumButton:(UIButton *)albumButton
{
    
}

#pragma mark - getters and setters
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] init];
    }
    return _collectionView;
}

- (UIButton *)cameraButton
{
    if (_cameraButton == nil) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_cameraButton setBackgroundImage:[UIImage imageNamed:@"BSAssortCamera"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(didTappedCameraButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

- (UIButton *)albumButton
{
    if (_albumButton == nil) {
        _albumButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_albumButton setBackgroundImage:[UIImage imageNamed:@"BSAssortAlbum"] forState:UIControlStateNormal];
        [_albumButton addTarget:self action:@selector(didTappedAlbumButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _albumButton;
}

@end
