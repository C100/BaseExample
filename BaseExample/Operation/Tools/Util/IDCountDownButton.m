//
//  IDCountDownButton.m
//  倒计时按钮
//
//  Created by zoekebi_Mac on 2017/3/16.
//  Copyright © 2017年 zoekebi_Mac. All rights reserved.
//

#import "IDCountDownButton.h"
@interface IDCountDownButton ()

/** 保存倒计时按钮的非倒计时状态的title */
@property (nonatomic, copy) NSString *originalTitle;
/** 保存倒计时的时长 */
@property (nonatomic, assign) NSInteger tempDurationOfCountDown;
/** 定时器对象 */
//@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation IDCountDownButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置默认的倒计时时长为60秒
        self.durationOfCountDown = 60;
        // 设置button的默认标题为“获取验证码”
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // 设置默认的倒计时时长为60秒
        self.durationOfCountDown = 60;
        // 设置button的默认标题为“获取验证码”
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}

/**
 拦截IDCountDownButton的点击事件，判断是否开始倒计时
 */
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // 若正在倒计时，不响应点击事件
    if (self.tempDurationOfCountDown != self.durationOfCountDown) {
        return NO;
    }
    // 若未开始倒计时，响应并传递点击事件，开始倒计时
//    [self startCountDown];
    return [super beginTrackingWithTouch:touch withEvent:event];
}

/**
 创建定时器，开始倒计时
 */
- (void)startCountDown {
//    self.countDownTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateIDCountDownButtonTitle) userInfo:nil repeats:YES];
    // 获得队列
    //    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 创建一个定时器(dispatch_source_t本质还是个OC对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        if (self.tempDurationOfCountDown == 0) {
            // 设置IDCountDownButton的title为开始倒计时前的title
            [self setTitle:self.originalTitle forState:UIControlStateNormal];
            // 恢复IDCountDownButton开始倒计时的能力
            self.tempDurationOfCountDown = self.durationOfCountDown;
            self.selected = NO;
//            [self.countDownTimer invalidate];
            dispatch_cancel(self.timer);
        } else {
            // 设置IDCountDownButton的title为当前倒计时剩余的时间
            [self setTitle:[NSString stringWithFormat:@"重新发送(%zds)", --self.tempDurationOfCountDown] forState:UIControlStateSelected];
        }
        
    });
    self.selected = YES;
    // 将定时器添加到当前的RunLoop中（自动开启定时器）
//    [[NSRunLoop currentRunLoop] addTimer:(NSTimer *)self.timer forMode:NSRunLoopCommonModes];
    dispatch_resume(self.timer);
}

/**
 更新IDCountDownButton的title为倒计时剩余的时间
 */
//- (void)updateIDCountDownButtonTitle {
//    if (self.tempDurationOfCountDown == 0) {
//        // 设置IDCountDownButton的title为开始倒计时前的title
//        [self setTitle:self.originalTitle forState:UIControlStateNormal];
//        // 恢复IDCountDownButton开始倒计时的能力
//        self.tempDurationOfCountDown = self.durationOfCountDown;
//        self.selected = NO;
//        [self.countDownTimer invalidate];
//    } else {
//        // 设置IDCountDownButton的title为当前倒计时剩余的时间
//        [self setTitle:[NSString stringWithFormat:@"重新发送(%zds)", self.tempDurationOfCountDown--] forState:UIControlStateSelected];
//    }
//}
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    // 倒计时过程中title的改变不更新originalTitle
    if (self.tempDurationOfCountDown == self.durationOfCountDown) {
        self.originalTitle = title;
    }
}
- (void)setDurationOfCountDown:(NSInteger)durationOfCountDown {
    _durationOfCountDown = durationOfCountDown;
    self.tempDurationOfCountDown = _durationOfCountDown;
}
- (void)dealloc {
//    [self.countDownTimer invalidate];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
