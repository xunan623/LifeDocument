//
//  XNUserModel.h
//  LifeDocument
//
//  Created by 许楠 on 15/12/15.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XNUserModel : NSObject
/** string 好友显示名称 */
@property (nonatomic ,copy)NSString *name;
/** string 字符串类型的用户UID */
@property (nonatomic ,copy)NSString *idstr;
/** 用户头像地址 50*50像素 */
@property (nonatomic ,copy)NSString *profile_image_url;
/** 用户头像 */
@property (nonatomic ,copy)NSString *avatar_hd;
/** 会员类型 值 > 2 才代表会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
/** 是否是会员 */
@property (nonatomic, assign, getter=isVip) BOOL vip;

@end
