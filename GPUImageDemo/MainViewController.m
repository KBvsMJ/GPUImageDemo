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
#import "BrightnessViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) UIButton *multiFilterButton;
@property (nonatomic, strong) UIButton *brightnessButton;

@end

@implementation MainViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.multiFilterButton];
    [self.view addSubview:self.brightnessButton];
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
}

#pragma mark - event response
- (void)didTappedMultiFilterButton:(UIButton *)button
{
    MultiFilterViewController *viewController = [[MultiFilterViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didTappedBrightnessButton:(UIButton *)button
{
    BrightnessViewController *viewController = [[BrightnessViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - getters and setters
- (UIButton *)multiFilterButton
{
    if (_multiFilterButton == nil) {
        _multiFilterButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_multiFilterButton addTarget:self action:@selector(didTappedMultiFilterButton:) forControlEvents:UIControlEventTouchUpInside];
        [_multiFilterButton setTitle:@"Multi Filter" forState:UIControlStateNormal];
    }
    return _multiFilterButton;
}

- (UIButton *)brightnessButton
{
    if (_brightnessButton == nil) {
        _brightnessButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_brightnessButton addTarget:self action:@selector(didTappedBrightnessButton:) forControlEvents:UIControlEventTouchUpInside];
        [_brightnessButton setTitle:@"Brightness" forState:UIControlStateNormal];
    }
    return _brightnessButton;
}

@end
