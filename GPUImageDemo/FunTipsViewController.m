//
//  FunTipsViewController.m
//  GPUImageDemo
//
//  Created by casa on 5/13/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "FunTipsViewController.h"
#import "FunTipCollectionView.h"
#import "UIView+LayoutMethods.h"

@interface FunTipsViewController ()

@property (nonatomic, strong) FunTipCollectionView *collectionView;

@end

@implementation FunTipsViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.collectionView.height = 230.0f;
    [self.collectionView leftInContainer:0 shouldResize:YES];
    [self.collectionView rightInContainer:0 shouldResize:YES];
    [self.collectionView bottomInContainer:50 shouldResize:NO];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
}

#pragma mark - getters and setters
- (FunTipCollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[FunTipCollectionView alloc] init];
    }
    return _collectionView;
}

@end
