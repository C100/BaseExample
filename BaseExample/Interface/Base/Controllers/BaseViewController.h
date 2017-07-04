//
//  BaseViewController.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UMAnalytics.h"

#import "BaseRequestApi.h"

/**
 基本请求回调
 
 @param request 得到请求结果的请求对象
 */
typedef void(^RequestBlock)(BaseRequestApi * _Nonnull request);

/**
 批量请求回调
 
 @param requestArray 得到请求结果的请求对象数组
 */
typedef void(^BatchBlock)(NSArray<__kindof BaseRequestApi *> * _Nonnull requestArray);

/**
 依赖的网络请求结果回调
 
 @param baseRequest 最基本的请求结果的请求对象
 @return 依赖API
 */
typedef __kindof BaseRequestApi *_Nullable(^ChainBlock_returnApi)(__kindof BaseRequestApi * _Nullable baseRequest);

/**
 依赖的网络请求结果回调
 
 @param baseRequest 最基本的请求结果的请求对象
 @return 请求数组
 */
typedef NSArray<__kindof BaseRequestApi *> *_Nullable(^ChainBlock_returnArrayApi)(__kindof BaseRequestApi * _Nullable baseRequest);



@interface BaseViewController : QMUICommonViewController <QMUINavigationTitleViewDelegate>
///接受上一个界面传过来的数据
@property (strong,nonatomic,nullable) NSDictionary *receivedDictionary;

- (__kindof UIView*_Nonnull)baseView;

/**不传数据，直接push到下一个界面*/
-(void)push:(NSString*_Nonnull)controllerName;

/**传数据到下一个界面*/
-(void)pushWithData:(NSString*_Nonnull)controllerName Data:(NSDictionary*_Nonnull)dict;

/**关闭界面，返回上一级*/
-(void)pop;

/**返回到固定界面*/
-(void)popToController:(NSString*_Nonnull)controllerName;

/**返回到主界面*/
-(void)popToRoot;


////////////////////////////////////////////////////////////////////////////

/**
 最简单的API请求调用
 
 @param api 传递的API
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)startWithApi:(__kindof BaseRequestApi * _Nonnull)api completionBlockWithSuccess:(RequestBlock _Nullable )successBlock  failure:(RequestBlock _Nullable )failureBlock;
/**
 通过代理方法来调用API
 
 @param api api
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)starApi:(__kindof BaseRequestApi *_Nonnull)api requestFinished:(RequestBlock _Nullable )successBlock requestFailed:(RequestBlock _Nullable )failureBlock;

///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

/**
 批量的请求
 
 @param apiArray api数组
 @param successBlock 全部成功回调
 @param failureBlock 有失败回调
 @param failedRequestBlock 返回失败的API
 */
- (void)batchRequestWithRequestArray:(NSArray <BaseRequestApi *> *_Nonnull)apiArray startWithCompletionBlockWithSuccess:(BatchBlock _Nullable )successBlock failure:(BatchBlock _Nullable )failureBlock failedRequest:(RequestBlock _Nullable )failedRequestBlock;

///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

/**
 相互依赖的网络请求
 
 @param baseApi 基本API
 @param blockthenSecondApi 基本API成功回调，并且传入一个新的API
 @param blockSecond 新的API请求回调
 */
- (void)chainRequestWithBaseRequset:(BaseRequestApi *_Nonnull)baseApi successThenSecondRequest:(ChainBlock_returnApi _Nullable )blockthenSecondApi requestFinished:(RequestBlock _Nullable )blockSecond;
/**
 相互依赖的网络请求
 
 @param baseApi 基本API
 @param blockthenApiArray 基本API成功回调，并且传入一组新的API
 @param blockArray 返回新的API数组
 @param failedblockArray 失败时返回新的API数组
 @param failedblock 返回失败的API
 */
- (void)chainRequestWithBaseRequset:(__kindof BaseRequestApi *_Nonnull)baseApi successThenRequestArray:(ChainBlock_returnArrayApi _Nullable )blockthenApiArray chainRequestFinished:(BatchBlock _Nullable )blockArray failed:(BatchBlock _Nullable )failedblockArray failedBaseRequest:(RequestBlock _Nullable )failedblock;

/**
 显示上次缓存的内容
 
 @param api api
 @param cacheBlock 显示上次缓存的内容
 @param successBlock 请求成功，刷新
 @param failureBlock 请求失败
 */
- (void)loadCacheDataWith:(BaseRequestApi * _Nonnull)api dataWithCache:(RequestBlock _Nullable )cacheBlock success:(RequestBlock _Nullable )successBlock failure:(RequestBlock _Nullable )failureBlock;


@end
