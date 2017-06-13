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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationData];
    [self setUpGroup1];
    [self setUpGroup2];
    [self setUpGroup3];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ZXXLog(@"%@",_item1.title);
    ZXXLog(@"%@",_item2.rightTitle);
    ZXXLog(@"%@",_item3.badgeValue);
    ZXXLog(@"%zd",_item4.on);
    ZXXLog(@"%@",_item5.rightTitle);
}
- (void)setNavigationData{
    self.topbarview.titleLabel.text = @"个人中心";
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
        [self pushWithData:@"SettingViewController" Data:@{@"model":item,@"tableView":self.tableView}];
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
    ZXXLabelArrowItem *award = [ZXXLabelArrowItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] title:@"ZXXLabelArrowItem" rightTitle:@"rightTitle" WithAttribute:nil cellHeight:50 WithOption:^(ZXXSetItem * _Nullable item) {
        @StrongObj(self);
        [self push:@"SettingViewController"];
    }];
    ZXXBadgeItem *bedage = [ZXXBadgeItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] title:@"ZXXBadgeItem" badgeValue:@"200" WithAttribute:nil cellHeight:50 WithOption:nil];
    ZXXSwitchItem *alientTeam = [ZXXSwitchItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] title:@"asdfadfasd" on:YES WithAttribute:nil cellHeight:50 WithOption:nil];
    ZXXTextFieldItem *tesfield = [ZXXTextFieldItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] title:@"ZXXTextFieldItem" rightTitle:@"righttextField" WithAttribute:nil cellHeight:70 WithOption:nil];
    ZXXGroupItem *group = [[ZXXGroupItem alloc]init];
    group.items = @[apply,bedage,award,alientTeam,tesfield];
    [self.groups addObject:group];
}
- (void)setUpGroup3{
    @WeakObj(self);
    ZXXArrowItem *apply = [ZXXArrowItem itemWithImage:[UIImage imageNamed:@"home_icon_travel"] subtitle:@"ZXXArrowItemsubtitle" title:@"ZXXArrowItemtitle" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.size = CGSizeMake(60, 60);
        attribute.titleColor = [UIColor yellowColor];
        attribute.titleFont = [UIFont systemFontOfSize:18];
        attribute.subTitleColor = [UIColor purpleColor];
        attribute.subTitleFont = [UIFont systemFontOfSize:12];
    } cellHeight:120 WithOption:^(ZXXSetItem * _Nullable item) {
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
    [self.groups addObject:group];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
