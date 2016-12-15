//
//  XNRecentViewController.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNRecentViewController.h"
#import <AFNetworking.h>

#import <MJExtension.h>
#import "XNRentPlayCell.h"
#import <MJRefresh.h>
#import "XNHomeDetailViewController.h"

@interface XNRecentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@end

@implementation XNRecentViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航
    [self setupNav];
    
    // 创建表格
    [self setupTableView];
    
    // 刷新数据
    [self refreshData];
}

- (void)setupNav
{
    if (self.isFromCate) {
        self.title = self.recentModel.name;
    }
}

/**
 *  刷新
 */
- (void)refreshData
{
    self.page = 1;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setupData)];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    // 下拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_footer beginRefreshing];

}

/**
 *  请求网络数据
 */
- (void)setupData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    if (self.isFromCate) {
        param[@"cat"] = @(self.recentModel.id);
    } else {
        param[@"cat"] = @"home";
    }
    
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
 *  上拉加载
 */
- (void)loadMoreData
{
    ++ self.page;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (self.isFromCate) {
        param[@"cat"] = @(self.recentModel.id);
    } else {
        param[@"cat"] = @"home";
    }
    param[@"page"] = @(self.page);
    param[@"ap"] = @"jlp";
    param[@"ver"] = @(1.7);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:AppRequestURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        NSArray *dataArr = (NSArray *)responseObject;
        
        [self.dataArray addObjectsFromArray:dataArr];
        
        // 刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"%@",error);
    }];

}

/**
 *  创建表格
 */
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XNRentPlayCell *cell = [XNRentPlayCell cellWithTableView:tableView];
    cell.model = [XNRecentMovieModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XNRecentMovieModel *model = [XNRecentMovieModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    XNHomeDetailViewController *detailVC = [[XNHomeDetailViewController alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.model = model;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
