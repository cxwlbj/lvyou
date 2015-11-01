//
//  LoginViewController.h
//  lvyou
//
//  Created by imac on 15/10/6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    
    __weak IBOutlet UIView *_inputView;
    
    __weak IBOutlet UITextField *_phoneNumber;
    
    __weak IBOutlet UITextField *_loginPwd;
   
    NSDictionary *userMessageDic;
}

@end
