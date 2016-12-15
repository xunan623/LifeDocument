//
//  XNClearCache.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/15.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNClearCache.h"

@implementation XNClearCache
/**
 *  计算缓存的大小
 *
 *  @param folderPath 缓存文件路径
 *
 */
+ (CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString *fileName = nil;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
/**
 *  计算文件的大小
 */
+ (CGFloat)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }else{
        NSLog(@"路径错误，未找到该文件");
    }
    return 0;
    
}
/**
 *  清除缓存
 */
+ (void)clearCacheWithPath:(NSString *)filePath
{
    NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fM", [self folderSizeAtPath:filePath]];
    NSLog(@"%@",str);
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:filePath];
    for (NSString *p in files)
    {
        NSError *error;
        NSString *Path = [filePath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:Path])
        {
            [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
        }
    }
}
@end
