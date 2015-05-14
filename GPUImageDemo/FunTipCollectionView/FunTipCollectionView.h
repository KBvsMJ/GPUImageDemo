//
//  FunTipCollectionView.h
//  GPUImageDemo
//
//  Created by casa on 5/13/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FunTipCollectionView;

@protocol FunTipCollectionViewDelegate <NSObject>

- (void)collectionView:(FunTipCollectionView *)collectionView didSelectedTip:(UIView *)tipView;

@end

@interface FunTipCollectionView : UIView

@property (nonatomic, weak) id<FunTipCollectionViewDelegate> delegate;

@end
