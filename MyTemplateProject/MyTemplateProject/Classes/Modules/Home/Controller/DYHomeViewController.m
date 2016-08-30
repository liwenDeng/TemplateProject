//
//  DYHomeViewController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYHomeViewController.h"
#import <MJRefresh.h>
#import "DYBigDataList.h"
#import "DYFaceRoomModel.h"
#import "DYHotCateList.h"
#import "DYLiveRoomViewController.h"
#import "DYRoomCell.h"
#import "DYFaceRoomCell.h"
#import "DYSectionHeaderView.h"
#import "MSBaseTabBarController.h"
#import "DYDetailLiveViewController.h"
#import "DYBannerList.h"
#import "DYHomeHeaderBannerView.h"

#define kSlideBannerId @"DYSlideBannerView" //轮播图
#define kCellId @"DYRoomCell"
#define kFaceCellId @"DYFaceRoomCell"
#define kSectionId @"DYSectionHeaderView"

/**
 *  斗鱼首页-推荐栏目下VC
 */
@interface DYHomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DYSectionHeaderViewDelegate>

@property (nonatomic, strong) UICollectionView *rommCollectionView;

@property (nonatomic, strong) NSMutableArray *bigDataList;  //最热
@property (nonatomic, strong) NSMutableArray *faceList;    //颜值
@property (nonatomic, strong) NSMutableArray *hotCateList; //分类
@property (nonatomic, strong) NSMutableArray *sectionList;

@property (nonatomic, strong) NSMutableArray *bannerList;   //轮播图

@end

@implementation DYHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubviews];
    [self requestData];
}

- (void)setupSubviews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.rommCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    [self.view addSubview:_rommCollectionView];
    self.rommCollectionView.backgroundColor = [UIColor colorWithRed:243 green:241 blue:244 alpha:1];
    self.rommCollectionView.delegate = self;
    self.rommCollectionView.dataSource = self;
    self.rommCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self.rommCollectionView registerClass:[DYRoomCell class] forCellWithReuseIdentifier:kCellId];
    [self.rommCollectionView registerClass:[DYFaceRoomCell class] forCellWithReuseIdentifier:kFaceCellId];
    
    [self.rommCollectionView registerClass:[DYHomeHeaderBannerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSlideBannerId];
    [self.rommCollectionView registerClass:[DYSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionId];

    //refresh header
    self.rommCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    
    self.bigDataList = [NSMutableArray array];
    self.faceList = [NSMutableArray array];
    self.hotCateList = [NSMutableArray array];
    self.sectionList = [NSMutableArray array];
    self.bannerList = [NSMutableArray array];
    
}

- (void)requestData {
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    //获取最热
    [MSNetworking getDouyuBigDataInfos:^(NSDictionary *object) {
        DYBigDataList *list = [DYBigDataList yy_modelWithDictionary:object];
        if (list.error) return ;
        NSLog(@"1.获取最热成功");
        self.bigDataList = [NSMutableArray arrayWithArray:list.data];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    //获取颜值
    [MSNetworking getDouyuFaceInfos:^(NSDictionary *object) {
        DYFaceList *list = [DYFaceList yy_modelWithDictionary:object];
        if (list.error) return ;
        NSLog(@"2.获取颜值成功");
        self.faceList = [NSMutableArray arrayWithArray:list.data];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    //获取热门分类
    [MSNetworking getDouyuHotCateListInfos:^(NSDictionary *object) {
        DYHotCateList *list = [DYHotCateList yy_modelWithDictionary:object];
        if (list.error) return ;
        NSLog(@"3.获取热门成功");
        NSMutableArray *hotListDics = [NSMutableArray arrayWithArray:list.data];
        NSMutableArray *hotCateLists = [NSMutableArray array];
        for (NSDictionary *dic in hotListDics) {
            DYHotCate *hotCate = [DYHotCate yy_modelWithDictionary:dic];
            [hotCateLists addObject:hotCate];
        }
        self.hotCateList = [NSMutableArray arrayWithArray:hotCateLists];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    //获取轮播图
    [MSNetworking getDouyuSlideBanners:^(NSDictionary *object) {
        DYBannerList *list = [DYBannerList yy_modelWithDictionary:object];
        if (list.error) return ;
        NSLog(@"4.获取轮播图成功");
        dispatch_group_leave(group);
        self.bannerList = [NSMutableArray arrayWithArray:list.data];
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //所有数据请求完成;
        if (self.bigDataList.count > 0) [_sectionList addObject:self.bigDataList];
        if (self.faceList.count > 0) [_sectionList addObject:self.faceList];
        if (self.hotCateList.count > 0) [_sectionList addObjectsFromArray:self.hotCateList];
        [self.rommCollectionView.mj_header endRefreshing];
        [self.rommCollectionView reloadData];
    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionList.count + 1; //加轮播图
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    
    if (self.sectionList.count > section - 1) {
        NSObject *roomList = self.sectionList[section - 1];
        if ([roomList isKindOfClass:[NSArray class]]) {
            return ((NSArray *)roomList).count;
        }
        else if ([roomList isMemberOfClass:[DYHotCate class]]) {
            return ((DYHotCate *)roomList).room_list.count;
        }
        else
            return 0;
    }else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYRoomModel *roomModel = [self getRoomModelAtIndexPath:indexPath];;
    DYBaseRoomCell *cell = nil;
    if ([roomModel.game_name isEqualToString:@"颜值"]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFaceCellId forIndexPath:indexPath];
    }
    else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    }
    
    [cell fillWithRoomModel:roomModel adIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        DYHomeHeaderBannerView *bannerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSlideBannerId forIndexPath:indexPath];
        [bannerView fillWithBannerModels:self.bannerList];
        return bannerView;
    }else {
        DYSectionHeaderView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionId forIndexPath:indexPath];
        if (!sectionView) {
            sectionView = [[DYSectionHeaderView alloc]init];
        }
        sectionView.delegate = self;
        DYRoomModel *roomModel = [self getRoomModelAtIndexPath:indexPath];
        if (indexPath.section == 1) {
            [sectionView fillWithTagName:@"最热" atIndexPath:indexPath];
        }else {
            [sectionView fillWithTagName:roomModel.game_name atIndexPath:indexPath];
        }
        return sectionView;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DYRoomModel *roomModel = [self getRoomModelAtIndexPath:indexPath];
    DYLiveRoomViewController *liveVC = [[DYLiveRoomViewController alloc]init];
    liveVC.roomModel = roomModel;
    liveVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:liveVC animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return section == 0 ? [DYHomeHeaderBannerView sectionHeaderViewSize] : [DYSectionHeaderView sectionHeaderViewSize];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYRoomModel *roomModel = [self getRoomModelAtIndexPath:indexPath];
    if ([roomModel.game_name isEqualToString:@"颜值"] && indexPath.section == 2 ) {
        return [DYFaceRoomCell cellSize];
    }
    else {
        return [DYRoomCell cellSize];
    }
}

#pragma mark - DYSectionHeaderViewDelegate
- (void)dySectionHeaderView:(DYSectionHeaderView *)sectionHeaderView clickedMoreButtonAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"more...");
    if (indexPath.section == 0) {
        //跳转到直播
        MSBaseTabBarController *tabController = (MSBaseTabBarController *)[self cyl_tabBarController];
        tabController.selectedIndex = 1;
    }else {
        //跳转到分类
        DYRoomModel *rooModel = [self getRoomModelAtIndexPath:indexPath];
        DYDetailLiveViewController *detailVC = [[DYDetailLiveViewController alloc]init];
        detailVC.title = rooModel.game_name;
        detailVC.cateId = [rooModel.cate_id integerValue];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - Util
- (DYRoomModel *)getRoomModelAtIndexPath:(NSIndexPath *)indexPath {
    DYRoomModel *roomModel = nil;
    NSObject *roomList = self.sectionList[indexPath.section - 1];
    if ([roomList isKindOfClass:[NSArray class]]) {
        roomModel = [((NSArray *)roomList) objectAtIndex:indexPath.row];
    }
    else if ([roomList isMemberOfClass:[DYHotCate class]]) {
        roomModel = [((DYHotCate *)roomList).room_list objectAtIndex:indexPath.row];
    }
    else {
        roomModel = [[DYRoomModel alloc]init];
    }
    return roomModel;
}

#pragma mark - 旋转控制
- (BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
