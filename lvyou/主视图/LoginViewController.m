//
//  LoginViewController.m
//  lvyou
//
//  Created by imac on 15/10/6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    _inputView.layer.borderColor = [UIColor whiteColor].CGColor;
    _inputView.layer.borderWidth = 1;
    _inputView.layer.cornerRadius = 4;
    _inputView.layer.masksToBounds = YES;
    
}

//忘记密码
- (IBAction)forgetPassword:(UIButton *)sender {
    
    
}

//登录
- (IBAction)loginWithSMSButton:(UIButton *)sender {


}

//微信登录
- (IBAction)loginWithWeiXinButton:(UIButton *)sender {

//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
//    
//    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
//            
//            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//            
//        }
//        
//    });
    
}


//微博登录
- (IBAction)loginWithWeiboButton:(UIButton *)sender {

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self, [UMSocialControllerService defaultControllerService], YES, ^(UMSocialResponseEntity *response) {
        
//        NSLog(@"response is %@", response);
        
        // 如果是授权到新浪微博，SSO之后如果想获取用户的昵称、头像等需要再获取一次账户信息
        
        [[UMSocialDataService defaultDataService]requestSocialAccountWithCompletion:^(UMSocialResponseEntity *response) {
            
            NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
            
            //本地保存
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:sinaAccount.accessToken, @"token", sinaAccount.usid, @"usid",nil];
            
            
            [DataService requestWithURL:login_url params:params httpMethod:@"POST" finishBlock:^(AFHTTPRequestOperation *operation, id result) {
                
                id items = result[@"Items"];
                if ([items isKindOfClass:[NSNull class]]) {
                    return ;
                }
                
                NSString *token = [items objectForKey:@"Token"];
                NSString *nickName = [items objectForKey:@"Nickname"];
                NSString *headUrl = [items objectForKey:@"HeadUrl"];
                NSString *uid = [items objectForKey:@"Id"];
                
                userMessageDic = [NSDictionary dictionaryWithObjectsAndKeys:token, user_token, nickName, user_name, headUrl, user_icon, uid, user_id, nil];
                [self saveMessage];
                
            } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            
            
        }];
        
    });
    
}


//QQ登录
- (IBAction)loginWithQQButton:(id)sender {

    
    
}

//注册
- (IBAction)registButton:(id)sender {


}

//本地保存信息
- (void)saveMessage{
    
    [[NSUserDefaults standardUserDefaults] setObject:userMessageDic forKey:user_message];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//取消登录

- (IBAction)calcleLogin:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
