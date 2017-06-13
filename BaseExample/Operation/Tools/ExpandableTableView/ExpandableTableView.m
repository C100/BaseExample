//
//  ExpandableTableView.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/4/22.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ExpandableTableView.h"

@implementation ExpandableTableView

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
        
    }
    return self;
}

-(void)setDelegate:(id<UITableViewDelegate>)delegate{
    [super setDelegate:delegate];
}



@end
