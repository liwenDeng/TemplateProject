//
//  DYRoomModelList.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYBaseModel.h"
#import "DYRoomModel.h"

/**
 *  热门分类房间
 */
@interface DYHotCate : NSObject

/**
 *  房间列表，里面装的是 DYRommModel类型
 */
@property (nonatomic, strong) NSArray *room_list;

@property (nonatomic, copy) NSString *tag_name;
@property (nonatomic, assign) NSInteger tag_id;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *push_vertical_screen;

@end

// data数组 中装的是 DYHotCate 类型
@interface DYHotCateList : DYBaseModel


@end