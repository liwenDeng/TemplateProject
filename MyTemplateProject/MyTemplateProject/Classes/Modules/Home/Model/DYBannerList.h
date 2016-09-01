//
//  DYBannerList.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/30.
//  Copyright © 2016年 dengliwen. All rights reserved.
//
/**
 *  轮播图列表
 */

#import "DYBaseModel.h"
#import "DYRoomModel.h"

@interface DYBannerModel : NSObject

@property (nonatomic, strong) NSString *roomId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic_url; //大图
@property (nonatomic, strong) NSString *tv_pic_url; //小图
@property (nonatomic, strong) DYRoomModel *room;

@end

@interface DYBannerList : DYBaseModel

@end
