//
//  BSAssortCanvasView.h
//  GPUImageDemo
//
//  Created by casa on 4/13/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSAssortCanvasView : UIView

- (void)addView:(UIView *)view width:(CGFloat)width height:(CGFloat)height;
- (UIImage *)generateImage;

@end
