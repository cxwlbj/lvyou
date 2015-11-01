//
//  DataService.h
//  Project_weibo
//
//  Created by imac on 15/9/14.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//请求成功的Block
typedef void(^FinishBlock)(AFHTTPRequestOperation *operation, id result);
//请求失败的Block
typedef void(^FailuerBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface DataService : NSObject

+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params httpMethod:(NSString *)httpMethod finishBlock:(FinishBlock)finish failuerBlock:(FailuerBlock)failuer;



#pragma mark 解析plist获取数组
/**
 *  1.1解析plist文件获取数据，返回id
 *  @param fileName plist文件的文件名
 *  @return 数组
 */
+ (NSArray *)getArrayFromPlistData:(NSString *)fileName;


/**
 * 1.2 解析plist文件数据,返回数组
 *  @param fileName plist文件的文件名
 *  @return 字典
 */
+ (NSDictionary *)getDictionaryFromPlistData:(NSString *)fileName;





#pragma mark 本地解析json数据
/**
 *  2.1解析本地Json文件，返回id
 *  @param fileName 本地json文件的文件名
 *  @return id类型字典或者数组
 */
+ (id)getJsonData:(NSString *)fileName;

/**
 *  2.2解析本地json数据,返回数组
 *  @param fileName jion文件名
 *  @return  数组
 */
+ (NSArray *)getArrayFromJsonData:(NSString *)fileName;


/**
 *  2.3解析本地json数据，返回字典
 *  @param fileName jion文件名
 *  @return  字典
 */
+ (NSDictionary *)getDictionaryFromJsonData:(NSString *)fileName;

@end
