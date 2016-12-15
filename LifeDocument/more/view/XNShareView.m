//
//  XNShareView.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/15.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNShareView.h"

@interface XNShareView()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *weixinBtn;
@property (nonatomic, weak) UIButton *weiboBtn;
@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic, weak) UIView *alertView;

@end

@implementation XNShareView

// 登录
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupButton];
        
        [self setupView:@"您可以通过以下方式登录" weixin:@"微信登录" weibo:@"微博"];
    }
    return self;
}
// 分享
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title weixinName:(NSString *)weixin weiboName:(NSString *)weibo
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton];
        
        [self setupView:(NSString *)title weixin:(NSString *)weixin weibo:(NSString *)weibo];
    }
    return self;
}

/**
 *  白色背景
 */
- (void)setupButton
{
    UIButton *alertView = [[UIButton alloc] initWithFrame:CGRectMake(0, Height - viewHeight, self.width, viewHeight)];
    alertView.backgroundColor = [UIColor whiteColor];
    [self addSubview:alertView];
    self.alertView = alertView;
}


- (void)setupView:(NSString *)title weixin:(NSString *)weixin weibo:(NSString *)weibo
{
    // 您可以通过以下方式登录
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 60)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = rgb(82, 83, 90);
    [self.alertView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    // 微信
    UIButton *weixinBtn = [[UIButton alloc] init];
    weixinBtn.frame = CGRectMake(self.width/2 -120, titleLabel.height, 100, 100);
    [weixinBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    [weixinBtn setTitle:weixin forState:UIControlStateNormal];
    [weixinBtn setTitleColor:rgb(142, 141, 146) forState:UIControlStateNormal];
    [weixinBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([title isEqualToString:@"您可以通过以下方式登录"]) {
        weixinBtn.tag = XNLoginTypeWeixin;
    } else {
        weixinBtn.tag = XNShareTypeWeixin;

    }
    [weixinBtn setTitleEdgeInsets:UIEdgeInsetsMake(120, -100, 0, 0)];
    weixinBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.alertView addSubview:weixinBtn];
    self.weixinBtn = weixinBtn;
    
    
    // 微博
    UIButton *weiboBtn = [[UIButton alloc] init];
    weiboBtn.frame = CGRectMake(self.width/2 + 40, titleLabel.height, 100, 100);
    [weiboBtn setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
    [weiboBtn setTitle:weibo forState:UIControlStateNormal];
    [weiboBtn setTitleColor:rgb(142, 141, 146) forState:UIControlStateNormal];
    [weiboBtn setTitleEdgeInsets:UIEdgeInsetsMake(120, -100, 0, 0)];
    weiboBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [weiboBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([title isEqualToString:@"您可以通过以下方式登录"]) {
        weiboBtn.tag = XNLoginTypeWeiBo;
    } else {
        weiboBtn.tag = XNShareTypeWeibo;
        
    }
    [self.alertView addSubview:weiboBtn];
    self.weiboBtn = weiboBtn;
    
    // 取消按钮
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(10,self.weiboBtn.height + self.weiboBtn.y + 35, Width - 20, 44);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:rgb(142, 141, 146) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    cancelBtn.backgroundColor = rgb(234, 234, 234);
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius =6;
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:cancelBtn];
    self.cancelBtn = cancelBtn;
}



#pragma mark 点击事件
- (void)btnClick:(UIButton *)btn
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.backgroundColor = [UIColor clearColor];
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(sendClickWith:)]) {
        [self.delegate sendClickWith:(XNShareType)btn.tag];
    }
    
}

/**
 *  显示
 */
- (void)show
{
    self.frame = CGRectMake(0, Height, Width, 0.5);
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, Height - 260, Width, 260);
    } completion:^(BOOL finished) {
        
    }];
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.backgroundColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.5];

    [window addSubview:self];
    self.frame = window.bounds;

}
/**
 *  销毁
 */
- (void)dismiss
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, Scroll_Height, Scroll_Width, 0.0);
    } completion:^(BOOL finished) {
        window.backgroundColor = [UIColor clearColor];
        [self removeFromSuperview];
    }];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}




/**
 *  初始化
 */
+(instancetype)share
{
    return [[self alloc] initWithFrame:CGRectMake(0, Height - 260, Width, 260) ];
}

+(instancetype)shareURLWithtitle:(NSString *)title weixinName:(NSString *)weixin weiboName:(NSString *)weibo
{
    return [[self alloc] initWithFrame:CGRectMake(0, Height - 260, Width, 260) title:title weixinName:weixin weiboName:weibo];
}

#pragma mark 取消
- (void)cancelBtnClick:(UIButton *)btn
{
    [self dismiss];

}


@end
