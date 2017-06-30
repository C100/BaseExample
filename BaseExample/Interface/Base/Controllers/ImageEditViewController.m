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
//@property(strong,nonatomic)TopBarView* topbarview;
@property (weak,nonatomic)UIImageView *imgview;
@end

@implementation ImageEditViewController
- (instancetype)initWithSize:(CGSize)size{
    if (self = [super init]) {
        
        
//        _topbarview = [[TopBarView alloc] init];
//        [self.view addSubview:_topbarview];
//        _topbarview.rightLabel.text = @"完成";
//        _topbarview.leftImageView.image = [UIImage imageNamed:@"back icon"];
        UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [self.view addSubview:containerView];
        UIScrollView *scrll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [containerView addSubview:scrll];
        scrll.maximumZoomScale = 2;
        scrll.minimumZoomScale = 0.5;
        scrll.delegate = self;
        scrll.showsHorizontalScrollIndicator = NO;
        scrll.showsVerticalScrollIndicator = NO;
        
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [scrll addSubview:imgview];
        _imgview = imgview;
        _imgview.contentMode = UIViewContentModeScaleAspectFit;
        
        
        UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        subview.userInteractionEnabled = NO;
        [containerView addSubview:subview];
        CGFloat wirth = size.width;
        CGFloat height = size.height;
        scrll.contentInset = UIEdgeInsetsMake((SCREEN_HEIGHT-64-height)/2, (SCREEN_WIDTH-wirth)/2, (SCREEN_HEIGHT-64-height)/2, (SCREEN_WIDTH-wirth)/2);
        scrll.contentOffset = CGPointZero;
        // 裁剪区域
        CGRect rect = CGRectMake((SCREEN_WIDTH-wirth)/2, (SCREEN_HEIGHT-64-height)/2, wirth, height);
        [ZXXImageCropManager overlayClippingWithView:subview cropRect:CGRectMake((SCREEN_WIDTH-wirth)/2, (SCREEN_HEIGHT-84-height)/2, wirth, height+20) containerView:subview needCircleCrop:NO];
//        @WeakObj(self,imgview);
//        [_topbarview rightViewClick:^(UIView *view) {
//            @StrongObj(self,imgview);
//            
//            UIImage *image = [ZXXImageCropManager cropImageView:imgview toRect:rect zoomScale:0.9 containerView:subview shouldFixOrientation:YES];
//            self.block(image);
//            [self pop];
//        }];
//        [_topbarview leftViewClick:^(UIView *view) {
//            @StrongObj(self);
//            [self pop];
//        }];
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    NSString *picpath = self.receivedDictionary[@"pictureUrl"];
    _imgview.image = [UIImage imageWithContentsOfFile:picpath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)viewWillDisappear:(BOOL)animated{
    self.receivedDictionary = nil;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    
    _imgview.center = CGPointMake(scrollView.contentSize.width/2+offsetX,scrollView.contentSize.height/2);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imgview;
}


@end
