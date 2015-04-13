//
//  BSAssortCanvasView.m
//  GPUImageDemo
//
//  Created by casa on 4/13/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "BSAssortCanvasView.h"
#import "ZDStickerView.h"

@interface BSAssortCanvasView ()

@property (nonatomic, assign) CGPoint addPosition;

@end

@implementation BSAssortCanvasView

- (void)addView:(UIView *)view width:(CGFloat)width height:(CGFloat)height
{
    view.frame = CGRectMake(self.addPosition.x, self.addPosition.y, 100, 100 * height / width);
    [self addStickerView:view];
}

- (UIImage *)generateImage
{
    [self hideEditingHandles];
    UIImage *image = [self screenShot:@[self]];
    [self showEditingHandles];
    return image;
}

- (UIImage *)screenShot:(NSArray *)views
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 0.0);
    
    for (UIView *view in views)
    {
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}

#pragma mark - private methods
- (void)addStickerView:(UIView *)view
{
    ZDStickerView *stickerView = [[ZDStickerView alloc] initWithFrame:CGRectMake(self.addPosition.x, self.addPosition.y, view.frame.size.width, view.frame.size.height)];
    stickerView.contentView = view;
    [stickerView showEditingHandles];
    [stickerView setButton:ZDSTICKERVIEW_BUTTON_RESIZE image:[UIImage imageNamed:@"ZDBtn2"]];
    [stickerView setButton:ZDSTICKERVIEW_BUTTON_DEL image:[UIImage imageNamed:@"ZDBtn3"]];
    [self addSubview:stickerView];
    self.addPosition = CGPointMake(self.addPosition.x + 5, self.addPosition.y + 5);
}

- (void)showEditingHandles
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[ZDStickerView class]]) {
            ZDStickerView *stickerView = (ZDStickerView *)obj;
            [stickerView showEditingHandles];
        }
    }];
}

- (void)hideEditingHandles
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[ZDStickerView class]]) {
            ZDStickerView *stickerView = (ZDStickerView *)obj;
            [stickerView hideEditingHandles];
        }
    }];
}

@end
