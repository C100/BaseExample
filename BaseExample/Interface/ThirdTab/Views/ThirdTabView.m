//
//  ThirdTabView.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ThirdTabView.h"

@implementation ThirdTabView

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
        [self.topbarview setTitleLabel:THIRDTAB_TITLE TextColor:[UIColor whiteColor]];
    }
    return self;
}

@end
