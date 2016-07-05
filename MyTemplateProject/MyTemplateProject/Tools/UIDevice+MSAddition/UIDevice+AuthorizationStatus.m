//
//  UIDevice+AuthorizationStatus.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "UIDevice+AuthorizationStatus.h"
#import <AVFoundation/AVFoundation.h>
#import <AddressBook/AddressBook.h>

@implementation UIDevice (AuthorizationStatus)

+ (BOOL)ms_isCameraAuthorization
{
    __block BOOL isValid = YES;
    //判断iOS7的宏，没有就自己写个，下边的方法是iOS7新加的，7以下调用会报错
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            isValid = granted;
        }];
    }
    
    return isValid;
}

+ (BOOL)ms_isAudioAuthorization
{
    __block BOOL isValid = YES;
    //判断iOS7的宏，没有就自己写个，下边的方法是iOS7新加的，7以下调用会报错
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            isValid = granted;
        }];
    }
    
    return isValid;
}

+ (BOOL)ms_isAddressBookAuthorization
{
    BOOL isValid = YES;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
    {
        ABAuthorizationStatus authStatus =ABAddressBookGetAuthorizationStatus();
        if (authStatus != kABAuthorizationStatusAuthorized)
        {
            isValid = NO;
        }
    }
    return isValid;
}

+ (BOOL)ms_authorAddressBook
{
    __block BOOL ret = YES;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
    {
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            ret = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    return ret;
}

@end
