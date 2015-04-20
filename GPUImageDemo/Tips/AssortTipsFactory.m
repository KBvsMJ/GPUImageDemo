//
//  AssortTipsFactory.m
//  GPUImageDemo
//
//  Created by casa on 4/15/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipsFactory.h"

#import "AssortTipKtv.h"
#import "AssortTipMagazine.h"
#import "AssortTipNewsPerson.h"
#import "AssortTipNewsBar.h"
#import "AssortTipTimes.h"
#import "AssortTipFashionBaby.h"
#import "AssortTipNanRenZhuang.h"
#import "AssortTipRound.h"

@interface AssortTipsFactory ()

@property (nonatomic, strong) NSMutableDictionary *tipStore;

@end

@implementation AssortTipsFactory

#pragma mark - public methods
- (UIView *)tipOfType:(AssortTipsType)type
{
    UIView *result = self.tipStore[@(type)];
    if (result == nil) {
        result = [self generateTipOfType:type];
    }
    return result;
}

#pragma mark - private methods
- (UIView *)generateTipOfType:(AssortTipsType)type
{
    UIView *tipView = nil;
    switch (type) {
        case AssortTipsTypeKTV:
            tipView = [[AssortTipKtv alloc] init];
            break;
            
        case AssortTipsTypeMagazine:
            tipView = [[AssortTipMagazine alloc] init];
            break;
            
        case AssortTipsTypeNewsPerson:
            tipView = [[AssortTipNewsPerson alloc] init];
            break;
            
        case AssortTipsTypeNewsBar:
            tipView = [[AssortTipNewsBar alloc] init];
            break;
            
        case AssortTipsTypeTimes:
            tipView = [[AssortTipTimes alloc] init];
            break;
            
        case AssortTipsTypeMagazineFashionBaby:
            tipView = [[AssortTipFashionBaby alloc] init];
            break;
            
        case AssortTipsTypeMagazineNanRenZhuang:
            tipView = [[AssortTipNanRenZhuang alloc] init];
            break;
            
        case AssortTipsTypeMagazineRound:
            tipView = [[AssortTipRound alloc] init];
            break;
            
        default:
            break;
    }

    if (tipView) {
        self.tipStore[@(type)] = tipView;
    }

    return tipView;
}

#pragma mark - getters and setters
- (NSMutableDictionary *)tipStore
{
    if (_tipStore == nil) {
        _tipStore = [[NSMutableDictionary alloc] init];
    }
    return _tipStore;
}

@end
