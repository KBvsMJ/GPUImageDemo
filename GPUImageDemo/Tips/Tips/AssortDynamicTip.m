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
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "AssortLocalStorageManager.h"

@interface AssortDynamicTip () <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableDictionary *textfieldList;
@property (nonatomic, strong) NSMutableDictionary *imageviewList;
@property (nonatomic, strong) NSMutableDictionary *labelList;

@property (nonatomic, strong) AssortLocalStorageManager *localStorageManager;

@end

@implementation AssortDynamicTip

- (void)layoutSubviews
{
    [self.textfieldList enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isKindOfClass:[NSDictionary class]] && [obj isKindOfClass:[UIView class]]) {
            NSDictionary *item = (NSDictionary *)key;
            UIView *view = (UIView *)obj;
            [item[@"position"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self configPositionWithFrameDescription:obj view:view];
            }];
        }
    }];
    
    [self.imageviewList enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isKindOfClass:[NSDictionary class]] && [obj isKindOfClass:[UIView class]]) {
            NSDictionary *item = (NSDictionary *)key;
            UIView *view = (UIView *)obj;
            [item[@"position"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self configPositionWithFrameDescription:obj view:view];
            }];
        }
    }];
    
    [self.labelList enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isKindOfClass:[NSDictionary class]] && [obj isKindOfClass:[UIView class]]) {
            NSDictionary *item = (NSDictionary *)key;
            UIView *view = (UIView *)obj;
            [item[@"position"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self configPositionWithFrameDescription:obj view:view];
            }];
        }
    }];
}

#pragma mark - public methods
- (void)configWithTipInfo:(NSDictionary *)tipInfo
{
    NSString *jsonString = tipInfo[@"content"];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSArray *descriptionList = (NSArray *)jsonObject;
        for (NSDictionary *item in descriptionList) {
            
            UIView *result = nil;
            
            if ([item[@"itemName"] isEqualToString:@"label"]) {
                result = [self labelWithDescription:item];
                self.labelList[item] = result;
            }
            if ([item[@"itemName"] isEqualToString:@"image"]) {
                result = [self imageWithDescription:item];
                self.imageviewList[item] = result;
            }
            if ([item[@"itemName"] isEqualToString:@"textfield"]) {
                result = [self textfieldWithDescription:item];
                self.textfieldList[item] = result;
            }
            
            if (result) {
                [self addSubview:result];
            }
        }
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    __block NSInteger textLength = 20;
    
    [self.textfieldList enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj == textField) {
            NSDictionary *description = (NSDictionary *)key;
            textLength = [description[@"lengthLimit"] integerValue];
            
            *stop = YES;
        }
    }];
    
    if (textField.text.length > textLength) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, textLength)];
    }
}

#pragma mark - event response
- (void)didTappedTextField:(UITextField *)textField
{
    [textField becomeFirstResponder];
}

#pragma mark - private methods

- (void)configPositionWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    NSString *methodName = frameDescription[@"locateItem"];
    if ([methodName isEqualToString:@"width"]) {
        [self configWidthWithFrameDescription:frameDescription view:view];
    }
    
    if ([methodName isEqualToString:@"height"]) {
        [self configHeightWithFrameDescription:frameDescription view:view];
    }
    
    if ([methodName isEqualToString:@"topInContainer"]) {
        [self configTopInContainerWithFrameDescription:frameDescription view:view];
    }
    
    if ([methodName isEqualToString:@"bottomInContainer"]) {
        [self configBottomInContainerWithFrameDescription:frameDescription view:view];
    }
    
    if ([methodName isEqualToString:@"leftInContainer"]) {
        [self configLeftInContainerWithFrameDescription:frameDescription view:view];
    }
    
    if ([methodName isEqualToString:@"rightInContainer"]) {
        [self configRightInContainerWithFrameDescription:frameDescription view:view];
    }
}

#pragma mark - item factory methods
- (UILabel *)labelWithDescription:(NSDictionary *)discription
{
    NSString *text = discription[@"text"];
    NSString *textColor = discription[@"textColor"];
    CGFloat fontSize = [discription[@"fontSize"] floatValue];
    NSString *fontName = discription[@"fontName"];
    NSString *textAlignment = discription[@"textAlignment"];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    
    if ([text isKindOfClass:[NSString class]]) {
        label.text = text;
    }
    
    if ([textColor isKindOfClass:[NSString class]]) {
        label.textColor = [UIColor colorWithString:textColor];
    }
    
    if ([fontName isKindOfClass:[NSString class]]) {
        if ([fontName isEqualToString:@"default"]) {
            label.font = [UIFont systemFontOfSize:fontSize];
        } else {
            label.font = [UIFont fontWithName:fontName size:fontSize];
        }
    }
    
    if ([textAlignment isEqualToString:@"left"]) {
        label.textAlignment = NSTextAlignmentLeft;
    }
    if ([textAlignment isEqualToString:@"right"]) {
        label.textAlignment = NSTextAlignmentRight;
    }
    if ([textAlignment isEqualToString:@"center"]) {
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    [label sizeToFit];
    
    return label;
}

- (UIImageView *)imageWithDescription:(NSDictionary *)discription
{
    NSString *imageUrl = discription[@"imageUrl"];
    NSString *contentModel = discription[@"contentMode"];
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.backgroundColor = [UIColor clearColor];
    if ([contentModel isEqualToString:@"fill"]) {
        imageview.contentMode = UIViewContentModeScaleToFill;
    }
    if ([contentModel isEqualToString:@"fit"]) {
        imageview.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    if ([imageUrl isKindOfClass:[NSString class]]) {
        imageview.image = [self.localStorageManager fetchImageWithImageUrlString:imageUrl];
        if (imageview.image == nil) {
            [imageview setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [self.localStorageManager saveImage:image imageUrl:imageUrl];
            } failure:nil];
        }
    }
    
    return imageview;
}

- (UITextField *)textfieldWithDescription:(NSDictionary *)discription
{
    NSString *text = discription[@"text"];
    NSString *textColor = discription[@"textColor"];
    CGFloat fontSize = [discription[@"fontSize"] floatValue];
    NSString *fontName = discription[@"fontName"];
    NSString *textAlignment = discription[@"textAlignment"];
    
    UITextField *textfield = [[UITextField alloc] init];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.delegate = self;
    [textfield addTarget:self action:@selector(didTappedTextField:) forControlEvents:UIControlEventTouchUpInside];
    textfield.text = text;
    
    if ([textColor isKindOfClass:[NSString class]]) {
        textfield.textColor = [UIColor colorWithString:textColor];
    }
    
    if ([textAlignment isEqualToString:@"left"]) {
        textfield.textAlignment = NSTextAlignmentLeft;
    }
    if ([textAlignment isEqualToString:@"right"]) {
        textfield.textAlignment = NSTextAlignmentRight;
    }
    if ([textAlignment isEqualToString:@"center"]) {
        textfield.textAlignment = NSTextAlignmentCenter;
    }
    
    if ([fontName isKindOfClass:[NSString class]]) {
        if ([fontName isEqualToString:@"default"]) {
            textfield.font = [UIFont systemFontOfSize:fontSize];
        } else {
            textfield.font = [UIFont fontWithName:fontName size:fontSize];
        }
    }
    
    [textfield sizeToFit];
    
    return textfield;
}


#pragma mark - positon methods
- (void)configWidthWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat width = [frameDescription[@"value"] floatValue];
    view.width = width;
}

- (void)configHeightWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat height = [frameDescription[@"value"] floatValue];
    view.height = height;
}

- (void)configTopInContainerWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat top = [frameDescription[@"value"] floatValue];
    BOOL shouldResize = [frameDescription[@"shouldResize"] boolValue];
    [view topInContainer:top shouldResize:shouldResize];
}

- (void)configBottomInContainerWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat bottom = [frameDescription[@"value"] floatValue];
    BOOL shouldResize = [frameDescription[@"shouldResize"] boolValue];
    [view bottomInContainer:bottom shouldResize:shouldResize];
}

- (void)configLeftInContainerWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat left = [frameDescription[@"value"] floatValue];
    BOOL shouldResize = [frameDescription[@"shouldResize"] boolValue];
    [view leftInContainer:left shouldResize:shouldResize];
}

- (void)configRightInContainerWithFrameDescription:(NSDictionary *)frameDescription view:(UIView *)view
{
    CGFloat right = [frameDescription[@"value"] floatValue];
    BOOL shouldResize = [frameDescription[@"shouldResize"] boolValue];
    [view rightInContainer:right shouldResize:shouldResize];
}
     
#pragma mark - getters and setters
- (NSMutableDictionary *)textfieldList
{
    if (_textfieldList == nil) {
        _textfieldList = [[NSMutableDictionary alloc] init];
    }
    return _textfieldList;
}

- (NSMutableDictionary *)imageviewList
{
    if (_imageviewList == nil) {
        _imageviewList = [[NSMutableDictionary alloc] init];
    }
    return _imageviewList;
}

- (NSMutableDictionary *)labelList
{
    if (_labelList == nil) {
        _labelList = [[NSMutableDictionary alloc] init];
    }
    return _labelList;
}

- (AssortLocalStorageManager *)localStorageManager
{
    if (_localStorageManager == nil) {
        _localStorageManager = [[AssortLocalStorageManager alloc] init];
    }
    return _localStorageManager;
}



@end
