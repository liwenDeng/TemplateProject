//
//  UIDevice+AuthorizationStatus.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//
/**
 * 1.iOS 7 无法使用原生二维码读取功能
 *
 */

#import <UIKit/UIKit.h>
/**
 *  判断设备授权
 */
@interface UIDevice (AuthorizationStatus)

//判断摄像头是否已经授权可以使用
+ (BOOL)ms_isCameraAuthorization;

//判断麦克风是否已经授权可以使用
+ (BOOL)ms_isAudioAuthorization;

//判断通讯录是否已经授权可以使用
+ (BOOL)ms_isAddressBookAuthorization;

//调用设置通讯录授权
+ (BOOL)ms_authorAddressBook;

@end
