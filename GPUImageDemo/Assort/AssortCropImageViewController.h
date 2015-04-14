//
//  AssortCropImageViewController.h
//  GPUImageDemo
//
//  Created by casa on 4/14/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AssortCropImageViewController;

@protocol AssortCropImageViewControllerDelegate <NSObject>

- (void)cropImageViewController:(AssortCropImageViewController *)cropImageViewController didCroppedImage:(UIImage *)image;
- (void)cropImageViewControllerDidCanceled:(AssortCropImageViewController *)cropImageController;

@end

@interface AssortCropImageViewController : UIViewController

@property (nonatomic, weak) id<AssortCropImageViewControllerDelegate> delegate;
- (instancetype)initWithImage:(UIImage *)image;

@end
