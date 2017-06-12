//
//  UploadFileApi.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/18.
//  Copyright © 2017年 james. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import <AFNetworking.h>
@interface UploadFileApi : YTKRequest
@property (nonatomic) NSData *fileData;
@property (nonatomic) NSString *fileName;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *fileType;

-(id)initWithFile:(NSData *)data Name:(NSString *)name FileName:(NSString *)fileName FileType:(NSString*)fileType;

@end
