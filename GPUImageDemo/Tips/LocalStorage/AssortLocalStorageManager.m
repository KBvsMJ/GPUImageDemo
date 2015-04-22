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

@interface AssortLocalStorageManager ()

@property (nonatomic, strong) SQLiteManager *sqliteManager;

@end

@implementation AssortLocalStorageManager

#pragma mark - pubic methods
- (NSArray *)localTips
{
    NSString *sqlString = @"SELECT content FROM 'AssortTips';";
    NSArray *result = [self.sqliteManager getRowsForQuery:sqlString];
    NSMutableArray *contentList = [[NSMutableArray alloc] init];
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [contentList addObject:obj[@"content"]];
    }];
    return contentList;
}

- (void)saveTipWithContent:(NSString *)contentString
{
    NSString *sqlString = [NSString stringWithFormat:@"INSERT INTO AssortTips (content) VALUES ('%@');", contentString];
    [self.sqliteManager doQuery:sqlString];
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

@end
