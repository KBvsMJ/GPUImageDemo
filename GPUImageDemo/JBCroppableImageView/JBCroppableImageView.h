//
//  CropImageView.h
//  Crop Demo
//
//  Created by Daniel Sanche on 12/4/2013.
//  Copyright (c) 2013 Mobile one2one. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBCroppableLayer.h"

@interface JBCroppableImageView : UIImageView

@property (nonatomic, strong, readonly) JBCroppableLayer *pointsView;

-(void)crop;
-(void)reverseCrop;

-(UIImage *)getCroppedImageWithTransparentBorders:(BOOL)transparent;
-(UIImage *)getCroppedImage;

- (void)addPoint;
- (void)removePoint;
@end
