//
//  BaseSettingViewController.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/4/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseSettingViewController.h"


@interface BaseSettingViewController ()

@end

@implementation BaseSettingViewController
- (UIView *)baseView{
    if (_baseView == nil) {
        _baseView = [[UIView alloc] init];
    }
    return _baseView;
}
- (CellPostNoteType)type{
    return CellPostNoteTypeNULL;
}
- (BOOL)isMain{
    return YES;
}
- (NSMutableArray *)groups{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加导航栏
    self.view.backgroundColor=COLOR_BACKGROUND;
    _topbarview=[[TopBarView alloc] init];
    [self.view addSubview:_topbarview];
    
    // 添加tableView
    if (self.isMain == YES) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
    }else{
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZXXGroupItem *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXXSettingCell *cell;
    // 给cell传递模型
    ZXXGroupItem *group = self.groups[indexPath.section];
    ZXXSetItem *item = group.items[indexPath.row];
    if (self.type==CellPostNoteTypeNULL) {
        cell = [ZXXSettingCell cellTableView:tableView reuseIdentifier:CELLCOMMON];
    }else if (self.type==CellPostNoteTypeWithkeyBoardHiden){
        if (item.class == [ZXXTextFieldItem class]) {
            ///这里因为cell里面的textField的get方法中添加了观察中心。所以为了区别其他cell独立出一个reuseIdentifier
            NSString *reuseIdentifier = [NSString stringWithFormat:@"%@_TextField",CELLCOMMON_EDIT];
            cell = [ZXXSettingCell cellTableView:tableView reuseIdentifier:reuseIdentifier];
        }else{
            cell = [ZXXSettingCell cellTableView:tableView reuseIdentifier:CELLCOMMON_EDIT];
        }
    }
    
    cell.item = item;
    
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消选中一行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZXXGroupItem *group = self.groups[indexPath.section];
    
    ZXXSetItem *item = group.items[indexPath.row];
    
    if (item.option) {
        item.option(item);
        return;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXXGroupItem *group = self.groups[indexPath.section];
    ZXXSetItem *item = group.items[indexPath.row];
    if (item.height) {
        return item.height;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    ZXXGroupItem *group = self.groups[section];
    if (group.headerTitle) {
        return 44;
    }else{
        if (section == 0) {
            return 0.01;
        }else{
            return 10;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    ZXXGroupItem *group = self.groups[section];
    if (group.footerTitle) {
        return 44;
    }else{
        return 0.01;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    ZXXGroupItem *group = self.groups[section];
    return group.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    ZXXGroupItem *group = self.groups[section];
    return group.footerTitle;
}

@end
