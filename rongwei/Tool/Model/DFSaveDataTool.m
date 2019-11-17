//
//  DFSaveDataTool.m
//  rongwei
//
//  Created by zhangfuyu on 2019/11/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFSaveDataTool.h"
static NSString *GHSaveDataType_ProvinceCityAreaPath = @"GHSaveDataType_ProvinceCityAreaPath";
static NSString *GHSaveDataType_AllCity = @"GHSaveDataType_AllCity";



@implementation DFSaveDataTool

+ (instancetype)shareInstance {
    
    static DFSaveDataTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[DFSaveDataTool alloc] init];
    });
    return _tool;
    
}

- (NSArray *)loadProvinceCityAreaData {
    
//    if ([self getCityCacheTimeIsShouldCleanCache]) {
//        [self cleanAllCityData];
//    }
    
    NSString *path = [self getSaveCacheDataPathWithFileName:GHSaveDataType_ProvinceCityAreaPath];
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return array;
    
}

- (NSString *)getSaveCacheDataPathWithFileName:(NSString *)fileName {
    
    //1.获取文件路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [docPath stringByAppendingPathComponent:ISNIL(fileName)];
    
}

- (void)saveCountryDataWithData:(NSDictionary *)data;
{
    
    NSString *path = [self getSaveCacheDataPathWithFileName:GHSaveDataType_AllCity];
    
    [NSKeyedArchiver archiveRootObject:data toFile:path];
    
}
- (NSDictionary *)getCountryData
{
    NSString *path = [self getSaveCacheDataPathWithFileName:GHSaveDataType_AllCity];
    
    NSDictionary *dataDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return dataDic;
}

@end
