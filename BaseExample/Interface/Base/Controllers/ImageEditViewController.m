//
//  ImageEditViewController.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/6.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ImageEditViewController.h"
#import "ZXXImageCropManager.h"

@interface ImageEditViewController ()<UIScrollViewDelegate>

@property (weak,nonatomic)UIImageView *imgview;
@property(nonatomic, weak)UIView *containerView;
@property(nonatomic, weak)UIScrollView *scrll;
@property(nonatomic, weak)UIView *subview;

@end

@implementation ImageEditViewController

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"" position:QMUINavigationButtonPositionNone target:self handler:^(id sender) {
        // 裁剪区域
        CGRect rect = CGRectMake((self.view.bounds.size.width-self.size->width)/2, (self.view.bounds.size.height-self.size->height)/2, self.size->width, self.size->height);
        UIImage *image = [ZXXImageCropManager cropImageView:self.imgview toRect:rect zoomScale:0.9 containerView:self.subview shouldFixOrientation:YES];
        self.block(image);
        [self pop];
    }];
}
- (void)initSubviews {
    [super initSubviews];
    UIView *containerView = [[UIView alloc]init];
    [self.view addSubview:containerView];
    self.containerView = containerView;
    
    UIScrollView *scrll = [[UIScrollView alloc]init];
    [containerView addSubview:scrll];
    self.scrll = scrll;
    scrll.maximumZoomScale = 2;
    scrll.minimumZoomScale = 0.5;
    scrll.delegate = self;
    scrll.showsHorizontalScrollIndicator = NO;
    scrll.showsVerticalScrollIndicator = NO;
    
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [scrll addSubview:imgview];
    self.imgview = imgview;
    self.imgview.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIView *subview = [[UIView alloc] init];
    subview.userInteractionEnabled = NO;
    [containerView addSubview:subview];
    self.subview = subview;
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.containerView.frame = self.view.bounds;
    self.scrll.frame = self.containerView.bounds;
    self.imgview.frame = self.view.bounds;
    self.subview.frame = self.imgview.bounds;
    
    if (_size != NULL) {
        CGFloat wirth = self.size->width;
        CGFloat height = self.size->height;
        self.scrll.contentInset = UIEdgeInsetsMake((self.view.bounds.size.height-height)/2, (self.view.bounds.size.width-wirth)/2, (self.view.bounds.size.height-height)/2, (self.view.bounds.size.width-wirth)/2);
        self.scrll.contentOffset = CGPointZero;
        
        [ZXXImageCropManager overlayClippingWithView:self.subview cropRect:CGRectMake((self.view.bounds.size.width-wirth)/2, (self.view.bounds.size.height-20-height)/2, wirth, height+20) containerView:self.subview needCircleCrop:NO];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    NSString *picpath = self.receivedData;
    _imgview.image = [UIImage imageWithContentsOfFile:picpath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)viewWillDisappear:(BOOL)animated{
    self.receivedData = nil;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    
    _imgview.center = CGPointMake(scrollView.contentSize.width/2+offsetX,scrollView.contentSize.height/2);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imgview;
}


@end
