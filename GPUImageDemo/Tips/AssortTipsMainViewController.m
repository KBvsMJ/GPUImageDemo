//
//  AssortTipsMainViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/15/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortTipsMainViewController.h"
#import "UIView+LayoutMethods.h"
#import "AssortTipsCollectionViewCell.h"
#import "AssortTipsFactory.h"

@interface AssortTipsMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *tipView;

@property (nonatomic, strong) AssortTipsFactory *tipsFactory;

@end

@implementation AssortTipsMainViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.imageView leftInContainer:10 shouldResize:YES];
    [self.imageView rightInContainer:10 shouldResize:YES];
    self.imageView.height = self.imageView.width;
    [self.imageView topInContainer:74 shouldResize:NO];
    
    self.collectionView.height = 100;
    [self.collectionView fillWidth];
    [self.collectionView bottomInContainer:0 shouldResize:NO];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AssortTipsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tipView && self.tipView.superview) {
        [self.tipView removeFromSuperview];
    }
    
    self.tipView = [self.tipsFactory tipOfType:indexPath.row];
    
    if (self.tipView) {
        [self.imageView addSubview:self.tipView];
        [self.tipView fill];
    }
}

#pragma mark - getters and setters
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DemoImage"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.backgroundColor = [UIColor grayColor];
        _imageView.userInteractionEnabled = YES;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(80, 80);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[AssortTipsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

- (AssortTipsFactory *)tipsFactory
{
    if (_tipsFactory == nil) {
        _tipsFactory = [[AssortTipsFactory alloc] init];
    }
    return _tipsFactory;
}

@end
