//
//  XNClearCache.h
//  LifeDocument
//
//  Created by 许楠 on 15/12/15.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XNClearCache : NSObject
/**
 *  计算目录缓存的大小
 */
+ (CGFloat)folderSizeAtPath:(NSString *)folderPath;
/**
 *  计算文件的大小
 */
+ (CGFloat)fileSizeAtPath:(NSString *)filePath;
/**
 *  清除缓存
 */
+ (void)clearCacheWithPath:(NSString *)filePath;
@end
