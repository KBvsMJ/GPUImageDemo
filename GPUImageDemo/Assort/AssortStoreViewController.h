//
//  AssortStoreViewController.h
//  GPUImageDemo
//
//  Created by casa on 4/14/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AssortStoreViewController;

@protocol AssortStoreViewControllerDelegate <NSObject>
@required
- (void)storeViewController:(AssortStoreViewController *)storeViewController didSelectedItem:(UIImage *)image;
- (void)storeViewControllerDidCanceled:(AssortStoreViewController *)storeViewController;
@end

@interface AssortStoreViewController : UIViewController

@property (nonatomic, weak) id<AssortStoreViewControllerDelegate> delegate;

@end
