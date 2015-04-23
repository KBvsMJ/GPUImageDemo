//
//  LPListManager.h
//
//  Created by casa on 10/4/11.
//  Copyright 2011 Anjuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AIFFileManager : NSObject

/*
    以下涉及的filename都不需要带.plist的后缀, 如果文件名是@"abc.plist",那么传入的参数就是 @"abc"
 
    所有的plist文件都是在NSLibraryDirectory目录下。
 */

- (BOOL)isExistWithFileNameInLibrary:(NSString *)fileName;
- (BOOL)isExistWithFileNameInBundle:(NSString *)fileName type:(NSString *)type;

/** 
    如果文件不存在的话就新建一个，如果文件已经存在的话，就会删掉已经有的文件重新创建一个
 */
- (BOOL)saveData:(NSData *)data withFileName:(NSString *)fileName;
- (BOOL)saveString:(NSString *)string withFileName:(NSString *)fileName;

/** 如果文件不存在的话返回YES */
- (BOOL)deleteFile:(NSString *)fileName;

- (NSData *)loadDataWithFileName:(NSString *)fileName type:(NSString *)type;
- (NSString *)loadStringWithFileName:(NSString *)fileName type:(NSString *)type;


@end
