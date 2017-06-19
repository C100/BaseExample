//
//  ApiReqestManager.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/15.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ApiReqestManager.h"
#import <MBProgressHUD.h>
@interface ApiReqestManager()<YTKRequestDelegate,YTKChainRequestDelegate>

@property (copy,nonatomic,nullable)RequestBlock successBlock;

@property (copy,nonatomic,nullable)RequestBlock failureBlock;

@property (copy,nonatomic,nullable)BatchBlock chainArrayBlock;

@property (copy,nonatomic,nullable)BatchBlock chainFailedArrayBlock;

@property (copy,nonatomic,nullable)RequestBlock chainFailedBlck;

@end

@implementation ApiReqestManager

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}

+ (instancetype)sharedManager
{
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}
+ (instancetype)FirstManager{
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [self sharedManager];
        }
        ApiReqestManager *mg = (ApiReqestManager *)_instance;
        mg.isFirst = YES;
    }
    return _instance;
}

#pragma mark - 基本的网络请求处理
- (void)startWithApi:(__kindof BaseRequestApi *)api completionBlockWithSuccess:(RequestBlock)successBlock failure:(RequestBlock)failureBlock {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    
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
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
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
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:apiArray];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        [MBProgressHUD hideHUDForView:keyWindow animated:YES];
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
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
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
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
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
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
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
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD HUDForView:keyWindow];
    hud.labelText = errorStr;
    
    if (self.isFirst==YES) {
        [MBProgressHUD showHUDAddedTo:keyWindow animated:YES].labelText = errorStr;
        self.isFirst = NO;
    }
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [MBProgressHUD hideHUDForView:keyWindow animated:YES];
    });
    ZXXLog(@"%@",errorStr);
}
- (void)setIsFirst:(BOOL)isFirst{
    _isFirst = isFirst;
}
@end
