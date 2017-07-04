//
//  ZXXSettingCell.h
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXXBaseSetting.h"
#import "ZXXBadgeView.h"
//@class ZXXSetItem;


@interface ZXXSettingCell : UITableViewCell

+ (instancetype)cellTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

/**
 *模型
 */
@property (nonatomic, strong)ZXXSetItem *item;

@end
