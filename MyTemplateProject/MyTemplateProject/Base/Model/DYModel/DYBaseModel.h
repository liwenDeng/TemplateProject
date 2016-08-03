//
//  DYBaseModel.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/3.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  斗鱼Modle基类
 */
@interface DYBaseModel : NSObject

@property (nonatomic, assign) NSInteger error;
@property (nonatomic, strong) NSArray *data;

@end
