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

@interface MainViewController ()

@property (nonatomic, strong) UIButton *multiFilterButton;
@property (nonatomic, strong) UIButton *brightnessButton;
@property (nonatomic, strong) UIButton *seperatorButton;

@end

@implementation MainViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.multiFilterButton];
    [self.view addSubview:self.brightnessButton];
    [self.view addSubview:self.seperatorButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.multiFilterButton.size = CGSizeMake(80, 40);
    [self.multiFilterButton topInContainer:70 shouldResize:NO];
    [self.multiFilterButton leftInContainer:10 shouldResize:NO];
    
    [self.brightnessButton sizeEqualToView:self.multiFilterButton];
    [self.brightnessButton topEqualToView:self.multiFilterButton];
    [self.brightnessButton right:10 FromView:self.multiFilterButton];
    
    [self.seperatorButton sizeEqualToView:self.multiFilterButton];
    [self.seperatorButton topEqualToView:self.multiFilterButton];
    [self.seperatorButton right:10 FromView:self.brightnessButton];
}

#pragma mark - event response
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
    ImageSeperaterViewController *viewController = [[ImageSeperaterViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - getters and setters
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
