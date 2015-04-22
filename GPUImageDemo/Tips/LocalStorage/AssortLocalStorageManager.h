//
//  AssortLocalStorageManager.h
//  GPUImageDemo
//
//  Created by casa on 4/22/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssortLocalStorageManager : NSObject

- (NSArray *)localTips;
- (void)saveTipWithContent:(NSString *)contentString;

@end
