//
//  AssortStoreViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/14/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortStoreViewController.h"
#import "AssortStoreItemCollectionViewCell.h"
#import "UIView+LayoutMethods.h"

@interface AssortStoreViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation AssortStoreViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView topInContainer:70 shouldResize:YES];
    [self.collectionView leftInContainer:0 shouldResize:YES];
    [self.collectionView rightInContainer:0 shouldResize:YES];
    [self.collectionView bottomInContainer:0 shouldResize:YES];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AssortStoreItemCollectionViewCell *selectedCell = (AssortStoreItemCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(storeViewController:didSelectedItem:)]) {
        [self.delegate storeViewController:self didSelectedItem:selectedCell.itemImageView.image];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AssortStoreItemCollectionViewCell *cell = (AssortStoreItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.itemImageView.image = [UIImage imageNamed:@"DemoImage"];
    return cell;
}

#pragma mark - getters and setters
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 3;
        flowLayout.minimumLineSpacing = 3;
        flowLayout.itemSize = CGSizeMake(100, 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[AssortStoreItemCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
