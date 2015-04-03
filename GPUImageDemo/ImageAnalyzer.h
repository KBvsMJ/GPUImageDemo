//
//  ImageAnalyzer.h
//  GPUImageDemo
//
//  Created by casa on 4/3/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageAnalyzer : NSObject

- (CGFloat)brightnessOfImage:(UIImage *)image;
- (CGFloat)saturationOfImage:(UIImage *)image;

@end
