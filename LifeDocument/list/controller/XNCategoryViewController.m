//
//  XNCategoryViewController.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNCategoryViewController.h"
#import "XNCategoryCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "XNRecentViewController.h"

@interface XNCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation XNCategoryViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航
    [self setupNav];
    
    // 创建表格
    [self setupTableView];
    
    // 加载数据
    [self setupData];
}

/**
 *  加载数据
 */
- (void)setupData
{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"cat"] = @"cat";
    param[@"page"] = @(1);
    param[@"ap"] = @"jlp";
    param[@"ver"] = @(1.7);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:AppRequestURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.dataArray removeAllObjects];
        NSArray *dataArr = (NSArray *)responseObject;
        [self.dataArray addObjectsFromArray:dataArr];
        
        // 刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    }];
        
    

}
/**
 *  创建表格
 */
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Scroll_Width, Scroll_Height - 49) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

/**
 *  设置导航
 */
- (void)setupNav
{
    self.navigationController.navigationBar.barTintColor = XNNavBackgroundColor;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.text = @"分类";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
}
#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XNCategoryCell *cell = [XNCategoryCell cellWithTableView:tableView];
    cell.model = [XNRecentMovieModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XNRecentMovieModel *model = [XNRecentMovieModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    XNRecentViewController *recentVC = [[XNRecentViewController alloc] init];
    recentVC.hidesBottomBarWhenPushed = YES;
    recentVC.recentModel = model;
    recentVC.isFromCate = YES;
    [self.navigationController pushViewController:recentVC animated:YES];
}

@end
