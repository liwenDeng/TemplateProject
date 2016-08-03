//
//  DYBigDataList.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/3.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYBigDataList.h"

@implementation DYBigDataList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data": [DYRoomModel class]};
}

@end
