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

@interface FrameObj : NSObject

@property(assign,nonatomic)CGRect rect;

@end

@implementation FrameObj

@end

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

@end

@implementation SegmentViewControl{
    NSArray *_array;
    NSArray *_arrayFrame;
    SegmentViewControlIsLazyLoadType _type;
    BOOL _isViewControllers;
    id _currentViewOrViewControllor;
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

+ (instancetype)segmentTitles:(NSArray *_Nonnull)titles withItem:(SegmentViewItem * _Nullable)item withViews:(NSArray * _Nonnull)views withFrame:(CGRect)rect recognizerTableCellEdit:(BOOL)rgCellEdit{
    SegmentViewControl *segmentViewControl = [[self alloc] initWithFrame:rect];
    segmentViewControl.item = item;
    [segmentViewControl setupTitlesViewWithTitles:titles withItem:item];
    
    [segmentViewControl setupScrollViewWithViews:views withItem:item recognizerTableCellEdit:rgCellEdit];
    return segmentViewControl;
}
+ (instancetype)segmentTitles:(NSArray *)titles withItem:(SegmentViewItem *)item withViewControllers:(NSArray *)viewControllers withFrame:(CGRect)rect loadType:(SegmentViewControlIsLazyLoadType)type recognizerTableCellEdit:(BOOL)rgCellEdit{
    SegmentViewControl *segmentViewControl = [[self alloc] initWithFrame:rect];
    segmentViewControl.item = item;
    [segmentViewControl setupTitlesViewWithTitles:titles withItem:item];
    [segmentViewControl setupScrollViewWithViewControllers:viewControllers withItem:item type:type recognizerTableCellEdit:rgCellEdit];
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
    if (item.titlesBarHeight>0) {
        [scrollView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.offset(item.titlesBarHeight);
        }];
    }else{
        [scrollView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.offset(titlesHeight);
        }];
    }
    UIView *titlesView = [[UIView alloc] init];
    [scrollView addSubview:titlesView];
    [titlesView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(scrollView).with.insets(UIEdgeInsetsZero);
        make.height.equalTo(scrollView);
    }];
    titlesView.backgroundColor = [UIColor whiteColor];
    self.titlesView = titlesView;
    // 标题栏按钮
    [self setupTitlesButtonsInView:titlesView withTitles:titles withItem:item];
    UIView *seperateLine = [[UIView alloc] init];
    [titlesView addSubview:seperateLine];
    seperateLine.backgroundColor = SEPERATELINECOLOR;
    [seperateLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titlesView);
        make.bottom.equalTo(titlesView.bottom);
        make.width.equalTo(titlesView);
        make.height.offset(1);
    }];
    // 标题下划线
    [self setupTitleUnderlineOnView:titlesView withItem:item];
}
/**
 *  标题栏按钮
 */
- (void)setupTitlesButtonsInView:(UIView *)view withTitles:(NSArray *)titles withItem:(SegmentViewItem *)item
{
    // 计算titlesButton需要占多大的宽度
    __block CGFloat needWith = 0.0;
    [titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize size;
        if (item.titlesFont != nil) {
            size = [CalculateSize sizeForNoticeTitle:obj font:item.titlesFont maxW:SCREEN_WIDTH];
        }else{
            size = [CalculateSize sizeForNoticeTitle:obj font:TITLESFONT maxW:SCREEN_WIDTH];
        }
        if (item.padding>=0) {
            needWith += size.width+item.padding*2;
        }else{
            needWith += size.width+padding*2;
        }
    }];
    if (item.margin>=0) {
        needWith += item.margin*2;
    }else{
        needWith += margin*2;
    }
    
    CGFloat realpadding;
    if (needWith <SCREEN_WIDTH) {//不适用设置的内边距
        CGFloat remander = SCREEN_WIDTH - needWith;
        if (item.padding>=0) {
            realpadding = remander/(titles.count*2)+item.padding;
        }else{
            realpadding = remander/(titles.count*2)+padding;
        }
    }else{
        if (item.padding>=0) {
            realpadding = item.padding;
        }else{
            realpadding = padding;
        }
    }
    
    // 标题文字
    NSUInteger count = titles.count;
    UIButton *lastButton;
    // 创建标题按钮
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
        // frame
        CGSize size;
        if (item.titlesFont) {
            size = [CalculateSize sizeForNoticeTitle:titles[i] font:item.titlesFont maxW:SCREEN_WIDTH];
        }else{
            size = [CalculateSize sizeForNoticeTitle:titles[i] font:TITLESFONT maxW:SCREEN_WIDTH];
        }
        if (i == 0) {
            if (item.margin>=0) {
                if (item.titlesBarHeight>0) {
                    [titleButton makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(view).offset(item.margin);
                        make.top.equalTo(view);
                        make.size.sizeOffset(CGSizeMake(size.width+realpadding*2, item.titlesBarHeight));
                    }];
                }else{
                    [titleButton makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(view).offset(item.margin);
                        make.top.equalTo(view);
                        make.size.sizeOffset(CGSizeMake(size.width+realpadding*2, titlesHeight));
                    }];
                }
            }else{
                if (item.titlesBarHeight>0) {
                    [titleButton makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(view).offset(margin);
                        make.top.equalTo(view);
                        make.size.sizeOffset(CGSizeMake(size.width+realpadding*2, item.titlesBarHeight));
                    }];
                }else{
                    [titleButton makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(view).offset(margin);
                        make.top.equalTo(view);
                        make.size.sizeOffset(CGSizeMake(size.width+realpadding*2, titlesHeight));
                    }];
                }
            }
            lastButton = titleButton;
        }else{
            if (item.titlesBarHeight>0) {
                [titleButton makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastButton.right);
                    make.top.equalTo(view);
                    make.size.sizeOffset(CGSizeMake(size.width+realpadding*2, item.titlesBarHeight));
                }];
            }else{
                [titleButton makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastButton.right);
                    make.top.equalTo(view);
                    make.size.sizeOffset(CGSizeMake(size.width+realpadding*2, titlesHeight));
                }];
            }
            lastButton = titleButton;
        }
    }
    if (item.margin>=0) {
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastButton.right).offset(item.margin);
        }];
    }else{
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastButton.right).offset(margin);
        }];
    }
}
/**
 *  标题下划线
 */
- (void)setupTitleUnderlineOnView:(UIView *)view withItem:(SegmentViewItem *)item
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
    if (item.lineIndicator_percent>0&&item.lineIndicator_percent<1) {
        [titleUnderline makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view.bottom);
            make.height.offset(2);
            make.centerX.equalTo(firstTitleButton);
            make.width.equalTo(firstTitleButton.width).multipliedBy(item.lineIndicator_percent);
        }];
    }else{
        [titleUnderline makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view.bottom);
            make.height.offset(2);
            make.centerX.equalTo(firstTitleButton);
            make.width.equalTo(firstTitleButton);
        }];
    }
}

/**
 *  scrollView 创建子视图
 */
- (void)setupScrollViewWithViews:(NSArray *)views withItem:(SegmentViewItem *)item recognizerTableCellEdit:(BOOL)rgCellEdit
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
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlesView.bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    self.scrollView = scrollView;
    // 如果没有设置默认为这个尺寸
    CGRect rect = self.bounds;
    CGFloat realHeight;
    if (item.titlesBarHeight>0) {
        scrollView.contentSize = CGSizeMake(views.count*rect.size.width, rect.size.height-item.titlesBarHeight);
        realHeight = rect.size.height-item.titlesBarHeight;
    }else{
        scrollView.contentSize = CGSizeMake(views.count*rect.size.width, rect.size.height-titlesHeight);
        realHeight = rect.size.height-titlesHeight;
    }
    // 创建zi视图
    NSMutableArray *arrayM = [NSMutableArray array];
    [views enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class=NSClassFromString(obj);
        id view=[[class alloc] initWithFrame:CGRectMake(idx*rect.size.width, 0, rect.size.width, realHeight)];
        [scrollView addSubview:view];
        [arrayM addObject:view];
        if (idx == 0) {
            _currentViewOrViewControllor = view;
        }
    }];
    _array = arrayM;
}
/**
 *  scrollView 创建子控制器
 */
- (void)setupScrollViewWithViewControllers:(NSArray *)viewControllers withItem:(SegmentViewItem *)item type:(SegmentViewControlIsLazyLoadType)type recognizerTableCellEdit:(BOOL)rgCellEdit
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
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlesScrollView.bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    self.scrollView = scrollView;
    // 如果没有设置默认为这个尺寸
    CGRect rect = self.bounds;
    CGFloat realHeight;
    if (item.titlesBarHeight>0) {
        scrollView.contentSize = CGSizeMake(viewControllers.count*rect.size.width, rect.size.height-item.titlesBarHeight);
        realHeight = rect.size.height-item.titlesBarHeight;
    }else{
        scrollView.contentSize = CGSizeMake(viewControllers.count*rect.size.width, rect.size.height-titlesHeight);
        realHeight = rect.size.height-titlesHeight;
    }
    // 创建zi视图控制器
    NSMutableArray *arrayM = [NSMutableArray array];
    NSMutableArray *arrayMFrame = [NSMutableArray array];
    [viewControllers enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class=NSClassFromString(obj);
        __kindof UIViewController *controller=[[class alloc] init];
        FrameObj *framObj = [[FrameObj alloc] init];
        CGRect rct = CGRectMake(idx*rect.size.width, 0, rect.size.width, realHeight);
        framObj.rect = rct;
        [arrayMFrame addObject:framObj];
        if (idx==0) {
            controller.view.frame = rct;
            [scrollView addSubview:controller.view];
            
            _currentViewOrViewControllor = controller;
        }else{
            if (type == SegmentViewControlNotLazyLoad) {
                controller.view.frame = rct;
                [scrollView addSubview:controller.view];
            }
        }
        [arrayM addObject:controller];
    }];
    _arrayFrame = arrayMFrame;
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
                FrameObj *framObj = _arrayFrame[index];
                vc.view.frame = framObj.rect;
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
    
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    NSUInteger index = titleButton.tag;
    _currentViewOrViewControllor = _array[index];
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
                FrameObj *framObj = _arrayFrame[index];
                vc.view.frame = framObj.rect;
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

@end
