//
//  TunePaneView.h
//  GPUImageDemo
//
//  Created by casa on 4/9/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TunePaneView;

@protocol TunePaneViewDelegate <NSObject>

@required
- (void)tunePaneView:(TunePaneView *)tunePaneView didProcessedImage:(UIImage *)image;

@end

@interface TunePaneView : UIView

@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, strong) UIImage *originImage;
@property (nonatomic, weak) id<TunePaneViewDelegate> delegate;

@end
