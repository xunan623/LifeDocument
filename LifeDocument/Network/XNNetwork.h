//
//  XNNetwork.h
//  LifeDocument
//
//  Created by xunan on 2016/12/15.
//  Copyright © 2016年 camelot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void (^ReqeustSuccess) (id x);
typedef void (^RequestFailed) (NSError *error);

@interface XNNetwork : NSObject

- (AFHTTPSessionManager *)requestWithPath:(NSString *)path
                                   params:(NSDictionary *)params
                                    class:(Class)aClass
                             successBlock:(ReqeustSuccess)success
                              failedBlock:(RequestFailed)failed;

+ (instancetype)sharedInstance;

@end
