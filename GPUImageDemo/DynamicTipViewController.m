//
//  DynamicTipViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/22/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "DynamicTipViewController.h"
#import "AssortDynamicTip.h"
#import "UIView+LayoutMethods.h"
#import "AssortLocalStorageManager.h"

@interface DynamicTipViewController ()

@property (nonatomic, strong) AssortDynamicTip *tip;
@property (nonatomic, strong) AssortLocalStorageManager *storageManager;

@end

@implementation DynamicTipViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tip];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tip topInContainer:70 shouldResize:YES];
    [self.tip bottomInContainer:0 shouldResize:YES];
    [self.tip leftInContainer:0 shouldResize:YES];
    [self.tip rightInContainer:0 shouldResize:YES];
}

#pragma mark - getters and setters
- (AssortDynamicTip *)tip
{
    if (_tip == nil) {
        _tip = [[AssortDynamicTip alloc] init];
        [_tip configWithTipInfo:[self.storageManager localTips][0]];
    }
    return _tip;
}

- (AssortLocalStorageManager *)storageManager
{
    if (_storageManager == nil) {
        _storageManager = [[AssortLocalStorageManager alloc] init];
    }
    return _storageManager;
}

@end
