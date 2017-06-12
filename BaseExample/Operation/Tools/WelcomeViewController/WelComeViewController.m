//
//  WelComeViewController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/24.
//  Copyright © 2017年 james. All rights reserved.
//

#import "WelComeViewController.h"

@interface WelComeViewController ()
@property (nonatomic) UIScrollView *scrollView;
@end

@implementation WelComeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR_BACKGROUND;
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.contentSize=CGSizeMake(WELCOME_IMAGECOUNT*SCREEN_WIDTH, SCREEN_HEIGHT);
    _scrollView.pagingEnabled=true;
    _scrollView.showsHorizontalScrollIndicator=false;
    [self.view addSubview:_scrollView];
    //添加图片
    for (int i=0; i<WELCOME_IMAGECOUNT; i++) {
        UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIImage *image=[UIImage imageNamed:WELCOME_IMAGE(i)];
        imageview.image=image;
        [_scrollView addSubview:imageview];
        if (i==WELCOME_IMAGECOUNT-1) {
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lastTap:)];
            imageview.userInteractionEnabled=true;
            [imageview addGestureRecognizer:tap];
        }
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(void)lastTap:(id)sender{
    _block(sender);
}

-(void)lastImageClick:(lastImageClickBlock)block{
    _block=block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
