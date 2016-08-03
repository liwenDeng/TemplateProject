//
//  DYHomeViewController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYHomeViewController.h"

#import "DYBigDataList.h"
#import "DYFaceRoomModel.h"
#import "DYHotCateList.h"

#import "DYRoomCell.h"
#import "DYSectionHeaderView.h"

#define kCellId @"DYRoomCell"
#define kSectionId @"DYSectionHeaderView"

#define kItemWidth (kSCREEN_WIDTH - 20) / 2.0
#define kItemHeight (kItemWidth * 9.0 / 16.0)
/**
 *  斗鱼首页-推荐栏目下VC
 */
@interface DYHomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *rommCollectionView;

@property (nonatomic, strong) NSMutableArray *bigDataList;  //最热
@property (nonatomic, strong) NSMutableArray *faceList;    //颜值
@property (nonatomic, strong) NSMutableArray *hotCateList; //分类

@property (nonatomic, strong) NSMutableArray *sectionList;

@end

@implementation DYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    [self requestData];
}

- (void)setupSubviews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _rommCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    layout.itemSize = CGSizeMake(kItemWidth, kItemHeight);
    [self.view addSubview:_rommCollectionView];
    _rommCollectionView.delegate = self;
    _rommCollectionView.dataSource = self;
    
    [_rommCollectionView registerClass:[DYRoomCell class] forCellWithReuseIdentifier:kCellId];
    [_rommCollectionView registerClass:[DYSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionId];

    
    _bigDataList = [NSMutableArray array];
    _faceList = [NSMutableArray array];
    _hotCateList = [NSMutableArray array];
    _sectionList = [NSMutableArray array];
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
//        DYFaceList *list = [DYFaceList yy_modelWithDictionary:object];
//        if (list.error) return ;
//        NSLog(@"2.获取颜值成功");
//        self.faceList = [NSMutableArray arrayWithArray:list.data];
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
        self.hotCateList = [NSMutableArray arrayWithArray:list.data];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //所有数据请求完成;
        if (self.bigDataList.count > 0) [_sectionList addObject:self.bigDataList];
        if (self.faceList.count > 0) [_sectionList addObject:self.faceList];
        if (self.hotCateList.count > 0) [_sectionList addObjectsFromArray:self.hotCateList];
        [self.rommCollectionView reloadData];
    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = self.sectionList[section];
    return array.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYRoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[DYRoomCell alloc]init];
    }
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionList.count;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    DYSectionHeaderView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionId forIndexPath:indexPath];
    if (!sectionView) {
        sectionView = [[DYSectionHeaderView alloc]init];
    }
    return sectionView;
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kSCREEN_WIDTH, 40);
}

@end
