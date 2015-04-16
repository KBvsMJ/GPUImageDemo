//
//  AssortTipsFactory.h
//  GPUImageDemo
//
//  Created by casa on 4/15/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AssortTipsType)
{
    AssortTipsTypeKTV = 1,
    AssortTipsTypeMagazine = 2,
    AssortTipsTypeNewsPerson = 3,
    AssortTipsTypeNewsBar = 4,
    AssortTipsTypeTimes,
    AssortTipsTypeMagazineRound,
    AssortTipsTypeMagazineNanRenZhuang,
    AssortTipsTypeMagazineFashionBaby
};

@interface AssortTipsFactory : NSObject

- (UIView *)tipOfType:(AssortTipsType)type;

@end
