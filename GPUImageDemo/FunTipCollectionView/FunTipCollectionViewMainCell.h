//
//  FunTipCollectionViewMainCell.h
//  GPUImageDemo
//
//  Created by casa on 5/14/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunTipCollectionViewMainCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isAlbum;

@property (nonatomic, strong, readonly) UIImageView *iconImageView;
@property (nonatomic, strong, readonly) UIImageView *cornerIconImageView;

@end
