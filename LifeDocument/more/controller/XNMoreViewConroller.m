//
//  XNMoreViewConroller.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNMoreViewConroller.h"
#import "XNMoreCell.h"
#import "XNClearCache.h"
#import <UMFeedback.h>
#import "XNShareView.h"
#import <WeiboSDK.h>
#import <AFNetworking.h>
#import "HWAccountTool.h"
#import "HWAccount.h"
#import <MJExtension.h>
#import "XNUserModel.h"
#import "XNMorePersonCell.h"
#import <WXApi.h>
#import "AppDelegate.h"
#import "WXApiRequestHandler.h"



@interface XNMoreViewConroller()<UITableViewDataSource,UITableViewDelegate,XNShareViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *cacheNumber;
@end

@implementation XNMoreViewConroller
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航
    [self setupNav];
    
    // 创建表格
    [self setupTableView];
    
}

/**
 *  创建表格
 */
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

/**
 *  设置导航
 */
- (void)setupNav
{
    self.navigationController.navigationBar.barTintColor = XNNavBackgroundColor;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
}

#pragma mark tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==1) { // 第二组
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) { // 第一组数据
        XNMorePersonCell *cell = [XNMorePersonCell cellWithTableView:tableView];
        cell.iconView.image = [UIImage imageNamed:@"goin"];

        return cell;
    }
    
    
    static NSString *cellName = @"more";
    XNMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[XNMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;

    if (indexPath.section == 1) { // 第二组数据
        cell.iconView.image = [UIImage imageNamed:@"goin"];

        if (indexPath.row ==0) { // 意见反馈
            cell.textLabel.text = @"意见反馈";
        }
        else if (indexPath.row == 1) { // 清除缓存
            cell.textLabel.text = @"分享";

        }
        else if (indexPath.row == 2) { // 清除缓存
            cell.textLabel.text = @"清除缓存";
            [self showCacheFile];
            cell.detailLabel.text = self.cacheNumber;
        }
        else if (indexPath.row == 3) { // 打分鼓励
            cell.textLabel.text = @"打分鼓励";
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) { // 第一组
        return 80;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) { // 第二组
        if (indexPath.row == 0) { // 用户反馈
            UIViewController *feedback = [UMFeedback feedbackViewController] ;
            feedback.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:feedback animated:YES];
        }
        else if (indexPath.row == 1) { // 分享
            [self setupShare];
        }
        else if (indexPath.row == 2) { // 清空缓存
            [self clearCaches];
        }
    }
    else if (indexPath.section == 0) { // 第一组
        if (indexPath.row == 0) { // 第三方登录
            HWAccount *account = [HWAccountTool account];
            if (account.name == nil) {
                [self setupLogin];
            }
        }
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) { // 第一列
        return 0.1f;
    }
    else { //
        return 0.1f;
    }
}
/**
 *  分享
 */
- (void)setupShare
{
    XNShareView *shareView = [XNShareView shareURLWithtitle:@"您可以通过以下方式分享" weixinName:@"微信分享" weiboName:@"微博分享"];
    shareView.delegate = self;
    [shareView show];
}


/**
 *  登录按钮
 */
- (void)setupLogin
{
    XNShareView *shareView = [XNShareView share];
    shareView.delegate = self;
    [shareView show];
}

#pragma mark 点击了分享按钮
- (void)sendClickWith:(XNShareType)shareType
{
    switch (shareType) {
        case XNLoginTypeWeixin: { // 微信点击
            NSLog(@"微信");
            [self loginWeiXin];
            break;
        }
        case XNLoginTypeWeiBo: { // 微博点击
            NSLog(@"微博");
            [self loginWeibo];
            break;
        }
        case XNShareTypeWeixin: { // 分享微信
            NSLog(@"分享微信");
            [self shareWeiXin];
            break;
        }
        case XNShareTypeWeibo: { // 分享微博
            NSLog(@"分享微博");
            [self shareWeibo];
            break;
        }
        default:
            break;
    }
}
/**
 *  分享微信  链接
 */
- (void)shareWeiXin
{

    
    [WXApiRequestHandler sendLinkURL:@"www.baidu.com"
                             TagName:@"name"
                               Title:@"title"
                         Description:@"hahah"
                          ThumbImage:[UIImage imageNamed:@"action-black-button"]
                             InScene:WXSceneTimeline];
    
}



/**
 *  分享到微博
 */
- (void)shareWeibo
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = KRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}
/**
 *  分享的内容
 */
- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
//    if (self.textSwitch.on)
//    {
//        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
//    }
//    
//    if (self.imageSwitch.on)
//    {
//        WBImageObject *image = [WBImageObject object];
//        image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
//        message.imageObject = image;
//    }
//    
//    if (self.mediaSwitch.on)
//    {
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = NSLocalizedString(@"分享网页标题", nil);
        webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
        webpage.webpageUrl = @"http://sina.cn?a=1";
        message.mediaObject = webpage;
//    }
    
    return message;
}

/**
 *  登录微信
 */
- (void)loginWeiXin
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

/**
 *  登录微博
 */
- (void)loginWeibo
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = KRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"XNMoreViewConroller",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
   
    [XNNotificationCenter addObserver:self selector:@selector(weiboLogined) name:weiboLogin object:nil];
}
/**
 *  获取
 */
- (void)weiboLogined
{
    // 2.拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:@"https://api.weibo.com/2/users/show.json" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 存储账号
        XNUserModel *user = [XNUserModel mj_objectWithKeyValues:responseObject];
        account.name = user.name;
        account.profile_image_url = user.profile_image_url;
        //存储账号信息
        [HWAccountTool saveAccount:account];
        
        // 刷新数据
        [self tableViewReloadSection:0];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        NSLog(@"%@",error);
    }];
    



}

/**
 *  刷新第几组数据
 */
- (void)tableViewReloadSection:(NSInteger)section
{
    NSIndexSet *guessLikeSection = [[NSIndexSet alloc] initWithIndex:section];
    [self.tableView reloadSections:guessLikeSection withRowAnimation:UITableViewRowAnimationAutomatic];
}

/**
 *  清除缓存
 */
- (void)clearCaches
{
    //清除缓存,并重新显示
    dispatch_queue_t queue = dispatch_queue_create("clearCache", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [XNClearCache clearCacheWithPath:CachePath];
        //主线程中刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showCacheFile];
            [self.tableView reloadData];
        });
    });
}

/**
 *  显示缓存信息
 */
- (void)showCacheFile
{
    self.cacheNumber = [NSString stringWithFormat:@"%.1fM",[XNClearCache folderSizeAtPath:CachePath]];
}
















@end
