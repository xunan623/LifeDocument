//
//  XNShareView.h
//  LifeDocument
//
//  Created by 许楠 on 15/12/15.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <UIKit/UIKit.h>

#define viewHeight 260

typedef enum {
    XNLoginTypeWeixin,
    XNLoginTypeWeiBo,
    XNShareTypeWeixin,
    XNShareTypeWeibo
}XNShareType;

@protocol XNShareViewDelegate <NSObject>

- (void)sendClickWith:(XNShareType)shareType;

@end

@interface XNShareView : UIView

@property (nonatomic, assign) id<XNShareViewDelegate> delegate;

+(instancetype)share;

- (void)show;

- (void)dismiss;


+(instancetype)shareURLWithtitle:(NSString *)title weixinName:(NSString *)weixin weiboName:(NSString *)weibo;

@end
