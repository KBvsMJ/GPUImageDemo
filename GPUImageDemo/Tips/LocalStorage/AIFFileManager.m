//
//  LPListManager.m
//
//  Created by casa on 10/4/11.
//  Copyright 2011 Anjuke. All rights reserved.
//

#import "AIFFileManager.h"

@interface AIFFileManager ()

@property (nonatomic, strong, readwrite) NSString *fileName;
@property (nonatomic, readwrite) BOOL isBundle;

@end

@implementation AIFFileManager

#pragma mark - public method
- (BOOL)isExistWithFileNameInLibrary:(NSString *)fileName
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:fileName];
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

- (BOOL)isExistWithFileNameInBundle:(NSString *)fileName type:(NSString *)type;
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

- (BOOL)saveData:(id)data withFileName:(NSString *)fileName
{
    if ([self isExistWithFileNameInLibrary:fileName]) {
        [self deleteFile:fileName];
    }
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    [data writeToFile:filePath atomically:YES];
    return YES;
}

- (BOOL)saveString:(NSString *)string withFileName:(NSString *)fileName
{
    if ([self isExistWithFileNameInLibrary:fileName]) {
        [self deleteFile:fileName];
    }
    
    NSError *error = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:fileName];
    
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    return !error;
}

- (BOOL)deleteFile:(NSString *)fileName;
{
    if (![self isExistWithFileNameInLibrary:fileName]) {
        return YES;
    }
    
    NSError *error = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    
    if (![[NSFileManager defaultManager] removeItemAtPath:filePath error:&error]) {
        return NO;
    }
    
    return YES;
}

- (NSData *)loadDataWithFileName:(NSString *)fileName type:(NSString *)type
{
    BOOL fileFounded = YES;
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", fileName, type]];
    
    //这里不使用[self isPlistFileExistWithPlistFileName:(NSString *)plistFileName]的原因是因为libraryFilePath到后面有可能要用的，所以后面就直接用NSFileManager来判断了。
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        fileFounded = NO;
    }
    
    if (fileFounded == NO) {
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            fileFounded = YES;
        }
    }
    
    if (fileFounded) {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
        return data;
    }
    
    return nil;
}

- (NSString *)loadStringWithFileName:(NSString *)fileName type:(NSString *)type
{
    NSData *stringData = [self loadDataWithFileName:fileName type:type];
    NSString *content = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return content;
}

@end
