//
//  ImageCanvasViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/13/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "ImageCanvasViewController.h"
#import "ZDStickerView.h"
#import "UIView+LayoutMethods.h"
#import "BSAssortCanvasView.h"

@interface ImageCanvasViewController () <ZDStickerViewDelegate>

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *generateImageButton;

@property (nonatomic, strong) BSAssortCanvasView *canvasView;
@property (nonatomic, strong) UIImageView *generatedImageView;

@end

@implementation ImageCanvasViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.canvasView];
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.generatedImageView];
    [self.view addSubview:self.generateImageButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.canvasView leftInContainer:10 shouldResize:YES];
    [self.canvasView rightInContainer:10 shouldResize:YES];
    self.canvasView.height = self.canvasView.width;
    [self.canvasView topInContainer:70 shouldResize:NO];
    
    self.addButton.size = CGSizeMake(50, 50);
    [self.addButton bottomInContainer:0 shouldResize:NO];
    [self.addButton leftInContainer:10 shouldResize:NO];
    
    self.generatedImageView.size = CGSizeMake(200, 200);
    [self.generatedImageView top:10 FromView:self.canvasView];
    [self.generatedImageView leftInContainer:10 shouldResize:NO];
    
    self.generateImageButton.size = CGSizeMake(100, 50);
    [self.generateImageButton right:10 FromView:self.addButton];
    [self.generateImageButton topEqualToView:self.addButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.canvasView addView:[[UIImageView alloc] initWithImage:self.croppedImage] width:self.croppedImage.size.width height:self.croppedImage.size.height];
}

#pragma mark - event response
- (void)didTappedAddButton:(UIButton *)button
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DemoImage"]];
    [self.canvasView addView:imageView width:imageView.image.size.width height:imageView.image.size.height];
}

- (void)didTappedGenerateImageButton:(UIButton *)button
{
    self.generatedImageView.image = [self.canvasView generateImage];
}

#pragma mark - getters and setters
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

- (UIButton *)generateImageButton
{
    if (_generateImageButton == nil) {
        _generateImageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_generateImageButton addTarget:self action:@selector(didTappedGenerateImageButton:) forControlEvents:UIControlEventTouchUpInside];
        [_generateImageButton setTitle:@"generate" forState:UIControlStateNormal];
    }
    return _generateImageButton;
}

- (UIImageView *)generatedImageView
{
    if (_generatedImageView == nil) {
        _generatedImageView = [[UIImageView alloc] init];
        _generatedImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _generatedImageView;
}

@end
