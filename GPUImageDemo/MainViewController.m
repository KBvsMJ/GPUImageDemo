//
//  MainViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/3/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+LayoutMethods.h"
#import "MultiFilterViewController.h"
#import "ImageSeperaterViewController.h"
#import "FilterTuneViewController.h"
#import "AssortMainViewController.h"
#import "AssortTipsMainViewController.h"
#import "ImageAutoFilterViewController.h"
#import "DynamicTipViewController.h"
#import "FunTipsViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) UIButton *multiFilterButton;
@property (nonatomic, strong) UIButton *brightnessButton;
@property (nonatomic, strong) UIButton *seperatorButton;
@property (nonatomic, strong) UIButton *assortButton;
@property (nonatomic, strong) UIButton *tipsButton;
@property (nonatomic, strong) UIButton *optimizeButton;
@property (nonatomic, strong) UIButton *dynamicTipButton;
@property (nonatomic, strong) UIButton *funTipsButton;

@end

@implementation MainViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.multiFilterButton];
    [self.view addSubview:self.brightnessButton];
    [self.view addSubview:self.seperatorButton];
    [self.view addSubview:self.assortButton];
    [self.view addSubview:self.tipsButton];
    [self.view addSubview:self.optimizeButton];
    [self.view addSubview:self.dynamicTipButton];
    [self.view addSubview:self.funTipsButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat width = ( self.view.width - 25 ) / 4.0f;

    self.multiFilterButton.size = CGSizeMake(width, 40);
    [self.multiFilterButton topInContainer:70 shouldResize:NO];
    [self.multiFilterButton leftInContainer:5 shouldResize:NO];

    [self.brightnessButton sizeEqualToView:self.multiFilterButton];
    [self.brightnessButton topEqualToView:self.multiFilterButton];
    [self.brightnessButton right:5 FromView:self.multiFilterButton];

    [self.seperatorButton sizeEqualToView:self.multiFilterButton];
    [self.seperatorButton topEqualToView:self.multiFilterButton];
    [self.seperatorButton right:5 FromView:self.brightnessButton];

    [self.assortButton sizeEqualToView:self.seperatorButton];
    [self.assortButton topEqualToView:self.multiFilterButton];
    [self.assortButton right:5 FromView:self.seperatorButton];
    
    // 第二行
    [self.tipsButton sizeEqualToView:self.multiFilterButton];
    [self.tipsButton top:10 FromView:self.multiFilterButton];
    [self.tipsButton leftEqualToView:self.multiFilterButton];
    
    [self.optimizeButton sizeEqualToView:self.tipsButton];
    [self.optimizeButton topEqualToView:self.tipsButton];
    [self.optimizeButton right:5 FromView:self.tipsButton];
    
    [self.dynamicTipButton sizeEqualToView:self.optimizeButton];
    [self.dynamicTipButton topEqualToView:self.optimizeButton];
    [self.dynamicTipButton right:5 FromView:self.optimizeButton];
    
    [self.funTipsButton sizeEqualToView:self.dynamicTipButton];
    [self.funTipsButton topEqualToView:self.dynamicTipButton];
    [self.funTipsButton right:5 FromView:self.dynamicTipButton];
}

#pragma mark - event response
- (void)didTappedFunTipsButton:(UIButton *)button
{
    FunTipsViewController *viewController = [[FunTipsViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didTappedDynamicButton:(UIButton *)button
{
    DynamicTipViewController *viewController = [[DynamicTipViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didTappedOptimizeButton:(UIButton *)button
{
    ImageAutoFilterViewController *viewController = [[ImageAutoFilterViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didTappedTipsButton:(UIButton *)button
{
    AssortTipsMainViewController *viewController = [[AssortTipsMainViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didTappedMultiFilterButton:(UIButton *)button
{
    MultiFilterViewController *viewController = [[MultiFilterViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didTappedBrightnessButton:(UIButton *)button
{
    FilterTuneViewController *viewController = [[FilterTuneViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didTappedSeperaterButton:(UIButton *)button
{
//    ImageSeperaterViewController *viewController = [[ImageSeperaterViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didTappedAssortButton:(UIButton *)button
{
    AssortMainViewController *viewController = [[AssortMainViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - getters and setters
- (UIButton *)funTipsButton
{
    if (_funTipsButton == nil) {
        _funTipsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_funTipsButton setTitle:@"范儿贴纸" forState:UIControlStateNormal];
        [_funTipsButton addTarget:self action:@selector(didTappedFunTipsButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _funTipsButton;
}

- (UIButton *)dynamicTipButton
{
    if (_dynamicTipButton == nil) {
        _dynamicTipButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_dynamicTipButton setTitle:@"动态贴纸" forState:UIControlStateNormal];
        [_dynamicTipButton addTarget:self action:@selector(didTappedDynamicButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dynamicTipButton;
}

- (UIButton *)optimizeButton
{
    if (_optimizeButton == nil) {
        _optimizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_optimizeButton setTitle:@"一键优化" forState:UIControlStateNormal];
        [_optimizeButton addTarget:self action:@selector(didTappedOptimizeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _optimizeButton;
}

- (UIButton *)tipsButton
{
    if (_tipsButton == nil) {
        _tipsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_tipsButton addTarget:self action:@selector(didTappedTipsButton:) forControlEvents:UIControlEventTouchUpInside];
        [_tipsButton setTitle:@"tips" forState:UIControlStateNormal];
    }
    return _tipsButton;
}

- (UIButton *)assortButton
{
    if (_assortButton == nil) {
        _assortButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_assortButton addTarget:self action:@selector(didTappedAssortButton:) forControlEvents:UIControlEventTouchUpInside];
        [_assortButton setTitle:@"搭配" forState:UIControlStateNormal];
    }
    return _assortButton;
}

- (UIButton *)multiFilterButton
{
    if (_multiFilterButton == nil) {
        _multiFilterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_multiFilterButton addTarget:self action:@selector(didTappedMultiFilterButton:) forControlEvents:UIControlEventTouchUpInside];
        [_multiFilterButton setTitle:@"探索" forState:UIControlStateNormal];
    }
    return _multiFilterButton;
}

- (UIButton *)brightnessButton
{
    if (_brightnessButton == nil) {
        _brightnessButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_brightnessButton addTarget:self action:@selector(didTappedBrightnessButton:) forControlEvents:UIControlEventTouchUpInside];
        [_brightnessButton setTitle:@"调滤镜" forState:UIControlStateNormal];
    }
    return _brightnessButton;
}

- (UIButton *)seperatorButton
{
    if (_seperatorButton == nil) {
        _seperatorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_seperatorButton addTarget:self action:@selector(didTappedSeperaterButton:) forControlEvents:UIControlEventTouchUpInside];
        [_seperatorButton setTitle:@"切图" forState:UIControlStateNormal];
    }
    return _seperatorButton;
}

@end
