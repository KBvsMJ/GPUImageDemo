//
//  AssortLocalStorageMigrater.m
//  GPUImageDemo
//
//  Created by casa on 4/22/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "AssortLocalStorageMigrater.h"
#import "SQLiteManager.h"

@implementation AssortLocalStorageMigrater

@synthesize migrateList = _migrateList;
@synthesize versionList = _versionList;

- (NSDictionary *)migrateList
{
    if (_migrateList == nil) {
        
        SQLiteManagerMigrateObject *initMigrateObject = [[SQLiteManagerMigrateObject alloc] init];
        initMigrateObject.upSql = @"CREATE TABLE IF NOT EXISTS 'AssortTips' (id integer primary key autoincrement, content text);";
        initMigrateObject.downSql = @"";
        
        SQLiteManagerMigrateObject *migrateObject2_0 = [[SQLiteManagerMigrateObject alloc] init];
        NSArray *configuration = @[
                                   @{
                                       @"itemName":@"image",
                                       @"imageUrl":@"http://www.icosky.com/icon/png/System/Candied%20Apples/Candy%20Apple%20Red%202.png",
                                       @"contentMode":@"fit",
                                       @"position":@[
                                               @{@"locateItem":@"leftInContainer", @"value":@"10", @"shouldResize":@(1)},
                                               @{@"locateItem":@"topInContainer", @"value":@"10", @"shouldResize":@(1)},
                                               @{@"locateItem":@"bottomInContainer", @"value":@"10", @"shouldResize":@(1)},
                                               @{@"locateItem":@"rightInContainer", @"value":@"10", @"shouldResize":@(1)}
                                               ]
                                       },
                                   @{
                                       @"itemName":@"label",
                                       @"text":@"i am label",
                                       @"textColor":@"#123456",
                                       @"fontSize":@"12",
                                       @"fontName":@"default",
                                       @"textAlignment":@"left",
                                       @"position":@[
                                               @{@"locateItem":@"leftInContainer", @"value":@"10", @"shouldResize":@(0)},
                                               @{@"locateItem":@"topInContainer", @"value":@"110", @"shouldResize":@(0)}
                                               ]
                                       },
                                   @{
                                       @"itemName":@"textfield",
                                       @"text":@"i am textfield",
                                       @"textColor":@"#123456",
                                       @"fontSize":@"12",
                                       @"fontName":@"default",
                                       @"textAlignment":@"center",
                                       @"lengthLimit":@"10",
                                       @"position":@[
                                               @{@"locateItem":@"leftInContainer", @"Left":@"10", @"shouldResize":@(0)},
                                               @{@"locateItem":@"topInContainer", @"Top":@"220", @"shouldResize":@(0)}
                                               ]
                                       }
                                   ];
        NSString *jsonString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:configuration options:0 error:NULL] encoding:NSUTF8StringEncoding];
        migrateObject2_0.upSql = [NSString stringWithFormat:@"INSERT INTO AssortTips (content) VALUES ('%@');", jsonString];
        migrateObject2_0.downSql = @"";
        
        _migrateList = @{
            @"1.0":initMigrateObject,
            @"2.0":migrateObject2_0,
        };
    }
    return _migrateList;
}

- (NSArray *)versionList
{
    if (_versionList == nil) {
        _versionList = @[kSQLiteVersionDefaultVersion, @"1.0", @"2.0"];
    }
    return _versionList;
}

@end
