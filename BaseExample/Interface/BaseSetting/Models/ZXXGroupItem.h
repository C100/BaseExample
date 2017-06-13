//
//  ZXXGroupItem.h
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZXXSetItem;
@interface ZXXGroupItem : NSObject
/**
 *一组有多少行cell(ZXXSetItem)
 */
@property (nonatomic, strong)NSArray<ZXXSetItem*> *items;

/**
 *头标题
 */
@property (nonatomic, copy)NSString *headerTitle;
/**
 *尾标题
 */
@property (nonatomic, copy)NSString *footerTitle;
@end
