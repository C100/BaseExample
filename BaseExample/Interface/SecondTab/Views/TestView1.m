//
//  TestView1.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/13.
//  Copyright © 2017年 james. All rights reserved.
//

#import "TestView1.h"

@implementation TestView1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    if (self=[super init]) {
        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}
@end
