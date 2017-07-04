//
//  UploadFileApi.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/18.
//  Copyright © 2017年 james. All rights reserved.
//

#import "UploadFileApi.h"

@implementation UploadFileApi
-(id)initWithFile:(NSData *)data Name:(NSString *)name FileName:(NSString *)fileName FileType:(NSString*)fileType{
    self=[super init];
    if (self) {
        _fileData=data;
        _name=name;
        _fileName=fileName;
        _fileType=fileType;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"/iphone/image/upload";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:_fileData name:_name fileName:_fileName mimeType:_fileType];
    };
}

- (id)jsonValidator {
    return @{ @"imageId": [NSString class] };
}

- (NSString *)responseImageId {
    NSDictionary *dict = self.responseJSONObject;
    return dict[@"imageId"];
}

@end
