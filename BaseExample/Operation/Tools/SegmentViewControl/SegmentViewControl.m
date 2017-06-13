//
//  SegmentViewControl.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/12.
//  Copyright © 2017年 james. All rights reserved.
//

#import "SegmentViewControl.h"
#import "CalculateSize.h"
#define TITLESFONT [UIFont systemFontOfSize:16]
#define TITLESCOLOR [UIColor colorWithWhite:0.200 alpha:1.000]
#define TITLESSELECTEDCOLOR [UIColor greenColor]
static const CGFloat titlesHeight = 44;
static const CGFloat edgmargin = 14;///外边距
static const CGFloat inmargin = 15;///内边距
@interface SegmentViewControl ()<UIScrollViewDelegate>
/**
 标题栏
 */
@property (weak,nonatomic)UIView *titlesView;

@property(nonatomic,weak)UIView *titleUnderline;

@property(weak,nonatomic)UIButton *previousClickedTitleButton;


@property (nonatomic,assign)CGFloat lastPosition;

/**
 大scrollView
 */
@property(weak,nonatomic)UIScrollView *scrollView;

/**
 标题栏上的scrollView
 */
@property (weak,nonatomic)UIScrollView *titlesScrollView;
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
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.titlesScrollView = scrollView;
    UIView *titlesView = [[UIView alloc] init];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.offset(titlesHeight);
    }];
    [scrollView addSubview:titlesView];
    [titlesView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(scrollView).with.insets(UIEdgeInsetsZero);
        make.height.equalTo(scrollView);
    }];
    titlesView.backgroundColor = [UIColor whiteColor];
    self.titlesView = titlesView;
    
    
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
    // 计算titlesButton需要占多大的宽度
    __block CGFloat needWith = 0.0;
    [titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize size = [CalculateSize sizeForNoticeTitle:obj font:TITLESFONT maxW:SCREEN_WIDTH];
        
        needWith += size.width+inmargin*2;
    }];
    needWith += edgmargin*2;
    
    CGFloat realinmargin;
    if (needWith <SCREEN_WIDTH) {//不适用设置的内边距
        CGFloat remander = SCREEN_WIDTH - needWith;
        realinmargin = remander/(titles.count*2)+inmargin;
    }else{
        realinmargin = inmargin;
    }
    
    // 标题文字
    NSUInteger count = titles.count;
    UIButton *lastButton;
    // 创建标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        // 文字
        titleButton.titleLabel.font = TITLESFONT;
        
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:TITLESCOLOR forState:UIControlStateNormal];
        [titleButton setTitleColor:TITLESSELECTEDCOLOR forState:UIControlStateSelected];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:titleButton];
        // frame
        CGSize size = [CalculateSize sizeForNoticeTitle:titles[i] font:TITLESFONT maxW:SCREEN_WIDTH];
        if (i == 0) {
            [titleButton makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view).offset(edgmargin);
                make.top.equalTo(view);
                make.size.sizeOffset(CGSizeMake(size.width+realinmargin*2, titlesHeight));
            }];
            lastButton = titleButton;
        }else{
            [titleButton makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastButton.right);
                make.top.equalTo(view);
                make.size.sizeOffset(CGSizeMake(size.width+realinmargin*2, titlesHeight));
            }];
            lastButton = titleButton;
        }
    }
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastButton.right).offset(edgmargin);
    }];
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
        if (titleButton.center.x>self.center.x&&self.titlesView.frame.size.width - titleButton.center.x>self.center.x) {
            CGFloat offsetx = titleButton.center.x - self.center.x;
            self.titlesScrollView.contentOffset = CGPointMake(offsetx, self.scrollView.contentOffset.y);
        }else{
            if (titleButton.center.x<self.center.x&&self.titlesScrollView.contentOffset.x!=0) {
                self.titlesScrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y);
            }else if (self.titlesView.frame.size.width - titleButton.center.x<self.center.x&&self.titlesScrollView.contentOffset.x<self.titlesView.frame.size.width-self.frame.size.width){
                self.titlesScrollView.contentOffset = CGPointMake(self.titlesView.frame.size.width-self.frame.size.width, self.scrollView.contentOffset.y);
            }
        }
        CGPoint center = self.titleUnderline.center;
        center.x = titleButton.center.x;
        self.titleUnderline.center = center;
        CGFloat wirth = titleButton.frame.size.width;
        CGRect rect = self.titleUnderline.bounds;
        rect.size.width = wirth;
        self.titleUnderline.bounds = rect;
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
        if (titleButton.center.x>self.center.x&&self.titlesView.frame.size.width - titleButton.center.x>self.center.x) {
            CGFloat offsetx = titleButton.center.x - self.center.x;
            self.titlesScrollView.contentOffset = CGPointMake(offsetx, self.scrollView.contentOffset.y);
        }else{
            if (titleButton.center.x<self.center.x&&self.titlesScrollView.contentOffset.x!=0) {
                self.titlesScrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y);
            }else if (self.titlesView.frame.size.width - titleButton.center.x<self.center.x&&self.titlesScrollView.contentOffset.x<self.titlesView.frame.size.width-self.frame.size.width){
                self.titlesScrollView.contentOffset = CGPointMake(self.titlesView.frame.size.width-self.frame.size.width, self.scrollView.contentOffset.y);
            }
        }
        CGPoint center = self.titleUnderline.center;
        center.x = titleButton.center.x;
        self.titleUnderline.center = center;
        CGFloat wirth = titleButton.frame.size.width;
        CGRect rect = self.titleUnderline.bounds;
        rect.size.width = wirth;
        self.titleUnderline.bounds = rect;
        
    } completion:^(BOOL finished) {
        
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
        
    }];
}
@end
