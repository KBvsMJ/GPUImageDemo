//
//  FunTipDataManager.h
//  GPUImageDemo
//
//  Created by casa on 5/14/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FunTipDataManager;

@protocol FunTipDataManagerDelegate <NSObject>

- (void)dataManagerDidSuccessLoadTips:(FunTipDataManager *)dataManager;

@end

@interface FunTipDataManager : NSObject

@property (nonatomic, weak) id<FunTipDataManagerDelegate> delegate;
@property (nonatomic, copy) NSIndexPath *mainSelectedIndexPath;

- (NSInteger)mainCollectionViewCellCount;
- (NSInteger)childCollectionViewCellCount;

- (NSDictionary *)contentForMainCollectionViewCellAtIndexPath:(NSIndexPath *)indexPath;
- (NSDictionary *)contentForChildCollectionViewCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)loadTipsData;

@end
