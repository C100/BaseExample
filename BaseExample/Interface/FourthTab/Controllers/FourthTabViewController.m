//
//  FourthTabViewController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "FourthTabViewController.h"
#import "SettingViewController.h"

@interface FourthTabViewController ()
@property (nonatomic,strong)ZXXSetItem *item1;
@property (nonatomic,strong)ZXXSetItem *item2;
@property (nonatomic,strong)ZXXSetItem *item3;
@property (nonatomic,strong)ZXXSetItem *item4;
@property (nonatomic,strong)ZXXSetItem *item5;
@end

@implementation FourthTabViewController
- (CellPostNoteType)type{
    return CellPostNoteTypeWithkeyBoardHiden;
}
- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.titleView.title = @"个人中心";
    
}

- (void)didInitializedWithStyle:(UITableViewStyle)style {
    [super didInitializedWithStyle:style];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)initTableView{
    [super initTableView];
    [self setUpGroup1];
    [self setUpGroup2];
    [self setUpGroup3];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ZXXLog(@"%@",_item1.title);
    ZXXLog(@"%@",_item2.rightTitle);
    ZXXLog(@"%@",_item3.badgeValue);
    ZXXLog(@"%zd",_item4.on);
    ZXXLog(@"%@",_item5.rightTitle);
}

- (void)setUpGroup1{
    @WeakObj(self);
    ZXXArrowItem *apply = [ZXXArrowItem itemWithTitle:@"第一行的测试标题"
                                        WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.titleColor = [UIColor redColor];
        attribute.titleFont = [UIFont systemFontOfSize:18];
    } cellHeight:60 WithOption:^(ZXXSetItem * _Nullable item) {
        @StrongObj(self);
        
        [self push:@"SettingViewController"];
    }];
    _item1 = apply;
    ZXXLabelArrowItem *award = [ZXXLabelArrowItem itemWithTitle:@"ZXXLabelArrowItem" rightTitle:@"he" WithAttribute:nil cellHeight:60 WithOption:^(ZXXLabelArrowItem * _Nullable item) {
        @StrongObj(self);
        //        [self push:@"SettingViewController"];
        [self push:@"SettingViewController" Data:@{@"model":item,@"tableView":self.tableView}];
    }];
    _item2 = award;
    ZXXBadgeItem *badge = [ZXXBadgeItem itemWithTitle:@"ZXXBadgeItem" badgeValue:@"10"WithAttribute:nil cellHeight:50 WithOption:nil];
    _item3 = badge;
    ZXXSwitchItem *alientTeam = [ZXXSwitchItem itemWithTitle:@"ZXXSwitchItem" on:YES WithAttribute:nil cellHeight:55 WithOption:nil];
    _item4 = alientTeam;
    ZXXTextFieldItem *tesfield = [ZXXTextFieldItem itemWithTitle:@"zheasdfasdffas" rightTitle:@"fasdfa"WithAttribute:nil cellHeight:65 WithOption:nil];
    _item5 = tesfield;
    ZXXGroupItem *group = [[ZXXGroupItem alloc]init];
    group.items = @[apply,award,badge,alientTeam,tesfield];
    group.headerTitle = @"第一组头标题";
    [self.groups addObject:group];
}

- (void)setUpGroup2{
    @WeakObj(self);
    ZXXArrowItem *apply = [ZXXArrowItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] title:@"ZXXArrowItemtitle" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.titleColor = [UIColor blueColor];
        attribute.titleFont = [UIFont systemFontOfSize:12];
    } cellHeight:30 WithOption:^(ZXXSetItem * _Nullable itme) {
        @StrongObj(self);
        [self push:@"SettingViewController"];
    }];
    ZXXLabelArrowItem *award = [ZXXLabelArrowItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] title:@"ZXXLabelArrowItem" rightTitle:@"rightTitle" WithAttribute:nil cellHeight:0 WithOption:^(ZXXSetItem * _Nullable item) {
        @StrongObj(self);
        [self push:@"SettingViewController"];
    }];
    ZXXBadgeItem *bedage = [ZXXBadgeItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] title:@"ZXXBadgeItem" badgeValue:@"200" WithAttribute:nil cellHeight:50 WithOption:nil];
    ZXXSwitchItem *alientTeam = [ZXXSwitchItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] title:@"asdfadfasd" on:YES WithAttribute:nil cellHeight:50 WithOption:nil];
    ZXXTextFieldItem *tesfield = [ZXXTextFieldItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] title:@"ZXXTextFieldItem" rightTitle:@"righttextField" WithAttribute:nil cellHeight:0 WithOption:nil];
    ZXXGroupItem *group = [[ZXXGroupItem alloc]init];
    group.items = @[apply,bedage,award,alientTeam,tesfield];
    group.headerTitle = @"第二组头标题";
    [self.groups addObject:group];
}
- (void)setUpGroup3{
    @WeakObj(self);
    ZXXArrowItem *apply = [ZXXArrowItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] subtitle:@"ZXXArrowItemsubtitle" title:@"ZXXArrowItemtitle" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(10, 14, 10, 0);
        attribute.titleColor = [UIColor yellowColor];
        attribute.titleFont = [UIFont systemFontOfSize:18];
        attribute.subTitleColor = [UIColor purpleColor];
        attribute.subTitleFont = [UIFont systemFontOfSize:12];
    } cellHeight:0 WithOption:^(ZXXSetItem * _Nullable item) {
        @StrongObj(self);
        [self push:@"SettingViewController"];
    }];
    ZXXLabelArrowItem *award = [ZXXLabelArrowItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] subtitle:@"ZXXLabelArrowItemsubtitle" title:@"ZXXLabelArrowItemtitle" rightTitle:@"rightTitle" WithAttribute:nil cellHeight:55 WithOption:^(ZXXSetItem * _Nullable item) {
        @StrongObj(self);
        [self push:@"SettingViewController"];
    }];
    ZXXBadgeItem *badge = [ZXXBadgeItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] subtitle:@"ZXXBadgeItemsubtitle" title:@"ZXXBadgeItemtitle" badgeValue:@"2000" WithAttribute:nil cellHeight:55 WithOption:nil];
    ZXXSwitchItem *alientTeam = [ZXXSwitchItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] subtitle:@"ZXXSwitchItemsubtitle" title:@"adsfasdfaf" on:YES WithAttribute:nil cellHeight:60 WithOption:nil];
    ZXXTextFieldItem *tesfield = [ZXXTextFieldItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] subtitle:@"ZXXTextFieldItemsubTitle" title:@"ZXXTextFieldItemtitle" rightTitle:@"rightTitle" WithAttribute:nil cellHeight:55 WithOption:nil];
    ZXXGroupItem *group = [[ZXXGroupItem alloc]init];
    group.items = @[apply,award,badge,alientTeam,tesfield];
    group.headerTitle = @"第三组头标题";
    [self.groups addObject:group];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
        return [super tableView:tableView heightForHeaderInSection:section];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
