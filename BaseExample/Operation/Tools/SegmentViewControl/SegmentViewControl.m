//
//  SegmentViewControl.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/12.
//  Copyright © 2017年 james. All rights reserved.
//

#import "SegmentViewControl.h"



@implementation SegmentViewItem

+ (instancetype)segmentViewItemFont:(UIFont *)font color:(UIColor *)color selectedColor:(UIColor *)selectedColor titlesBarHeight:(CGFloat)barheight margin:(CGFloat)margin padding:(CGFloat)padding lineIndicator_percent:(float)lineIndicator_percent{
    return [[self alloc] initWithFont:font color:color selectedColor:selectedColor titlesBarHeight:barheight margin:margin padding:padding lineIndicator_percent:lineIndicator_percent];
    
}
- (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color selectedColor:(UIColor *)selectedColor titlesBarHeight:(CGFloat)barheight margin:(CGFloat)margin padding:(CGFloat)padding lineIndicator_percent:(float)lineIndicator_percent{
    if (self=[super init]) {
        _titlesFont = font;
        _titlesColor = color;
        _titlesSelectedColor = selectedColor;
        _titlesBarHeight = barheight;
        _margin = margin;
        _padding = padding;
        _lineIndicator_percent = lineIndicator_percent;
    }
    return self;
}

@end

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

#import "CalculateSize.h"

#import "ZXXScrollView.h"

#define TITLESFONT [UIFont systemFontOfSize:16]
#define TITLESCOLOR [UIColor colorWithWhite:0.200 alpha:1.000]
#define TITLESSELECTEDCOLOR [UIColor greenColor]
/**
 默认分割线颜色
 */
#define SEPERATELINECOLOR [UIColor colorWithWhite:0.900 alpha:1.000]
static const CGFloat titlesHeight = 44;
static const CGFloat margin = 14;///外边距
static const CGFloat padding = 15;///内边距

@interface SegmentViewControl ()<UIScrollViewDelegate>
/**
 segmentItem模型属性
 */
@property (strong,nonatomic)SegmentViewItem * _Nullable item;
/**
 标题栏
 */
@property (weak,nonatomic)UIView *titlesView;
/**
 内容栏
 */
@property (weak,nonatomic)UIView *contentView;

/**
 指示条
 */
@property(nonatomic,weak)UIView *titleUnderline;

/**
 记录上一个被点击的按钮
 */
@property(weak,nonatomic)UIButton *previousClickedTitleButton;

/**
 滑动scrollView时，用来保存scrollViewDidScroll方法中上一次打印的位置
 */
@property (nonatomic,assign)CGFloat lastPosition;

/**
 大scrollView
 */
@property(weak,nonatomic)__kindof UIScrollView *scrollView;

/**
 标题栏上的scrollView
 */
@property (weak,nonatomic)UIScrollView *titlesScrollView;

/**
 分割线
 */
@property (weak,nonatomic)UIView *seperateLine;

@end

@implementation SegmentViewControl{
    NSArray *_array;
    
    SegmentViewControlIsLazyLoadType _type;
    
    BOOL _isViewControllers;
    id _currentViewOrViewControllor;
    
    NSArray *_titles;// 标题
    NSArray *_buttons;
    
    CGFloat _framWirth;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSArray<__kindof UIView *> *)viewsOtherwiseViewControllers{
    return _array;
}
- (id)currentViewOrViewControllor{
    return _currentViewOrViewControllor;
}

+ (instancetype)segmentTitles:(NSArray *_Nonnull)titles withItem:(SegmentViewItem * _Nullable)item withViews:(NSArray * _Nonnull)views recognizerTableCellEdit:(BOOL)rgCellEdit{
    SegmentViewControl *segmentViewControl = [[self alloc] init];
    segmentViewControl.item = item;
    [segmentViewControl setupTitlesViewWithTitles:titles withItem:item];
    
    [segmentViewControl setupScrollViewWithViews:views recognizerTableCellEdit:rgCellEdit];
    return segmentViewControl;
}
+ (instancetype)segmentTitles:(NSArray *)titles withItem:(SegmentViewItem *)item withViewControllers:(NSArray *)viewControllers loadType:(SegmentViewControlIsLazyLoadType)type recognizerTableCellEdit:(BOOL)rgCellEdit{
    SegmentViewControl *segmentViewControl = [[self alloc] init];
    segmentViewControl.item = item;
    [segmentViewControl setupTitlesViewWithTitles:titles withItem:item];
    [segmentViewControl setupScrollViewWithViewControllers:viewControllers type:type recognizerTableCellEdit:rgCellEdit];
    return segmentViewControl;
}

- (void)setupTitlesViewWithTitles:(NSArray *)titles withItem:(SegmentViewItem *)item
{
    // titleView用一个scrollView拖着，里面的尺寸随着内容的增加而增加
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self addSubview:scrollView];
    self.titlesScrollView = scrollView;
    
    UIView *titlesView = [[UIView alloc] init];
    [scrollView addSubview:titlesView];
    self.titlesView = titlesView;
    titlesView.backgroundColor = [UIColor whiteColor];
    // 标题栏按钮
    [self setupTitlesButtonsInView:titlesView withTitles:titles withItem:item];
    UIView *seperateLine = [[UIView alloc] init];
    [titlesView addSubview:seperateLine];
    self.seperateLine = seperateLine;
    seperateLine.backgroundColor = SEPERATELINECOLOR;
    
    // 标题下划线
    [self setupTitleUnderlineOnView:titlesView];
}
/**
 *  标题栏按钮
 */
- (void)setupTitlesButtonsInView:(UIView *)view withTitles:(NSArray *)titles withItem:(SegmentViewItem *)item
{
    _titles = titles;
    // 标题文字
    NSUInteger count = titles.count;
    // 创建标题按钮
    NSMutableArray *arraM = [NSMutableArray array];
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        // 文字
        if (item.titlesFont!=nil) {
            titleButton.titleLabel.font = item.titlesFont;
        }else{
            titleButton.titleLabel.font = TITLESFONT;
        }
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        if (item.titlesColor!=nil) {
            [titleButton setTitleColor:item.titlesColor forState:UIControlStateNormal];
        }else{
            [titleButton setTitleColor:TITLESCOLOR forState:UIControlStateNormal];
        }
        if (item.titlesSelectedColor!=nil) {
            [titleButton setTitleColor:item.titlesSelectedColor forState:UIControlStateSelected];
        }else{
            [titleButton setTitleColor:TITLESSELECTEDCOLOR forState:UIControlStateSelected];
        }
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:titleButton];
        [arraM addObject:titleButton];
    }
    _buttons = arraM;
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
}

/**
 *  scrollView 创建子视图
 */
- (void)setupScrollViewWithViews:(NSArray *)views recognizerTableCellEdit:(BOOL)rgCellEdit
{
    _isViewControllers = NO;
    UIScrollView *scrollView;
    if (rgCellEdit==YES) {
        scrollView = [[ZXXScrollView alloc] init];
    }else{
        scrollView = [[UIScrollView alloc] init];
    }
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.scrollsToTop = NO; // 点击状态栏的时候，这个scrollView不会滚动到最顶部
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *contentView = [[UIView alloc] init];
    [scrollView addSubview:contentView];
    self.contentView = contentView;
    contentView.userInteractionEnabled = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    
    // 创建zi视图
    NSMutableArray *arrayM = [NSMutableArray array];
    [views enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class=NSClassFromString(obj);
        id view=[[class alloc] init];
        [contentView addSubview:view];
        [arrayM addObject:view];
        if (idx == 0) {
            _currentViewOrViewControllor = view;
        }
    }];
    _array = arrayM;
}
/** *  scrollView 创建子控制器
 */
- (void)setupScrollViewWithViewControllers:(NSArray *)viewControllers type:(SegmentViewControlIsLazyLoadType)type recognizerTableCellEdit:(BOOL)rgCellEdit
{
    _type = type;
    _isViewControllers = YES;
    UIScrollView *scrollView;
    if (rgCellEdit==YES) {
        scrollView = [[ZXXScrollView alloc] init];
    }else{
        scrollView = [[UIScrollView alloc] init];
    }
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.scrollsToTop = NO; // 点击状态栏的时候，这个scrollView不会滚动到最顶部
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *contentView = [[UIView alloc] init];
    [scrollView addSubview:contentView];
    self.contentView = contentView;
    
    contentView.backgroundColor = [UIColor whiteColor];
    
    // 创建zi视图控制器
    NSMutableArray *arrayM = [NSMutableArray array];
    [viewControllers enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class=NSClassFromString(obj);
        __kindof UIViewController *controller=[[class alloc] init];

        if (idx==0) {
            [contentView addSubview:controller.view];
            
            _currentViewOrViewControllor = controller;
        }else{
            if (type == SegmentViewControlNotLazyLoad) {
                [contentView addSubview:controller.view];
            }
        }
        [arrayM addObject:controller];
    }];
    _array = arrayM;
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
    _currentViewOrViewControllor = _array[index];
    // 滚动scrollView
    CGFloat offsetX = self.scrollView.frame.size.width * index;
    [UIView animateWithDuration:0.25 animations:^{
        
        if(self.titlesView.frame.size.width>self.frame.size.width){
            if (titleButton.center.x>self.center.x+self.titlesScrollView.contentOffset.x&&self.titlesView.frame.size.width - self.titlesScrollView.contentOffset.x>self.frame.size.width) {
                CGFloat offsetx = titleButton.center.x - self.titlesScrollView.contentOffset.x - self.center.x;
                if (offsetx<=self.titlesView.frame.size.width - self.titlesScrollView.contentOffset.x-self.frame.size.width) {
                    self.titlesScrollView.contentOffset = CGPointMake(offsetx+self.titlesScrollView.contentOffset.x, self.titlesScrollView.contentOffset.y);
                }else{
                    self.titlesScrollView.contentOffset = CGPointMake(self.titlesView.frame.size.width-self.frame.size.width, self.titlesScrollView.contentOffset.y);
                }
            }else if(titleButton.center.x<self.center.x+self.titlesScrollView.contentOffset.x&&self.titlesScrollView.contentOffset.x!=0){
                CGFloat offsetx = self.titlesScrollView.contentOffset.x + self.center.x - titleButton.center.x;
                if (offsetx>self.titlesScrollView.contentOffset.x) {
                    self.titlesScrollView.contentOffset = CGPointMake(0, self.titlesScrollView.contentOffset.y);
                }else{
                    self.titlesScrollView.contentOffset = CGPointMake(self.titlesScrollView.contentOffset.x-offsetx, self.titlesScrollView.contentOffset.y);
                }
            }
        }else{
            ZXXLog(@"%f",self.titlesScrollView.contentOffset.x);
            if (self.titlesScrollView.contentOffset.x != 0) {
                self.titlesScrollView.contentOffset = CGPointMake(0, self.titlesScrollView.contentOffset.y);
            }
        }
        CGPoint center = self.titleUnderline.center;
        center.x = titleButton.center.x;
        self.titleUnderline.center = center;
        CGFloat wirth = titleButton.frame.size.width;
        CGRect rect = self.titleUnderline.bounds;
        if (self.item.lineIndicator_percent>0&&self.item.lineIndicator_percent<1) {
            rect.size.width = wirth*self.item.lineIndicator_percent;
        }else{
            rect.size.width = wirth;
        }
        self.titleUnderline.bounds = rect;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        // 添加子控制器的view
        if (_isViewControllers==YES && _type == SegmentViewControlIsLazyLoad) {///数值是视图控制器
            __kindof UIViewController *vc = _array[index];
            if(![self.scrollView.subviews containsObject:vc.view]){
                [vc.view makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(index*self.frame.size.width);
                    make.top.bottom.equalTo(self.contentView);
                    make.width.offset(self.frame.size.width);
                }];
                [self.scrollView addSubview:vc.view];
            }
        }
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
    if (_framWirth!=self.frame.size.width){
        return;
    }
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    NSUInteger index = titleButton.tag;
    _currentViewOrViewControllor = _array[index];
    [UIView animateWithDuration:0.25 animations:^{
        if(self.titlesView.frame.size.width>self.frame.size.width){
            if (titleButton.center.x>self.center.x+self.titlesScrollView.contentOffset.x&&self.titlesView.frame.size.width - self.titlesScrollView.contentOffset.x>self.frame.size.width) {
                CGFloat offsetx = titleButton.center.x - self.titlesScrollView.contentOffset.x - self.center.x;
                if (offsetx<=self.titlesView.frame.size.width - self.titlesScrollView.contentOffset.x-self.frame.size.width) {
                    self.titlesScrollView.contentOffset = CGPointMake(offsetx+self.titlesScrollView.contentOffset.x, self.titlesScrollView.contentOffset.y);
                }else{
                    self.titlesScrollView.contentOffset = CGPointMake(self.titlesView.frame.size.width-self.frame.size.width, self.titlesScrollView.contentOffset.y);
                }
            }else if(titleButton.center.x<self.center.x+self.titlesScrollView.contentOffset.x&&self.titlesScrollView.contentOffset.x!=0){
                CGFloat offsetx = self.titlesScrollView.contentOffset.x + self.center.x - titleButton.center.x;
                if (offsetx>self.titlesScrollView.contentOffset.x) {
                    self.titlesScrollView.contentOffset = CGPointMake(0, self.titlesScrollView.contentOffset.y);
                }else{
                    self.titlesScrollView.contentOffset = CGPointMake(self.titlesScrollView.contentOffset.x-offsetx, self.titlesScrollView.contentOffset.y);
                }
            }
        }else{
            if (self.titlesScrollView.contentOffset.x != 0) {
                self.titlesScrollView.contentOffset = CGPointMake(0, self.titlesScrollView.contentOffset.y);
            }
        }
        CGPoint center = self.titleUnderline.center;
        center.x = titleButton.center.x;
        self.titleUnderline.center = center;
        CGFloat wirth = titleButton.frame.size.width;
        CGRect rect = self.titleUnderline.bounds;
        if (self.item.lineIndicator_percent>0&&self.item.lineIndicator_percent<1) {
            rect.size.width = wirth*self.item.lineIndicator_percent;
        }else{
            rect.size.width = wirth;
        }
        self.titleUnderline.bounds = rect;
        
    } completion:^(BOOL finished) {
        if (_isViewControllers==YES && _type == SegmentViewControlIsLazyLoad) {///数值是视图控制器
            __kindof UIViewController *vc = _array[index];
            if(![self.scrollView.subviews containsObject:vc.view]){
                [vc.view makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(index*self.frame.size.width);
                    make.top.bottom.equalTo(self.contentView);
                    make.width.offset(self.frame.size.width);
                }];
                [self.scrollView addSubview:vc.view];
            }
        }
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

- (void)layoutSubviews{
    
    // 布局titlesScrollView
    if (self.item.titlesBarHeight>0) {
//        [self.titlesScrollView makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.equalTo(self);
//            make.height.offset(self.item.titlesBarHeight);
//        }];
        self.titlesScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.item.titlesBarHeight);
    }else{
//        [self.titlesScrollView makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.equalTo(self);
//            make.height.offset(titlesHeight);
//        }];
        self.titlesScrollView.frame = CGRectMake(0, 0, self.frame.size.width, titlesHeight);
    }
    // 布局titlesView
    [self.titlesView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.titlesScrollView).with.insets(UIEdgeInsetsZero);
        make.height.equalTo(self.titlesScrollView);
    }];
    
    [self.seperateLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.titlesView);
        make.height.offset(1);
    }];
    // 计算titlesButton需要占多大的宽度
    __block CGFloat needWith = 0.0;
    [_titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize size;
        if (self.item.titlesFont != nil) {
            size = [CalculateSize sizeForNoticeTitle:obj font:self.item.titlesFont maxW:SCREEN_WIDTH];
        }else{
            size = [CalculateSize sizeForNoticeTitle:obj font:TITLESFONT maxW:SCREEN_WIDTH];
        }
        if (self.item.padding>=0) {
            needWith += size.width+self.item.padding*2;
        }else{
            needWith += size.width+padding*2;
        }
    }];
    if (self.item.margin>=0) {
        needWith += self.item.margin*2;
    }else{
        needWith += margin*2;
    }
    CGFloat realpadding;
    if (needWith < self.frame.size.width) {//不适用设置的内边距
        CGFloat remander = self.frame.size.width - needWith;
        if (self.item.padding>=0) {
            realpadding = remander/(_titles.count*2)+self.item.padding;
        }else{
            realpadding = remander/(_titles.count*2)+padding;
        }
    }else{
        if (self.item.padding>=0) {
            realpadding = self.item.padding;
        }else{
            realpadding = padding;
        }
    }
    __block UIButton *lastButton;
    
    [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // frame
        CGSize size;
        if (self.item.titlesFont) {
            size = [CalculateSize sizeForNoticeTitle:obj.titleLabel.text font:self.item.titlesFont maxW:SCREEN_WIDTH];
        }else{
            size = [CalculateSize sizeForNoticeTitle:obj.titleLabel.text font:TITLESFONT maxW:SCREEN_WIDTH];
        }
        if (idx == 0) {
            ZXXLog(@"size%f",size.width+realpadding*2);
            if (self.item.margin>=0) {
//                [obj remakeConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(self.titlesView).offset(self.item.margin);
//                    make.top.bottom.equalTo(self.titlesView);
//                    make.width.offset(size.width+realpadding*2);
//                }];
                obj.frame = CGRectMake(self.item.margin, 0, size.width+realpadding*2, self.titlesView.frame.size.height);
            }else{
//                [obj remakeConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(self.titlesView).offset(margin);
//                    make.top.bottom.equalTo(self.titlesView);
//                    make.width.offset(size.width+realpadding*2);
//                }];
                obj.frame = CGRectMake(margin, 0, size.width+realpadding*2, self.titlesView.frame.size.height);
            }
            lastButton = obj;
        }else{
//            [obj remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(lastButton.right);
//                make.top.bottom.equalTo(self.titlesView);
//                make.width.offset(size.width+realpadding*2);
//            }];
            obj.frame = CGRectMake(lastButton.frame.origin.x+lastButton.frame.size.width, 0, size.width+realpadding*2, self.titlesView.frame.size.height);
            lastButton = obj;
        }
        ZXXLog(@"%f",lastButton.frame.size.width);
        ZXXLog(@"%f",lastButton.frame.origin.x);
    }];
    if (self.item.margin>=0) {
        [self.titlesView makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastButton.right).offset(self.item.margin);
        }];
    }else{
        [self.titlesView makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastButton.right).offset(margin);
        }];
    }
    
    
    if (self.item.lineIndicator_percent>0&&self.item.lineIndicator_percent<1) {
        [self.titleUnderline remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.titlesView.bottom);
            make.height.offset(2);
            make.centerX.equalTo(self.previousClickedTitleButton);
            make.width.equalTo(self.previousClickedTitleButton.width).multipliedBy(self.item.lineIndicator_percent);
        }];
    }else{
        [self.titleUnderline remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.titlesView.bottom);
            make.height.offset(2);
            make.centerX.equalTo(self.previousClickedTitleButton);
            make.width.equalTo(self.previousClickedTitleButton);
        }];
    }
    ///
//    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titlesView.bottom);
//        make.left.right.equalTo(self);
//        make.bottom.equalTo(self);
//    }];
    self.scrollView.frame = CGRectMake(0, self.titlesScrollView.frame.size.height, self.frame.size.width, self.frame.size.height-self.titlesScrollView.frame.size.height);
    
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.scrollView).with.insets(UIEdgeInsetsZero);
        make.height.equalTo(self.scrollView);
    }];
    __block UIView *lastView;
    if (_isViewControllers == YES) {
        if (_type == SegmentViewControlIsLazyLoad) {
            UIViewController *vc = (UIViewController *)_currentViewOrViewControllor;
            [vc.view makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(self.previousClickedTitleButton.tag*self.frame.size.width);
                make.top.bottom.equalTo(self.contentView);
                make.width.offset(self.frame.size.width);
            }];
            [self.contentView makeConstraints:^(MASConstraintMaker *make) {
                make.width.offset(_array.count*self.frame.size.width);
            }];
        }else{
            [_array enumerateObjectsUsingBlock:^(__kindof UIViewController*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0) {
                    [obj.view makeConstraints:^(MASConstraintMaker *make) {
                        make.left.top.bottom.equalTo(self.contentView);
                        make.width.equalTo(self.scrollView);
                    }];
                    lastView = obj.view;
                    
                }else{
                    [obj.view makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(lastView.right);
                        make.top.bottom.equalTo(self.contentView);
                        make.width.equalTo(self.scrollView);
                    }];
                    lastView = obj.view;
                }
            }];
            [self.contentView makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(lastView.right);
            }];
        }
    }else{
        [_array enumerateObjectsUsingBlock:^(__kindof UIView*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                [obj makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(self.contentView);
                    make.width.equalTo(self.scrollView);
                }];
                lastView = obj;
            }else{
                [obj makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastView.right);
                    make.top.bottom.equalTo(self.contentView);
                    make.width.equalTo(self.scrollView);
                }];
                lastView = obj;
            }
        }];
        [self.contentView makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastView.right);
        }];
    }
    
    //////////////////////////////////////////////////////////////////
    if (_framWirth!=self.frame.size.width) {
        _framWirth = self.frame.size.width;
        CGFloat offsetX = self.frame.size.width * self.previousClickedTitleButton.tag;
        ZXXLog(@"%f",offsetX);
        ZXXLog(@"%f",self.frame.size.width);
        if (self.scrollView.contentOffset.x!=offsetX) {
            self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
        }
        if(self.titlesView.frame.size.width>self.frame.size.width){
            if (self.previousClickedTitleButton.center.x>self.center.x+self.titlesScrollView.contentOffset.x&&self.titlesView.frame.size.width - self.titlesScrollView.contentOffset.x>self.frame.size.width) {
                CGFloat offsetx = self.previousClickedTitleButton.center.x - self.titlesScrollView.contentOffset.x - self.center.x;
                if (offsetx<=self.titlesView.frame.size.width - self.titlesScrollView.contentOffset.x-self.frame.size.width) {
                    self.titlesScrollView.contentOffset = CGPointMake(offsetx+self.titlesScrollView.contentOffset.x, self.titlesScrollView.contentOffset.y);
                }else{
                    self.titlesScrollView.contentOffset = CGPointMake(self.titlesView.frame.size.width-self.frame.size.width, self.titlesScrollView.contentOffset.y);
                }
            }else if(self.previousClickedTitleButton.center.x<self.center.x+self.titlesScrollView.contentOffset.x&&self.titlesScrollView.contentOffset.x!=0){
                CGFloat offsetx = self.titlesScrollView.contentOffset.x + self.center.x - self.previousClickedTitleButton.center.x;
                if (offsetx>self.titlesScrollView.contentOffset.x) {
                    self.titlesScrollView.contentOffset = CGPointMake(0, self.titlesScrollView.contentOffset.y);
                }else{
                    self.titlesScrollView.contentOffset = CGPointMake(self.titlesScrollView.contentOffset.x-offsetx, self.titlesScrollView.contentOffset.y);
                }
            }
        }else{
            if (self.titlesScrollView.contentOffset.x != 0) {
                self.titlesScrollView.contentOffset = CGPointMake(0, self.titlesScrollView.contentOffset.y);
            }
        }
    }
}

@end
