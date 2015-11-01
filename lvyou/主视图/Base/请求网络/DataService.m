//
//  DataService.m
//  Project_weibo
//
//  Created by imac on 15/9/14.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DataService.h"

@implementation DataService

//请求网络数据的方法
+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params httpMethod:(NSString *)httpMethod finishBlock:(FinishBlock)finish failuerBlock:(FailuerBlock)failuer{
    
    //判断参数是否为空
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
    //拼接字符串
    NSString *urlStr = [Main_URL stringByAppendingString:url];
    
//    //取到本地的access_token
//    NSDictionary *sinaWeiboData = [[NSUserDefaults standardUserDefaults] objectForKey:KSinaWeiboAuthData];
//    NSString *accessToken = [sinaWeiboData objectForKey:KAccessTokenKey];
//    if (accessToken.length == 0) {
//        //本地没有找到access_token
//        NSLog(@"本地access_token为空");
//        return nil;
//    }
//    
//    //将acess_token添加到请求参数里
//    [params setObject:accessToken forKey:@"access_token"];
    //构建一个operation
    AFHTTPRequestOperation *operation = nil;
    //构建manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //请求方法
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //判断是GET请求还是POST请求
    if ([httpMethod isEqualToString:@"GET"]) {
        //get请求
        operation = [manager GET:urlStr
                      parameters:params
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             if (finish) {
                                 //请求网络成功
                                 NSLog(@"GET请求成功");
                                 finish(operation, responseObject);
                             }
        }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             if (failuer) {
                                 //请求网络失败
                                 NSLog(@"GET请求失败");
                                 failuer(operation, error);
                             }
        }];
    }else if ([httpMethod isEqualToString:@"POST"]){
    
        //判断有没有带文件
        BOOL isfile = NO;
        NSMutableData *data = [NSMutableData data];
        NSString *key = nil;
        id value = nil;
        for (key in params) {
            value = [params objectForKey:key];
            if ([value isKindOfClass:[NSData class]]) {
                isfile = YES;
                [data appendData:value];
                break;
            }
        }
        if (isfile) {
            //带文件
            operation = [manager POST:urlStr
                           parameters:params
            constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                for (NSString *key in params) {
                    id value = [params objectForKey:key];
                    if ([value isKindOfClass:[NSData class]]) {
                        [formData appendPartWithFileData:value
                                                    name:key
                                                fileName:key mimeType:@"image/jpeg"];
                    }
                }
            }
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  if (finish) {
                                      //请求成功
                                      NSLog(@"POST带图片请求成功");
                                      finish(operation, responseObject);
                                  }
            }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  if (failuer) {
                                      //请求失败
                                      NSLog(@"POST带图片请求失败");
                                      failuer(operation, error);
                                  }
            }];
        }else{
            //不带图片
            operation = [manager POST:urlStr
                           parameters:params
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  if (finish) {
                                      //请求成功
                                      NSLog(@"POST不带图片请求成功");
                                      finish(operation, responseObject);
                                  }
            }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  if (failuer) {
                                      //请求失败
                                      NSLog(@"POST不带图片请求失败");
                                      failuer(operation, error);
                                  }
            }];
        }
    }
    
    //设置解析方式
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    return operation;
}


# pragma mark 1.从plist中获取数据
/**
 *  1.1从plist文件中获取数组
 *  @param fileName 传入一个字符串：文件名
 *  @return 将返回数据解析为数组
 */
+ (NSArray *)getArrayFromPlistData:(NSString *)fileName{
    //第一种方法获取路径
    //根据plist文件名，获取文件路径
    NSString *filePath =[[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    //从文件中取出数组
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:filePath];
    if (dataArr == nil ) {
        return  nil;
    }
    return dataArr;
}


/**
 *   1.2从plist中获取字典
 *  @param fileName 传入一个字符串：文件名
 *  @return 将返回数据解析为字典
 */
+ (NSDictionary *)getDictionaryFromPlistData:(NSString *)fileName{
    //第二种方法获取路径
    //得到的文件路径：文件路径= bundle路径+文件名路径
    NSString *sourcePath = [[NSBundle mainBundle] resourcePath];
    //这里用到了字符串的拼接
    NSString *file = [NSString stringWithFormat:@"%@.plist",fileName];
    NSString *filePath = [sourcePath stringByAppendingPathComponent:file];
    
    //获取字典
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (dic == nil) {
        return  nil;
    }
    return dic;
}



/********************2.json文件的操作************/
#pragma mark 2.从本地json中获取数据
/**
 *  2.1根据文件名，从本地的json文件中获取数据
 *  @param fileName 本地json文件名
 *  @return ：id类型（数组或者字典）
 */
+ (id)getJsonData:(NSString *)fileName{
    //1.获取json文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".json"];
    //2.通过路径获取data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //3.设置错误对像
    NSError *error = nil;
    //4.解析json,得到一个字典或者数组
    id  json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (json == nil) {
        NSLog(@"解析文件失败");
        return nil;
    }
    //返回数据
    return json;
}



/**
 *  2.2解析本地json数据
 *  @param fileName jion文件名
 *  @return  数组
 */
+ (NSArray *)getArrayFromJsonData:(NSString *)fileName{
    //1.获取json文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".json"];
    //2.通过路径获取data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //3.设置错误对像
    NSError *error = nil;
    //4.解析json,得到一个字典或者数组
    id  jsonArr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (jsonArr== nil) {
        NSLog(@"解析文件失败");
        return nil;
    }
    //返回数据
    return jsonArr;
}


/**
 *  2.3解析本地json数据
 *  @param fileName jion文件名
 *  @return  字典
 */
+ (NSDictionary *)getDictionaryFromJsonData:(NSString *)fileName{
    //1.获取json文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".json"];
    //2.通过路径获取data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //3.设置错误对像
    NSError *error = nil;
    //4.解析json,得到一个字典或者数组
    NSDictionary *  jsonDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (jsonDic == nil) {
        NSLog(@"解析文件失败");
        return nil;
    }
    //返回数据
    return jsonDic;
}



@end
