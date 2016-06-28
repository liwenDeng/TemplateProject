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

+ (NSURLSessionDataTask *)requestSomethingWithSuccess:(MSFailureBlock)success failure:(MSFailureBlock)failure;

@end

