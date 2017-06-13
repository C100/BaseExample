//
//  SegmentViewControl.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/12.
//  Copyright © 2017年 james. All rights reserved.
//

#import "SegmentViewControl.h"

#define TITLESFONT [UIFont systemFontOfSize:16]
#define TITLESCOLOR [UIColor colorWithWhite:0.200 alpha:1.000]
#define TITLESSELECTEDCOLOR [UIColor greenColor]

@interface SegmentViewControl ()<UIScrollViewDelegate>
/**
 标题栏
 */
@property (weak,nonatomic)UIView *titlesView;

@property(nonatomic,weak)UIView *titleUnderline;

@property(weak,nonatomic)UIButton *previousClickedTitleButton;

@property (nonatomic,assign)CGFloat lastPosition;

@property(weak,nonatomic)UIScrollView *scrollView;
@end

@implementation SegmentViewControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)segmentTitles:(NSArray *)titles withViews:(NSArray *)views withFrame:(CGRect)rect{
    SegmentViewControl *segmentViewControl = [[self alloc] init];
    segmentViewControl.frame = rect;
    [segmentViewControl setupTitlesViewWithTitles:titles];
    [segmentViewControl setupScrollViewWithViews:views];
    return segmentViewControl;
}

- (void)setupTitlesViewWithTitles:(NSArray *)titles
{
//    UIScrollView *scrollView = [[UIScrollView alloc] init];
//    [self addSubview:scrollView];
    UIView *titlesView = [[UIView alloc] init];
//    [scrollView addSubview:titlesView];
    titlesView.backgroundColor = [UIColor whiteColor];
    [self addSubview:titlesView];
    self.titlesView = titlesView;
    [titlesView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.offset(44);
    }];
    
    // 标题栏按钮
    [self setupTitlesButtonsInView:titlesView withTitles:titles];
    
    UIView *seperateLine = [[UIView alloc] init];
    [titlesView addSubview:seperateLine];
    seperateLine.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1.000];
    [seperateLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titlesView);
        make.bottom.equalTo(titlesView.bottom);
        make.width.equalTo(titlesView);
        make.height.offset(1);
    }];
    // 标题下划线
    [self setupTitleUnderlineOnView:titlesView];
    
    
}
/**
 *  标题栏按钮
 */
- (void)setupTitlesButtonsInView:(UIView *)view withTitles:(NSArray *)titles
{
    // 标题文字
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = (SCREEN_WIDTH - 28) / count;
    CGFloat titleButtonH = 44;
    
    // 创建标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:titleButton];
        // frame
        [titleButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(i*titleButtonW+14);
            make.top.equalTo(view);
            make.size.sizeOffset(CGSizeMake(titleButtonW, titleButtonH));
        }];
        // 文字
        titleButton.titleLabel.font = TITLESFONT;
        
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:TITLESCOLOR forState:UIControlStateNormal];
        [titleButton setTitleColor:TITLESSELECTEDCOLOR forState:UIControlStateSelected];
    }
}
/**
 *  标题下划线
 */
- (void)setupTitleUnderlineOnView:(UIView *)view
{
    // 标题按钮
    UIButton *firstTitleButton = view.subviews.firstObject;
    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [view addSubview:titleUnderline];
    _titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [titleUnderline makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.bottom);
        make.height.offset(2);
        make.centerX.equalTo(firstTitleButton);
        make.width.equalTo(firstTitleButton);
    }];
}
/**
 *  scrollView
 */
- (void)setupScrollViewWithViews:(NSArray *)views
{
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.scrollsToTop = NO; // 点击状态栏的时候，这个scrollView不会滚动到最顶部
    [self addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlesView.bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    self.scrollView = scrollView;
    // 如果没有设置默认为这个尺寸
    scrollView.contentSize = CGSizeMake(views.count*SCREEN_WIDTH, SCREEN_HEIGHT-157);
    
    // 创建zi控制器
    [views enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class=NSClassFromString(obj);
        id controller=[[class alloc] initWithFrame:CGRectMake(idx*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-157)];
        [scrollView addSubview:controller];
    }];
    
    
}
#pragma mark - 监听
/**
 *  点击标题按钮
 */
- (void)titleButtonClick:(UIButton *)titleButton
{
    // 重复点击了标题按钮
    if (self.previousClickedTitleButton == titleButton) {
        return;
    }
    
    // 处理标题按钮点击
    [self dealTitleButtonClick:titleButton];
}
/**
 *  处理标题按钮点击
 */
- (void)dealTitleButtonClick:(UIButton *)titleButton
{
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    NSUInteger index = titleButton.tag;
    // 滚动scrollView
    CGFloat offsetX = self.scrollView.frame.size.width * index;
    [UIView animateWithDuration:0.25 animations:^{
        
        CGPoint center = self.titleUnderline.center;
        center.x = titleButton.center.x;
        self.titleUnderline.center = center;
        
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        // 添加子控制器的view
    }];
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x-_lastPosition>0) { // 右滑
        NSUInteger index = (scrollView.contentOffset.x + scrollView.frame.size.width/2) / scrollView.frame.size.width;
        if (index != self.previousClickedTitleButton.tag && index<self.titlesView.subviews.count-2) {
            // 点击对应的标题按钮
            UIButton *titleButton = self.titlesView.subviews[index];
            [self dealTitleButton:titleButton];
        }
    }else{
        NSUInteger index = (scrollView.contentOffset.x+scrollView.frame.size.width/2) / scrollView.frame.size.width;
        if (index != self.previousClickedTitleButton.tag&& index<self.titlesView.subviews.count-2) {
            // 点击对应的标题按钮
            UIButton *titleButton = self.titlesView.subviews[index];
            [self dealTitleButton:titleButton];
        }
    }
    _lastPosition = scrollView.contentOffset.x;
}
- (void)dealTitleButton:(UIButton *)titleButton{
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    [UIView animateWithDuration:0.25 animations:^{
        
        CGPoint center = self.titleUnderline.center;
        center.x = titleButton.center.x;
        self.titleUnderline.center = center;
    } completion:^(BOOL finished) {
        // 添加子控制器的view
    }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 点击对应的标题按钮
    UIButton *titleButton = self.titlesView.subviews[index];
    
    [self dealWithscrollViewcontentoffset:titleButton];
}
- (void)dealWithscrollViewcontentoffset:(UIButton *)titleButton{
    NSUInteger index = titleButton.tag;
    // 滚动scrollView
    CGFloat offsetX = self.scrollView.frame.size.width * index;
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        // 添加子控制器的view
    }];
}
@end
