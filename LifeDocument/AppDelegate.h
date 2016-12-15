//
//  AppDelegate.h
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNMoreViewConroller.h"
#import <WeiboSDK.h>
#import <WXApi.h>
#import <ShareSDK/ShareSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) XNMoreViewConroller *viewController;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@end

