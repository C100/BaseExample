//
//  ZXXSettingCell.h
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import <QMUITableViewCell.h>
#import "ZXXBaseSetting.h"
#import "ZXXBadgeView.h"


@interface ZXXSettingCell : QMUITableViewCell

+ (instancetype)cellTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

/**
 *模型
 */
@property (nonatomic, strong)ZXXSetItem *item;

@end
