//
//  Const(常量文件).h
//  IOS-example
//
//  Created by 朱林峰 on 2017/1/7.
//  Copyright © 2017年 james. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef Const_______h
#define Const_______h

/**errorcode*/
static NSString* const NETWORK_ERROR = @"10000";

/**api请求地址*/
static NSString* const BASE_URL=@"http://101.37.34.55";

/**友盟appkey*/
static NSString* const USHARE_APPKEY=@"";

#pragma mark - reuseIdentifier - 重用标识
/**cell重用标识*/
static NSString* const CELLCOMMON = @"CELLCOMMON_IDENTIFIER";
static NSString* const CELLCOMMON_EDIT = @"CELLCOMMON_EDIT_IDENTIFIER";

#pragma mark - FONT_name_size
/**COMMON_NAME*/
static NSString* const FONT_NAME = @"STHeitiSC-Light";
/**COMMON_SIZE*/
static CGFloat const FONT_SIZE = 16;

#endif /* Const_______h */
