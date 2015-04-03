//
//  EXIFReader.h
//  GPUImageDemo
//
//  Created by casa on 4/2/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EXIFReader : NSObject

- (NSDictionary *)exifOfImage:(UIImage *)image;

@end
