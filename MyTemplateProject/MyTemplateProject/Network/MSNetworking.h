//
//  MSNetworking.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/6/28.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCApiLauncher.h"

typedef void(^MSSuccessBlock)(id object);
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

@end

