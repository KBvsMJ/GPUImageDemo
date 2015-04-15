//
//  AssortTipsFactory.h
//  GPUImageDemo
//
//  Created by casa on 4/15/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AssortTipsType)
{
    AssortTipsTypeNewsPerson,
    AssortTipsTypeNewsBar,
    AssortTipsTypeKTV,
    AssortTipsTypeTimes,
    AssortTipsTypeMagazine,
    AssortTipsTypeMagazineRound,
    AssortTipsTypeMagazineNanRenZhuang,
    AssortTipsTypeMagazineFashionBaby
};

@interface AssortTipsFactory : NSObject

- (UIView *)tipOfType:(AssortTipsType)type;

@end
