//
//  YTKUrlArgumentsFilter.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/4/18.
//  Copyright © 2017年 james. All rights reserved.
//


#import "YTKUrlArgumentsFilter.h"
#import "AFURLRequestSerialization.h"

@implementation YTKUrlArgumentsFilter {
    NSDictionary *_arguments;
}

+ (YTKUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments {
    return [[self alloc] initWithArguments:arguments];
}

- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    if ([request.requestUrl isEqualToString:@"/login/api"]) {
        NSString *urlstr = [BASE_URL stringByAppendingString:@":8080"];
        return [self urlStringWithOriginUrlString:[urlstr stringByAppendingString:request.requestUrl] appendParameters:_arguments];
    }else{
        NSString *urlstr = [BASE_URL stringByAppendingString:@":8082"];
        return [self urlStringWithOriginUrlString:[urlstr stringByAppendingString:request.requestUrl] appendParameters:_arguments];
    }
}

- (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    NSString *paraUrlString = AFQueryStringFromParameters(parameters);
    
    if (!(paraUrlString.length > 0)) {
        return originUrlString;
    }
    
    NSURLComponents *components = [NSURLComponents componentsWithString:originUrlString];
    
    NSString *queryString = components.query ?: @"";
    NSString *newQueryString = [queryString stringByAppendingFormat:queryString.length > 0 ? @"&%@" : @"%@", paraUrlString];
    
    components.query = newQueryString;
    
    return components.URL.absoluteString;
    
}
@end
