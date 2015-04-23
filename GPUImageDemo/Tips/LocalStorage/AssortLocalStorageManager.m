//
//  AssortLocalStorageManager.m
//  GPUImageDemo
//
//  Created by casa on 4/22/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortLocalStorageManager.h"
#import "SQLiteManager.h"
#import "AssortLocalStorageMigrater.h"
#import "NSString+MD5Extends.h"
#import "AIFFileManager.h"

@interface AssortLocalStorageManager ()

@property (nonatomic, strong) SQLiteManager *sqliteManager;
@property (nonatomic, strong) AIFFileManager *localFileManager;

@end

@implementation AssortLocalStorageManager

#pragma mark - pubic methods
- (NSArray *)localTips
{
    NSString *sqlString = @"SELECT * FROM 'AssortTips';";
    NSArray *result = [self.sqliteManager getRowsForQuery:sqlString];
    return result;
}

- (void)saveTipWithContent:(NSString *)contentString
{
    NSString *sqlString = [NSString stringWithFormat:@"INSERT INTO AssortTips (content) VALUES ('%@');", contentString];
    [self.sqliteManager doQuery:sqlString];
}

- (void)saveImage:(UIImage *)image imageUrl:(NSString *)urlString
{
    [self.localFileManager saveData:UIImagePNGRepresentation(image) withFileName:[NSString stringWithFormat:@"%@.png", [urlString md5]]];
}

- (UIImage *)fetchImageWithImageUrlString:(NSString *)urlString
{
    NSString *urlHash = [urlString md5];
    if ([self.localFileManager isExistWithFileNameInLibrary:[NSString stringWithFormat:@"%@.png", urlHash]]) {
        UIImage *image = [[UIImage alloc] initWithData:[self.localFileManager loadDataWithFileName:urlHash type:@"png"]];
        return image;
    } else {
        return nil;
    }
}

- (BOOL)isImageExistsWithImageUrl:(NSString *)imageUrl
{
    NSString *imageHash = [imageUrl md5];
    if ([self.localFileManager isExistWithFileNameInLibrary:[NSString stringWithFormat:@"%@.png", imageHash]]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - getters and setters
- (SQLiteManager *)sqliteManager
{
    if (_sqliteManager == nil) {
        _sqliteManager = [[SQLiteManager alloc] initWithDatabaseNamed:@"BSAssortTip.sqlite"];
        _sqliteManager.migrator = [[AssortLocalStorageMigrater alloc] init];
        [_sqliteManager openDatabase];
    }
    return _sqliteManager;
}

- (AIFFileManager *)localFileManager
{
    if (_localFileManager == nil) {
        _localFileManager = [[AIFFileManager alloc] init];
    }
    return _localFileManager;
}

@end
