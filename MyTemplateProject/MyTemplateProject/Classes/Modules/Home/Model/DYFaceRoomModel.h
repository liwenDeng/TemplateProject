//
//  DYFaceRoomModel.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseModel.h"
/**
 *  首页颜值Model
 */
@interface DYFaceRoomModel : MSBaseModel

@property (nonatomic, copy) NSString *room_id;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger online;
@property (nonatomic, copy) NSString *room_name;
@property (nonatomic, copy) NSString *game_name;
@property (nonatomic, copy) NSString *room_src;
@property (nonatomic, copy) NSString *vertical_src;
@property (nonatomic, copy) NSString *owner_uid;
@property (nonatomic, copy) NSString *anchor_city;

@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *vod_quality;
@property (nonatomic, copy) NSString *show_time;
@property (nonatomic, copy) NSString *show_status;
@property (nonatomic, copy) NSString *specific_catalog;
@property (nonatomic, copy) NSString *child_id;
@property (nonatomic, assign) NSInteger ranktype;
@property (nonatomic, copy) NSString *specific_status;
@property (nonatomic, assign) NSInteger isVertical;
@property (nonatomic, copy) NSString *cate_id;

@end
