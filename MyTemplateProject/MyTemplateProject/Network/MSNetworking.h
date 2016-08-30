//
//  MSNetworking.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/6/28.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCApiLauncher.h"

typedef void(^MSSuccessBlock)(NSDictionary *object);
typedef void(^MSFailureBlock)(NSError *error);

@interface MSNetworking : NSObject

//(MSSuccessBlock)success failure:(MSFailureBlock)failure;
+ (NSURLSessionDataTask *)requestSomethingWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

#pragma mark - 斗鱼API
/**
 获取斗鱼分类列表
 */
+ (NSURLSessionDataTask *)getDouyuColumnList:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 获取斗鱼顶部tabbar分类
 */
+ (NSURLSessionDataTask *)getDouyuTopBarInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

//================================================================================
#pragma mark - 首页请求
/**
 1.获取斗鱼首页最热数据
 * 返回是DYRoomModel 数组
 */
+ (NSURLSessionDataTask *)getDouyuBigDataInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 2.获取斗鱼首页颜值数据
 */
+ (NSURLSessionDataTask *)getDouyuFaceInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 3.获取斗鱼首页热门分类房间列表数据 getHotCate
 */
+ (NSURLSessionDataTask *)getDouyuHotCateListInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  4.获取分类直播列表
 *  @param cateId  分类id
 */
+ (NSURLSessionDataTask *)getDouyuLiveCateId:(NSInteger)cateId limit:(NSInteger)limit offset:(NSInteger)offset WithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  5.获取颜值类播放列表
 */
+ (NSURLSessionDataTask *)getFaceRoomListLimit:(NSInteger)limit offset:(NSInteger)offset WithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  6.获取首页轮播图
 */
+ (NSURLSessionDataTask *)getDouyuSlideBanners:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

#pragma mark - 房间信息
/**
 *  4.获取斗鱼房间详细信息
 */
+ (NSURLSessionDataTask *)getDouyuRoomLiveInfo:(NSString *)roomId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

#pragma mark - 所有直播
/**
 获取斗鱼当前全部直播
 */
+ (NSURLSessionDataTask *)getAllDouyuLiveLimit:(NSInteger)limit offset:(NSInteger)offset WithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

#pragma mark - 我的-登陆
/**
 *  DY登陆
 */
+ (NSURLSessionDataTask *)loginDYUserName:(NSString *)userName password:(NSString*)password success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

#pragma mark - WatchHistory 
/**
 *  获取观看历史
 */
+ (NSURLSessionDataTask *)getDYWatchHistroy:(NSArray *)roomIds success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;


@end

