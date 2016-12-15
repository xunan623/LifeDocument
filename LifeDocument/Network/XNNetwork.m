//
//  XNNetwork.m
//  LifeDocument
//
//  Created by xunan on 2016/12/15.
//  Copyright © 2016年 camelot. All rights reserved.
//

#import "XNNetwork.h"
#import <AFNetworking.h>

@implementation XNNetwork

- (AFHTTPSessionManager *)requestWithPath:(NSString *)path
                                   params:(NSDictionary *)params
                                    class:(Class)aClass
                             successBlock:(ReqeustSuccess)success
                              failedBlock:(RequestFailed)failed {
    NSString *ursString = [AppRequestURL stringByAppendingString:path];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:ursString parameters:params progress:^(NSProgress *downloadProgress) {
    } success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
        if (success) success(responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        if (failed) failed(error);
    }];
    return session;
}

+ (instancetype)sharedInstance {
    static XNNetwork *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[XNNetwork alloc] init];
    });
    return shared;
}


@end
