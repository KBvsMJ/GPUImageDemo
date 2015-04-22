//
//  AssortDynamicTip.m
//  GPUImageDemo
//
//  Created by casa on 4/22/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortDynamicTip.h"
#import "UIView+LayoutMethods.h"
#import "UIColorEX.h"

@interface AssortDynamicTip ()

@property (nonatomic, strong) NSMutableArray *textfieldList;
@property (nonatomic, strong) NSMutableArray *imageviewList;
@property (nonatomic, strong) NSMutableArray *labelList;

@property (nonatomic, strong) NSDictionary *frameStrategy;
@property (nonatomic, strong) NSMutableArray *frameDescriptionList;

@end

@implementation AssortDynamicTip

#pragma mark - public methods
- (void)configWithJson:(NSString *)jsonString
{
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSArray *descriptionList = (NSArray *)jsonObject;
    }
}

- (void)configPositionWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    NSString *methodName = self.frameStrategy[frameDescription[@"methodName"]];
    SEL method = NSSelectorFromString(methodName);
    if ([self respondsToSelector:method]) {
        [self performSelector:method withObject:frameDescription withObject:view];
    }
}

#pragma mark - item factory methods
- (UILabel *)labelWithDescription:(NSDictionary *)discription
{
    NSString *text = discription[@"text"];
    NSString *textColor = discription[@"textColor"];
    UILabel *label = [[UILabel alloc] init];
    return nil;
}

#pragma mark - positon methods
- (void)configWidthWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat width = [frameDescription[@"Width"] floatValue];
    view.width = width;
}

- (void)configHeightWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat height = [frameDescription[@"Height"] floatValue];
    view.height = height;
}

- (void)configTopInContainerWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat top = [frameDescription[@"Top"] floatValue];
    BOOL shouldResize = [frameDescription[@"ShouldResize"] boolValue];
    [view topInContainer:top shouldResize:shouldResize];
}

- (void)configBottomInContainerWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat bottom = [frameDescription[@"Bottom"] floatValue];
    BOOL shouldResize = [frameDescription[@"ShouldResize"] boolValue];
    [view bottomInContainer:bottom shouldResize:shouldResize];
}

- (void)configLeftInContainerWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat left = [frameDescription[@"Left"] floatValue];
    BOOL shouldResize = [frameDescription[@"ShouldResize"] boolValue];
    [view leftInContainer:left shouldResize:shouldResize];
}

- (void)configRightInContainerWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat right = [frameDescription[@"Right"] floatValue];
    BOOL shouldResize = [frameDescription[@"ShouldResize"] boolValue];
    [view rightInContainer:right shouldResize:shouldResize];
}
     
#pragma mark - getters and setters
- (NSDictionary *)frameStrategy
{
    if (_frameStrategy == nil) {
        _frameStrategy = @{
                           @"Width":@"configWidthFrameDescription:view:",
                           @"Height":@"configHeightFrameDescription:view:",
                           @"TopInContainer":@"configTopInContainerFrameDescription:view:",
                           @"BottomInContainer":@"configBottomInContainerFrameDescription:view:",
                           @"LeftInContainer":@"configLeftInContainerFrameDescription:view:",
                           @"RightInContainer":@"configRightInContainerFrameDescription:view:"
                           };
    }
    return _frameStrategy;
}

- (NSMutableArray *)textfieldList
{
    if (_textfieldList == nil) {
        _textfieldList = [[NSMutableArray alloc] init];
    }
    return _textfieldList;
}

- (NSMutableArray *)imageviewList
{
    if (_imageviewList == nil) {
        _imageviewList = [[NSMutableArray alloc] init];
    }
    return _imageviewList;
}

- (NSMutableArray *)labelList
{
    if (_labelList == nil) {
        _labelList = [[NSMutableArray alloc] init];
    }
    return _labelList;
}



@end
