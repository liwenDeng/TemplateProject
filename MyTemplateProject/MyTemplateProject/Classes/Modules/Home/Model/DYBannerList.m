//
//  DYBannerList.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/30.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYBannerList.h"

@implementation DYBannerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"roomId" : @"id"};
}

@end

@implementation DYBannerList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data": [DYBannerModel class]};
}

@end
