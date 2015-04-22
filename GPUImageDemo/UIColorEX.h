//
//  UIColorEX.h
//  TmallClient-iOS-Common
//
//  Created by zhouyi.hyh@taobao.com on 12-7-9.
//  Copyright (c) 2012年 Tmall.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 *  @brief UIColor component interface
 */
@interface UIAColorComponents: NSObject

//! @brief Red component
@property(nonatomic,readonly) CGFloat red;
//! @brief Green component
@property(nonatomic,readonly) CGFloat green;
//! @brief Blue component
@property(nonatomic,readonly) CGFloat blue;
//! @brief Alpha component
@property(nonatomic,readonly) CGFloat alpha;

/*!
 *  @brief Initialize color components from color
 *  @param color
 *      An UIColor
 */
- (id)initWithColor:(UIColor *)color;
/*!
 *  @brief Creates and returns color components from color
 *  @see initWithColor:
 */
+ (id)componentsWithColor:(UIColor *)color;

@end

@interface UIColor (EX)

/*!
 *  @brief Color component property. nil if unavailable.
 */
@property(nonatomic,readonly) UIAColorComponents *components;

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(NSUInteger)alpha;
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue;

/*!
 *  @param string "aarrggbb" or "#aarrggbb" or "rrggbb" or "#rrggbb"
 */
+ (UIColor *)colorWithString:(NSString *)string;

/*!
 *  @brief Colored image sized 1x1
 */

- (UIColor *)colorWithAlpha:(CGFloat)alpha;

- (UIColor *)mixedColorWithColor:(UIColor *)color ratio:(CGFloat)ratio;

- (UIColor *)highligtedColorForBackgroundColor:(UIColor *)backgroundColor;

- (UIColor *)highligtedColor;

@end
