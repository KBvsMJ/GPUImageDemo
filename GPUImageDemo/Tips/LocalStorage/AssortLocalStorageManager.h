//
//  AssortLocalStorageManager.h
//  GPUImageDemo
//
//  Created by casa on 4/22/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AssortLocalStorageManager : NSObject

- (NSArray *)localTips;

- (void)saveTipWithContent:(NSString *)contentString;
- (void)saveImage:(UIImage *)image imageUrl:(NSString *)urlString;

- (UIImage *)fetchImageWithImageUrlString:(NSString *)urlString;
- (BOOL)isImageExistsWithImageUrl:(NSString *)imageUrl;

@end
