//
//  FunTipCollectionView.m
//  GPUImageDemo
//
//  Created by casa on 5/13/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "FunTipCollectionView.h"
#import "UIView+LayoutMethods.h"
#import "AssortTipsFactory.h"
#import "FunTipCollectionViewChildCell.h"
#import "FunTipCollectionViewMainCell.h"
#import "FunTipDataManager.h"

@interface FunTipCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, FunTipDataManagerDelegate>

@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) UICollectionView *childCollectionView;

@property (nonatomic, strong) UIImageView *pointerImageView;
@property (nonatomic, strong) UIImageView *childCollectionViewBackgroundImageView;

@property (nonatomic, strong) FunTipDataManager *dataManager;

@end

@implementation FunTipCollectionView

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.pointerImageView];
        [self addSubview:self.childCollectionViewBackgroundImageView];
        
        [self addSubview:self.childCollectionView];
        [self addSubview:self.mainCollectionView];
    }
    return self;
}

- (void)layoutSubviews
{
    self.childCollectionViewBackgroundImageView.height = 106;
    [self.childCollectionViewBackgroundImageView leftInContainer:0 shouldResize:YES];
    [self.childCollectionViewBackgroundImageView rightInContainer:0 shouldResize:YES];
    [self.childCollectionViewBackgroundImageView topInContainer:0 shouldResize:NO];
    
    self.pointerImageView.size = CGSizeMake(20, 10);
    [self.pointerImageView top:0 FromView:self.childCollectionViewBackgroundImageView];
    [self.pointerImageView leftInContainer:0 shouldResize:NO];
    
    self.childCollectionView.height = 90;
    [self.childCollectionView leftInContainer:0 shouldResize:YES];
    [self.childCollectionView rightInContainer:0 shouldResize:YES];
    [self.childCollectionView centerYEqualToView:self.childCollectionViewBackgroundImageView];
    
    self.mainCollectionView.height = 110;
    [self.mainCollectionView leftInContainer:0 shouldResize:YES];
    [self.mainCollectionView rightInContainer:0 shouldResize:YES];
    [self.mainCollectionView bottomInContainer:0 shouldResize:NO];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger result = 0;
    
    if (collectionView == self.mainCollectionView) {
        result = [self.dataManager mainCollectionViewCellCount];
    }
    
    if (collectionView == self.childCollectionView) {
        result = [self.dataManager childCollectionViewCellCount];
    }
    
    return result;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *resultCell = nil;
    
    if (collectionView == self.mainCollectionView) {
        FunTipCollectionViewMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
        cell.iconImageView.backgroundColor = [UIColor redColor];
        cell.isAlbum = indexPath.row % 2 ? YES : NO;
        resultCell = cell;
    }
    
    if (collectionView == self.childCollectionView) {
        FunTipCollectionViewChildCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"childCell" forIndexPath:indexPath];
        cell.iconImageView.backgroundColor = [UIColor blueColor];
        resultCell = cell;
    }
    
    return resultCell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.mainCollectionView) {
        FunTipCollectionViewMainCell *cell = (FunTipCollectionViewMainCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (cell.isAlbum) {
            self.dataManager.mainSelectedIndexPath = indexPath;
            [self showChildCollectionViewForCollectionView:collectionView withCell:cell atIndexPath:indexPath];
        } else {
            [self hideChildCollectionViewForCollectionView:collectionView withCell:cell atIndexPath:indexPath];
        }
    }
    
    if (collectionView == self.childCollectionView) {
        
    }
}

#pragma mark - FunTipDataManagerDelegate
- (void)dataManagerDidSuccessLoadTips:(FunTipDataManager *)dataManager
{
    [self.mainCollectionView reloadData];
    [self.childCollectionView reloadData];
}

#pragma mark - private methods
- (void)showChildCollectionViewForCollectionView:(UICollectionView *)collectionView withCell:(FunTipCollectionViewMainCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    self.childCollectionView.hidden = NO;
    self.childCollectionViewBackgroundImageView.hidden = NO;
    [self.pointerImageView centerXEqualToView:cell];
    self.pointerImageView.hidden = NO;
}

- (void)hideChildCollectionViewForCollectionView:(UICollectionView *)collectionView withCell:(FunTipCollectionViewMainCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    self.childCollectionView.hidden = YES;
    self.childCollectionViewBackgroundImageView.hidden = YES;
    self.pointerImageView.hidden = YES;
}

#pragma mark - getters and setters
- (UICollectionView *)childCollectionView
{
    if (_childCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(90, 90);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _childCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_childCollectionView registerClass:[FunTipCollectionViewChildCell class] forCellWithReuseIdentifier:@"childCell"];
        _childCollectionView.delegate = self;
        _childCollectionView.dataSource = self;
        _childCollectionView.showsVerticalScrollIndicator = NO;
        _childCollectionView.showsHorizontalScrollIndicator = NO;
        _childCollectionView.backgroundColor = [UIColor clearColor];
        _childCollectionView.hidden = YES;
    }
    return _childCollectionView;
}

- (UICollectionView *)mainCollectionView
{
    if (_mainCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(110, 110);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_mainCollectionView registerClass:[FunTipCollectionViewMainCell class] forCellWithReuseIdentifier:@"mainCell"];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.showsVerticalScrollIndicator = NO;
        _mainCollectionView.backgroundColor = [UIColor clearColor];
    }
    return _mainCollectionView;
}

- (UIImageView *)pointerImageView
{
    if (_pointerImageView == nil) {
        _pointerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FunTipPointer"]];
        _pointerImageView.backgroundColor = [UIColor clearColor];
        _pointerImageView.contentMode = UIViewContentModeScaleAspectFit;
        _pointerImageView.hidden = YES;
    }
    return _pointerImageView;
}

- (UIImageView *)childCollectionViewBackgroundImageView
{
    if (_childCollectionViewBackgroundImageView == nil) {
        _childCollectionViewBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FunTipChildCollectionViewBackground"]];
        _childCollectionViewBackgroundImageView.backgroundColor = [UIColor clearColor];
        _childCollectionViewBackgroundImageView.contentMode = UIViewContentModeScaleToFill;
        _childCollectionViewBackgroundImageView.hidden = YES;
    }
    return _childCollectionViewBackgroundImageView;
}

@end
