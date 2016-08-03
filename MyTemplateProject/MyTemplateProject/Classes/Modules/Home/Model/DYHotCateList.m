//
//  DYRoomModelList.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYHotCateList.h"

@implementation DYHotCate

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"room_list" : [DYRoomModel class]};
}

@end

@implementation DYHotCateList

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"data": [NSArray class]};
//}

@end