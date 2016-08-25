//
//  DYRoomModel.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYRoomModel.h"
#import "DYBaseModel.h"

@implementation DYRoomModel

@end

@implementation DYRoomModelList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data": [DYRoomModel class]};
}

@end