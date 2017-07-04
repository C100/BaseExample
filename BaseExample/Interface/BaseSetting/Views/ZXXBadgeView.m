//
//  ZXXBadgeView.m
//  ZXXWeb
//
//  Created by zoekebi on 16/10/10.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXBadgeView.h"
#import "UIImage+tool.h"
#define BadgeViewFont [UIFont systemFontOfSize:11]
@implementation ZXXBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        // 设置字体大小
        self.titleLabel.font = BadgeViewFont;

        [self sizeToFit];
        
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    // 判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) { // 没有内容或者空字符串,等于0
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    CGSize size = [self.badgeValue sizeWithAttributes:@{@"font":BadgeViewFont}];
    if (size.width > self.frame.size.width-5) { // 文字的尺寸大于控件的宽度
        [self setBackgroundImage:[UIImage imageWithStretchableName:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(size.width+10, self.frame.size.height));
        }];
    }else{
        [self setBackgroundImage:[UIImage imageWithStretchableName:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
    }
    
}
@end
