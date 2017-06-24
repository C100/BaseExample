//
//  BaseViewController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseViewController.h"
#import "TabBarController.h"
#import <objc/message.h>
@interface BaseViewController ()<YTKRequestDelegate,YTKChainRequestDelegate>

@property (copy,nonatomic,nullable)RequestBlock successBlock;

@property (copy,nonatomic,nullable)RequestBlock failureBlock;

@property (copy,nonatomic,nullable)BatchBlock chainArrayBlock;

@property (copy,nonatomic,nullable)BatchBlock chainFailedArrayBlock;

@property (copy,nonatomic,nullable)RequestBlock chainFailedBlck;

@end

@implementation BaseViewController{
    UIView *_baseView;
}

+ (void)load{
    Method a = class_getInstanceMethod(self, @selector(loadView));
    Method b = class_getInstanceMethod(self, @selector(loadCustomView));
    method_exchangeImplementations(a, b);
}
- (void)loadView{
    [super loadView];
}
- (UIView *)baseView{
    if (_baseView == nil) {
        _baseView = [[BaseView alloc] init];
    }
    return _baseView;
}
- (void)loadCustomView{
    self.view = self.baseView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //友盟页面分析
    [UMAnalytics beginLogViewController:NSStringFromClass(self.class)];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //友盟页面分析
    [UMAnalytics endLogViewController:NSStringFromClass(self.class)];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*设置状态栏颜色*/
- (UIStatusBarStyle)preferredStatusBarStyle{
    //黑色
    //return UIStatusBarStyleDefault;
    //白色
    return UIStatusBarStyleLightContent;
}

#pragma mark —— push下一个页面
/*不传数据，直接push到下一个界面*/
-(void)push:(NSString*)controllerName{
    Class class=NSClassFromString(controllerName);
    id controller=[[class alloc] init];
    [self.navigationController pushViewController:controller animated:true];
}

/*传数据到下一个界面*/
-(void)pushWithData:(NSString*)controllerName Data:(NSDictionary*)dict{
    Class class=NSClassFromString(controllerName);
    id controller=[[class alloc] init];
    ((BaseViewController*)controller).receivedDictionary=dict;
    [self.navigationController pushViewController:controller animated:true];
}

#pragma mark —— 返回事件
/*关闭界面，返回上一级*/
-(void)pop{
    if (self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*返回到固定界面*/
-(void)popToController:(NSString*)controllerName{
    Class class=NSClassFromString(controllerName);
    id controller=[[class alloc] init];
    NSArray *temArray = self.navigationController.viewControllers;
    for(UIViewController *temVC in temArray)
    {
        if ([temVC isKindOfClass:[controller class]])
        {
            [self.navigationController popToViewController:temVC animated:YES];
        }
    }
}

/*返回到主界面*/
-(void)popToRoot{
    [self.navigationController popToRootViewControllerAnimated:true];
}

#pragma mark —— MBProgressHUB
/*toast*/
-(void)showToast:(NSString*)text{
    MBProgressHUD *hub=[MBProgressHUD showHUDAddedTo:self.view animated:true];
    hub.mode=MBProgressHUDModeText;
    hub.margin=10.f;
    hub.removeFromSuperViewOnHide=true;
    hub.labelText=text;
    [hub hide:true afterDelay:1.5];
}

/*显示菊花图*/
-(void)showWaitView{
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
}

/*隐藏菊花图*/
-(void)hideWaitView{
    [MBProgressHUD hideHUDForView:self.view animated:true];
}

#pragma mark —— 网络请求
#pragma mark - 基本的网络请求处理
- (void)startWithApi:(__kindof BaseRequestApi *)api completionBlockWithSuccess:(RequestBlock)successBlock failure:(RequestBlock)failureBlock {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (successBlock!=nil) {
            successBlock(request);
        }
        
        [self pritfReturnCodeStatus:request];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failureBlock!=nil) {
            failureBlock(request);
        }
        [self pritfReturnCodeStatus:request];
    }];
}

- (void)starApi:(__kindof BaseRequestApi *)api requestFinished:(RequestBlock)successBlock requestFailed:(RequestBlock)failureBlock{
    [api start];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.successBlock = successBlock;
    
    self.failureBlock = failureBlock;
    
    api.delegate = self;
}

- (void)requestFinished:(__kindof BaseRequestApi *)request {
    if (self.successBlock!=nil) {
        self.successBlock(request);
    }
    [self pritfReturnCodeStatus:request];
}
- (void)requestFailed:(__kindof BaseRequestApi *)request {
    if (self.failureBlock!=nil) {
        self.failureBlock(request);
    }
    [self pritfReturnCodeStatus:request];
}
#pragma mark - 批量网络请求处理
- (void)batchRequestWithRequestArray:(NSArray <BaseRequestApi *> *)apiArray startWithCompletionBlockWithSuccess:(BatchBlock)successBlock failure:(BatchBlock)failureBlock failedRequest:(RequestBlock)failedRequestBlock{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:apiArray];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        if (successBlock!=nil) {
            successBlock(requests);
        }
        BaseRequestApi * lastRequest = requests.lastObject;
        [self pritfReturnCodeStatus:lastRequest];
    } failure:^(YTKBatchRequest *batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        if (failureBlock!=nil) {
            failureBlock(requests);
        }
        __kindof YTKRequest *failedRq = batchRequest.failedRequest;
        if (failedRequestBlock!=nil) {
            failedRequestBlock(failedRq);
        }
        [self pritfReturnCodeStatus:failedRq];
    }];
}


#pragma mark - 相互依赖的网络请求
- (void)chainRequestWithBaseRequset:(BaseRequestApi *)baseApi successThenSecondRequest:(ChainBlock_returnApi)blockthenSecondApi requestFinished:(RequestBlock)blockSecond{
    YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [chainReq addRequest:baseApi callback:^(YTKChainRequest * _Nonnull chainRequest,__kindof YTKBaseRequest * _Nonnull baseRequest) {
        hud.labelText = @"初级请求成功";
        @WeakObj(self);
        __kindof BaseRequestApi *secondReq = blockthenSecondApi(baseRequest);
        if(secondReq!=nil){
            
            [chainRequest addRequest:secondReq callback:^(YTKChainRequest * _Nonnull chainRequest,__kindof YTKBaseRequest * _Nonnull baseRequest) {
                @StrongObj(self);
                if (blockSecond!=nil) {
                    blockSecond(baseRequest);
                }
                [self pritfReturnCodeStatus:baseRequest];
            }];
        }else{
            [self pritfReturnCodeStatus:baseRequest];
        }
        
    }];
    [chainReq start];
}

- (void)chainRequestWithBaseRequset:(__kindof BaseRequestApi *)baseApi successThenRequestArray:(ChainBlock_returnArrayApi)blockthenApiArray chainRequestFinished:(BatchBlock)blockArray failed:(BatchBlock)failedblockArray failedBaseRequest:(RequestBlock)failedblock{
    
    YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [chainReq addRequest:baseApi callback:^(YTKChainRequest * _Nonnull chainRequest,__kindof YTKBaseRequest * _Nonnull baseRequest) {
        hud.labelText = @"初级请求成功";
        NSArray <__kindof BaseRequestApi *> *arrRequest = blockthenApiArray(baseRequest);
        if (arrRequest!=nil) {
            [arrRequest enumerateObjectsUsingBlock:^(__kindof BaseRequestApi * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [chainRequest addRequest:obj callback:nil];
            }];
            self.chainArrayBlock = blockArray;
            self.chainFailedArrayBlock = failedblockArray;
            self.chainFailedBlck = failedblock;
        }
    }];
    chainReq.delegate = self;
    [chainReq start];
}

- (void)chainRequestFinished:(YTKChainRequest *)chainRequest {
    NSMutableArray *arrayM = [NSMutableArray array];
    [chainRequest.requestArray enumerateObjectsUsingBlock:^(__kindof YTKBaseRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            [arrayM addObject:obj];
        }
    }];
    __kindof YTKBaseRequest *lastApi = chainRequest.requestArray.lastObject;
    if (self.chainArrayBlock!=nil) {
        self.chainArrayBlock(arrayM);
    }
    [self pritfReturnCodeStatus:lastApi];
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(__kindof YTKBaseRequest*)request {
    NSMutableArray *arrayM = [NSMutableArray array];
    [chainRequest.requestArray enumerateObjectsUsingBlock:^(YTKBaseRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            [arrayM addObject:obj];
        }
    }];
    if (self.chainFailedArrayBlock!=nil) {
        self.chainFailedArrayBlock(arrayM);
    }
    if (self.chainFailedBlck!=nil) {
        self.chainFailedBlck(request);
    }
    [self pritfReturnCodeStatus:request];
    // some one of request is failed
}

#pragma 显示上次缓存的内容
- (void)loadCacheDataWith:(BaseRequestApi *)api dataWithCache:(RequestBlock)cacheBlock success:(RequestBlock)successBlock failure:(RequestBlock)failureBlock{
    if ([api loadCacheWithError:nil]) {
        if (cacheBlock!=nil) {
            cacheBlock(api);
        }
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if (successBlock!=nil) {
            successBlock(request);
        }
        [self pritfReturnCodeStatus:request];
    } failure:^(__kindof YTKBaseRequest *request) {
        if (failureBlock!=nil) {
            failureBlock(request);
        }
        [self pritfReturnCodeStatus:request];
    }];
}

#pragma mark - 打印回调状态
- (void)pritfReturnCodeStatus:(__kindof YTKRequest *)request{
    NSDictionary *returnValue_Dict = request.responseObject;
    NSString *code = [NSString stringWithFormat:@"%@",returnValue_Dict[@"code"]];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ErrorInfo" ofType:@"plist"];
    NSDictionary *error_dit = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    [self showErrorInfoOnKeyWindowHudWithString:error_dit[code]];
}
- (void)showErrorInfoOnKeyWindowHudWithString:(NSString *)errorStr{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    hud.labelText = errorStr;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    ZXXLog(@"%@",errorStr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if ([self.navigationController.topViewController isMemberOfClass:[TabBarController class]]) {
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabBarHeight);
    }
}

@end
