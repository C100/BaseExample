//
//  IDCountDownButton.h
//  倒计时按钮
//
//  Created by zoekebi_Mac on 2017/3/16.
//  Copyright © 2017年 zoekebi_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDCountDownButton : UIButton
/** 验证码倒计时的时长 */
@property (nonatomic, assign) NSInteger durationOfCountDown;
- (void)startCountDown;
@end
