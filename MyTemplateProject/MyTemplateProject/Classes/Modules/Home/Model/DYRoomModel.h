//
//  DYRoomModel.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseModel.h"
/**
 *  单个房间Model
 */
@interface DYRoomModel : NSObject

@property (nonatomic, copy) NSString *room_id;
@property (nonatomic, copy) NSString *room_name;
@property (nonatomic, copy) NSString *nickname;     //主播昵称
@property (nonatomic, copy) NSString *owner_uid;    //主播id
@property (nonatomic, copy) NSString *room_src;     //房间图片
@property (nonatomic, copy) NSString *vertical_src; //房间图片
@property (nonatomic, assign) NSInteger online;     //在线人数
@property (nonatomic, copy) NSString *game_name;    //游戏名称

// 以下为不重要信息
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *child_id;
@property (nonatomic, copy) NSString *show_time;
@property (nonatomic, copy) NSString *show_status;
@property (nonatomic, copy) NSString *specific_catalog;
@property (nonatomic, assign) NSInteger ranktype;
@property (nonatomic, assign) NSInteger isVertical;
@property (nonatomic, copy) NSString *cate_id;
@property (nonatomic, copy) NSString *specific_status;
@property (nonatomic, copy) NSString *vod_quality;

@end