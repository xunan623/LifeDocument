//
//  XNHomeViewController.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNHomeViewController.h"
#import "XNHotPlayViewController.h"
#import "XNRecentViewController.h"

@interface XNHomeViewController()
/** 最近更新 */
@property (nonatomic, strong) XNRecentViewController *recentVC;
/** 热播 */
@property (nonatomic, strong) XNHotPlayViewController *hotVC;

@end

@implementation XNHomeViewController
#pragma mark 懒加载
- (XNRecentViewController *)recentVC
{
    if (!_recentVC) {
        self.recentVC = [[XNRecentViewController alloc] init];
    }
    return _recentVC;
}
- (XNHotPlayViewController *)hotVC
{
    if (!_hotVC) {
        self.hotVC = [[XNHotPlayViewController alloc] init];
    }
    return _hotVC;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 设置子控件
    [self setupChildVC];
}
/**
 *  设置导航
 */
- (void)setupNav
{

    self.navigationController.navigationBar.barTintColor = XNNavBackgroundColor;
}
/**
 *  设置子控件
 */
- (void)setupChildVC
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
    NSArray *array = [[NSArray alloc] initWithObjects:@"最近更新",@"热播排行", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:array];
    segment.frame = CGRectMake(0, 4, 160, 32);
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    segment.tintColor = [UIColor whiteColor];
    
    [titleView addSubview:segment];
    self.navigationItem.titleView = titleView;
    
    // 添加子控件
    [self addChildViewController:self.recentVC];
    [self addChildViewController:self.hotVC];
    
    // 默认添加正在播放影片
    [self.view addSubview:self.recentVC.view];
}

/**
 *  点击segment
 */
- (void)segmentClick:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:
            [self.view addSubview:self.recentVC.view];
            break;
        case 1:
            [self.view addSubview:self.hotVC.view];
            break;
        default:
            break;
    }
}


@end
