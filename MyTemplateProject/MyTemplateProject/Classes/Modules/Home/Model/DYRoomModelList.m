//
//  DYRoomModelList.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYRoomModelList.h"

@implementation DYRoomModelList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"room_list" : [DYRoomModel class]};
}

@end
