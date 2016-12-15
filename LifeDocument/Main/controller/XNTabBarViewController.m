//
//  XNTabBarViewController.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNTabBarViewController.h"
#import "XNHomeViewController.h"
#import "XNMoreViewConroller.h"
#import "XNCategoryViewController.h"

@implementation XNTabBarViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    XNHomeViewController *home = [[XNHomeViewController alloc] init];
    [self addClildVCWithTitle:@"" viewController:home image:@"TabBarIcon_DD" selectImage:@"TabBarIcon_DD_Highlight"];
    XNCategoryViewController *cate = [[XNCategoryViewController alloc] init];
    [self addClildVCWithTitle:@"" viewController:cate image:@"TabBarIcon_Discover" selectImage:@"TabBarIcon_Discover_Highlight"];
    XNMoreViewConroller *more = [[XNMoreViewConroller alloc] init];
    [self addClildVCWithTitle:@"" viewController:more image:@"TabBarIcon_User" selectImage:@"TabBarIcon_User_Highlight"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param title       控制器标题
 *  @param chlidVc     子控制器
 *  @param image       图片
 *  @param selectImage 选中的图片
 */
- (void)addClildVCWithTitle:(NSString *)title
             viewController:(UIViewController *)chlidVc
                      image:(NSString *)image
                selectImage:(NSString *)selectImage {
    chlidVc.title = nil;
    self.tabBar.backgroundImage = [UIImage imageNamed:@"TabBarBackground"];
    
    chlidVc.tabBarItem.image = [UIImage imageNamed:image];
    chlidVc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    chlidVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]
                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //给传进来的控制器添加导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chlidVc];
    //添加为子控制器
    [self addChildViewController:nav];
}

@end
