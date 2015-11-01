//
//  AppDelegate.m
//  lvyou
//
//  Created by imac on 15/9/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //开启定位
    //创建位置服务对象
    _locationManager = [[CLLocationManager alloc] init];
    
    //定位的精确度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //代理
    _locationManager.delegate = self;
    
    //在iOS8以后还要有以下操作
    //判断设备的版本
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        //1.调用方法
        [_locationManager requestAlwaysAuthorization];
        //2.在plist文件中添加NSLocationAlwaysUsageDescription这样一个key
        //3.一定要将location对象写成全局的，否则出了方法就会销毁
    }
    
    //开始定位
    [_locationManager startUpdatingLocation];

    [UMSocialData setAppKey:UMAppKey];
    
    
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    
    //初始化UIImageView对象，其中mScreenWidth，mScreenHeight为定义的全局常量
    // mScreenWidth=self.view.frame.size.width  mScreenHeight=self.view.frame.size.height
    
    
    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [UMSocialSnsService applicationDidBecomeActive];
    
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation{
    
    return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error:%@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    NSLog(@"定位成功");
    //关闭定位
    [manager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    
    //获取到定位的经纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%.2f, 经度:%.2f,高度:%.2f, 时刻:%@", coordinate.latitude, coordinate.longitude, location.altitude, location.timestamp);
    //写入到本地
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults objectForKey:current_location];
    CLLocation *last_location = [[CLLocation alloc] initWithLatitude:[[dic objectForKey:@"lat"] floatValue] longitude:[[dic objectForKey:@"lon"] floatValue]];
    //计算两个坐标的距离
    //取得两个位置间的距离
    CLLocationDistance distance = [location distanceFromLocation:last_location];
    
    if (last_location == nil || distance != 0) {
    
        NSDictionary *_current_location = @{@"lon":@(coordinate.longitude), @"lat":@(coordinate.latitude)};
        
        [[NSUserDefaults standardUserDefaults] setObject:_current_location forKey:current_location];
    }
    
}

@end
