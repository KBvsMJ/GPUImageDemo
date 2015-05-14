//
//  FunTipDataManager.m
//  GPUImageDemo
//
//  Created by casa on 5/14/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "FunTipDataManager.h"

@implementation FunTipDataManager

#pragma mark - public methods
- (NSInteger)mainCollectionViewCellCount
{
    return 10;
}

- (NSInteger)childCollectionViewCellCount
{
    return 20;
}

- (NSDictionary *)contentForMainCollectionViewCellAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSDictionary *)contentForChildCollectionViewCellAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)loadTipsData
{
    if ([self.delegate respondsToSelector:@selector(dataManagerDidSuccessLoadTips:)]) {
        [self.delegate dataManagerDidSuccessLoadTips:self];
    }
}

@end
