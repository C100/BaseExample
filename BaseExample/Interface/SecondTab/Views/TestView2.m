//
//  TestView2.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/13.
//  Copyright © 2017年 james. All rights reserved.
//

#import "TestView2.h"

@implementation TestView2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
@end
