//
//  FirstTabView.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "FirstTabView.h"

@implementation FirstTabView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)init{
    self=[super init];
    if (self) {
        UIView *bgview=[[UIView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
        [self addSubview:bgview];
        ViewBorderRadius(bgview, 50, 2, RGBColor(0, 0, 0));
    }
    return self;
}

@end
