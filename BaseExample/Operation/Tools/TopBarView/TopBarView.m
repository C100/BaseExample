//
//  TopBarView.m
//  hjtx
//
//  Created by 朱林峰 on 2016/10/7.
//  Copyright © 2016年 james. All rights reserved.
//

#import "TopBarView.h"
@interface TopBarView()


//顶栏左侧点击手势
@property (nonatomic) UITapGestureRecognizer *topBarLeftTap;
//顶栏右侧点击手势
@property (nonatomic) UITapGestureRecognizer *topBarRightTap;
//左右手势block
@property (nonatomic,copy) LeftViewClickBlock leftViewClickBlock;
@property (nonatomic,copy) RightViewClickBlock rightViewClickBlock;
@end
@implementation TopBarView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    }
    return self;
}

//顶栏左侧手势
- (UITapGestureRecognizer *)topBarLeftTap{
    if (_topBarLeftTap == nil) {
        _topBarLeftTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topBarLeftTapAction:)];
    }
    return _topBarLeftTap;
}
//顶栏右侧手势
- (UITapGestureRecognizer *)topBarRightTap{
    if (_topBarRightTap == nil) {
        _topBarRightTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topBarRightTapAction:)];
    }
    return _topBarRightTap;
}

- (UIView *)titleView{
    if(_titleView == nil){
        //标题view
        _titleView=[[UIView alloc] initWithFrame:CGRectMake(70, 20, SCREEN_WIDTH-140, 44)];
        [self addSubview:_titleView];
    }
    return _titleView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 14, self.titleView.frame.size.width, 20)];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.font=FONT_TITLELABEL;
        [self.titleView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)leftView{
    if (_leftView == nil) {
        _leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
        [self addSubview:_leftView];
    }
    return _leftView;
}
- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 20, 20)];
        [self.leftView addSubview:_leftImageView];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftImageView;
}
- (UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 14, 45, 20)];
        _leftLabel.textAlignment=NSTextAlignmentLeft;
        _leftLabel.font=FONT_LEFTLABEL;
        [self.leftView addSubview:_leftLabel];
    }
    return _leftLabel;
}
- (UIView *)rightView{
    if (_rightView == nil) {
        _rightView=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 20, 60, 44)];
        [self addSubview:_rightView];
    }
    return _rightView;
}
- (UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        _rightImageView=[[UIImageView alloc] initWithFrame:CGRectMake(25, 14, 20, 20)];
        [self.rightView addSubview:_rightImageView];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightImageView;
}
- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 14, 45, 20)];
        _rightLabel.textAlignment=NSTextAlignmentRight;
        _rightLabel.font=FONT_RIGHTLABEL;
        [self.rightView addSubview:_rightLabel];
    }
    return _rightLabel;
}

//顶栏背景色
-(void)setTopBarView_backgroundColor:(UIColor*)backgroundcolor{
    self.backgroundColor=backgroundcolor;
}
#pragma mark —— 顶栏点击事件
/*顶栏左侧点击事件*/
-(void)leftViewClick:(LeftViewClickBlock)block{
    self.leftViewClickBlock=block;
    [self.leftView removeGestureRecognizer:self.topBarLeftTap];
    [self.leftView addGestureRecognizer:self.topBarLeftTap];
}
/*顶栏右侧点击事件*/
-(void)rightViewClick:(RightViewClickBlock)block{
    _rightViewClickBlock=block;
    [self.leftView removeGestureRecognizer:self.topBarRightTap];
    [self.rightView addGestureRecognizer:self.topBarRightTap];
}

-(void)topBarLeftTapAction:(id)sender{
    self.leftViewClickBlock(sender);
}

-(void)topBarRightTapAction:(id)sender{
    self.rightViewClickBlock(sender);
}

#pragma mark —— 顶栏左右侧文字和图标设置
//左侧图标
-(void)setLeftView_icon:(UIImage*)image{
    self.leftImageView.image=image;
}

//左侧文字
-(void)setLeftView_text:(NSString *)text TextColor:(UIColor *)textColor{
    self.leftLabel.text=text;
    self.leftLabel.textColor=textColor;
}

//标题文字
-(void)setTitleLabel:(NSString *)text TextColor:(UIColor *)textColor{
    self.titleLabel.text=text;
    self.titleLabel.textColor=textColor;
}

//右侧图标
-(void)setRightView_icon:(UIImage*)image{
//    self.rightLabel.hidden=true;
    self.rightImageView.image=image;
}

//右侧文字
-(void)setRightView_text:(NSString*)text TextColor:(UIColor *)textColor{
//    _rightImageView.hidden=true;
    self.rightLabel.text=text;
    self.rightLabel.textColor=textColor;
}


@end
