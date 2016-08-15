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
  获取斗鱼当前全部直播
 */
+ (NSURLSessionDataTask *)getAllDouyuLive:(NSInteger)limit offset:(NSInteger)offset WithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 获取斗鱼分类列表
 */
+ (NSURLSessionDataTask *)getDouyuColumnList:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 获取斗鱼顶部tabbar分类
 */
+ (NSURLSessionDataTask *)getDouyuTopBarInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

//================================================================================
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
 *  4.获取斗鱼房间详细信息
 */
+ (NSURLSessionDataTask *)getDouyuRoomLiveInfo:(NSString *)roomId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;
@end

