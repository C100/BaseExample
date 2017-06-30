//
//  SettingViewController.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/10.
//  Copyright © 2017年 james. All rights reserved.
//

#import "SettingViewController.h"
#import "SegmentViewControl.h"
@interface SettingViewController ()
@property (nonatomic, weak) ZXXCheakItem *selectedCheakItem;
@end

@implementation SettingViewController
- (BOOL)isMain{
    return NO;
}

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.titleView.title = @"设置";
}

- (void)didInitialized {
    [super didInitialized];
    [self setGroup1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setGroup1{
    @WeakObj(self);
    ZXXCheakItem *apply = [ZXXCheakItem itemWithTitle:@"my" cheak:NO WithAttribute:nil cellHeight:44 WithOption:^(ZXXCheakItem * _Nullable item) {
        @StrongObj(self);
        [self setItem:item];
    }];
    ZXXCheakItem *award = [ZXXCheakItem itemWithTitle:@"you" cheak:NO WithAttribute:nil cellHeight:44 WithOption:^(ZXXCheakItem * _Nullable item) {
        @StrongObj(self);
        [self setItem:item];
    }];
    
    ZXXCheakItem *badge = [ZXXCheakItem itemWithTitle:@"he" cheak:NO WithAttribute:nil cellHeight:44 WithOption:^(ZXXCheakItem * _Nullable item) {
        @StrongObj(self);
        [self setItem:item];
    }];
    
    ZXXGroupItem *group = [[ZXXGroupItem alloc]init];
    group.items = @[apply,award,badge];
    [self.groups addObject:group];
    ZXXSetItem *item = self.receivedDictionary[@"model"];
    [self setItemWithTitle:item.rightTitle];
}
- (void)setItem:(ZXXCheakItem *)item{
    _selectedCheakItem.cheak = NO;
    item.cheak = YES;
    _selectedCheakItem = item;
    [self.tableView reloadData];
    ZXXSetItem *itm = self.receivedDictionary[@"model"];
    itm.rightTitle = item.title;
    UITableView *tableview = self.receivedDictionary[@"tableView"];
    [tableview reloadData];
}
- (void)setItemWithTitle:(NSString *)title{
    for (ZXXGroupItem *group in self.groups) {
        for (ZXXCheakItem *item in group.items) {
            if ([item.title isEqualToString:title]) {
                [self setItem:item];
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
