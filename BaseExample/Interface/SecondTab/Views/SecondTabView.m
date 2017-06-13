//
//  SecondTabView.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "SecondTabView.h"
#import "SegmentViewControl.h"
@implementation SecondTabView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self.topbarview setTitleLabel:SECONDTAB_TITLE TextColor:[UIColor whiteColor]];
        SegmentViewControl *segmentView = [SegmentViewControl segmentTitles:@[@"京东",@"天猫",@"淘宝",@"亚马逊",@"京东2",@"天猫2",@"淘宝2",@"亚马逊2"] withViews:@[@"TestView1",@"TestView2",@"TestView1",@"TestView2",@"TestView1",@"TestView2",@"TestView1",@"TestView2"] withFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-113)];
        
        [self addSubview:segmentView];
//        [segmentView makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.topbarview.bottom);
//            make.left.right.bottom.equalTo(self);
//        }];
    }
    return self;
}

@end
