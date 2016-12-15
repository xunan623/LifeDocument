//
//  XNHotPlayViewController.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNHotPlayViewController.h"
#import "XNHotPlayCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "XNHomeDetailViewController.h"

@interface XNHotPlayViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger page;

@end

@implementation XNHotPlayViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setupNav
    [self setupNav];
    
    // 创建CollectionView
    [self setupCollection];
    
    // 刷新数据
    [self refreshData];
}
/**
 *  上拉加载
 */
- (void)loadMoreDatas
{
    ++ self.page;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"cat"] = @"home";
    param[@"page"] = @(self.page);
    param[@"ap"] = @"jlp";
    param[@"ver"] = @(1.7);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:AppRequestURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 结束刷新
        [self.collectionView.mj_footer endRefreshing];
        NSArray *dataArr = (NSArray *)responseObject;
        
        [self.dataArray addObjectsFromArray:dataArr];
        
        // 刷新数据
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self.collectionView.mj_footer endRefreshing];
        NSLog(@"%@",error);
    }];
    
}

/**
 *  刷新数据
 */
- (void)refreshData
{
    self.page = 1;

    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setupDatas)];
    
    // 马上进入刷新状态
    [self.collectionView.mj_header beginRefreshing];
    
    // 下拉加载
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
    [self.collectionView.mj_footer beginRefreshing];
    
}

- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
}


/**
 *  请求网络数据
 */
- (void)setupDatas
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"cat"] = @"home";
    param[@"type"] = @"random";
    param[@"page"] = @(1);
    param[@"ap"] = @"jlp";
    param[@"ver"] = @(1.7);
    [[XNNetwork sharedInstance] requestWithPath:@"" params:param class:nil successBlock:^(id x) {
        // 结束刷新
        [self.collectionView.mj_header endRefreshing];
        [self.dataArray removeAllObjects];
        NSArray *dataArr = (NSArray *)x;
        [self.dataArray addObjectsFromArray:dataArr];
        
        // 刷新数据
        [self.collectionView reloadData];
    } failedBlock:^(NSError *error) {
        // 结束刷新
        [self.collectionView.mj_header endRefreshing];
        NSLog(@"%@",error);
    }];
    
}


/**
 *  创建CollectionView
 */
- (void)setupCollection
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, Width, Height - 64 -49) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = rgb(250, 250, 250);
    [self.view addSubview:collectionView];
    
    
    // 注册cell和ReusableView（相当于头部）
    [collectionView registerClass:[XNHotPlayCell class] forCellWithReuseIdentifier:@"XNHotPlayCell"];
    
    self.collectionView = collectionView;
}

#pragma mark collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XNHotPlayCell *cell = [XNHotPlayCell cellWithCollectionView:collectionView NSIndexPath:indexPath];
    cell.model = [XNRecentMovieModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((Width- 20)/2  , (Width - 20)/2);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
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





















@end
