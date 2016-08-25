//
//  DYAllLiveViewController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/25.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYAllLiveViewController.h"
#import "MSLiveCollectionView.h"
#import "DYLiveRoomViewController.h"
#import <MJRefresh.h>
#import "DYRoomCell.h"
#import "DYFaceRoomModel.h"

static NSString * const kRoomCellID = @"RoomCell";
static const NSInteger kPerloadCount = 20; //一次加载20

@interface DYAllLiveViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) MSLiveCollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger loadCount; //上拉次数

@end

@implementation DYAllLiveViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    self.collectionView = [MSLiveCollectionView msCommonCollectionView:self.view.frame];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[DYRoomCell class] forCellWithReuseIdentifier:kRoomCellID];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.listArray = [NSMutableArray array];
    self.loadCount = 1;
    
    [self refreshData];
}

- (void)refreshData {
    [MSNetworking getAllDouyuLiveLimit:kPerloadCount offset:0 WithSuccess:^(NSDictionary *object) {
        DYFaceList *list = [DYFaceList yy_modelWithDictionary:object];
        if (list.error) return ;
        self.listArray = [NSMutableArray arrayWithArray:list.data];
        [self.collectionView.mj_header endRefreshing];
        self.loadCount = 1;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        self.loadCount = 1;
    }];
}

- (void)loadMore{
    [MSNetworking getAllDouyuLiveLimit:kPerloadCount offset:(self.loadCount*kPerloadCount) WithSuccess:^(NSDictionary *object) {
        DYFaceList *list = [DYFaceList yy_modelWithDictionary:object];
        if (list.error) return ;
        [self.listArray addObjectsFromArray:list.data];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
        self.loadCount++;
    } failure:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYRoomModel *roomModel = self.listArray[indexPath.row];
    DYRoomCell *cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRoomCellID forIndexPath:indexPath];
    [cell fillWithRoomModel:roomModel adIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DYRoomModel *roomModel = self.listArray[indexPath.row];
    DYLiveRoomViewController *liveVC = [[DYLiveRoomViewController alloc]init];
    liveVC.roomModel = roomModel;
    liveVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:liveVC animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [DYRoomCell cellSize];
}

@end
