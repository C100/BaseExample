//
//  BaseSettingViewController.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/4/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseViewController.h"

#import "TopBarView.h"

#import "ZXXGroupItem.h"
#import "ZXXBaseSetting.h"

#import "ZXXSettingCell.h"
typedef NS_ENUM(NSUInteger,CellPostNoteType){
    CellPostNoteTypeNULL = 1,
    CellPostNoteTypeWithkeyBoardHiden = 2
};
@interface BaseSettingViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
/**
 *描述控制器有多少组
 */
@property (nonatomic, strong)NSMutableArray *groups;

@property (nonatomic, strong)UITableView *tableView;

@property(nonatomic)TopBarView *topbarview;

/**
 描述点击cell时是否发送结束编辑
 @return 默认为CellPostNoteTypeNULL
 注意：如果右侧带有TextField时必须使用CellPostNoteTypeWithkeyBoardHiden
 */
- (CellPostNoteType)type;

/**
 是否是tabBar上的控制器
 @return 默认为YES;
 */
- (BOOL)isMain;

@end
