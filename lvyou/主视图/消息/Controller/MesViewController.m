//
//  MesViewController.m
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MesViewController.h"

@interface MesViewController ()

@end


@implementation MesViewController

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
    
    //设置导航栏
    [self _creatNavigation];
    UIColor *color = [self mostColor:[UIImage imageNamed:@"increaseOrderNum.png"]];
    self.view.backgroundColor = color;
    if (self.show) {
        [self _initView];
    }
}

- (void)_creatNavigation{
    
    UIButton *clearButon = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButon.frame = CGRectMake(0, 0, 80, 50);
    [clearButon setTitle:@"清空" forState:UIControlStateNormal];
    [clearButon setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:clearButon];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)_initView{
    _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
//    _selectView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_selectView];
    //两个按钮
    
    _yqqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _yqqButton.frame = CGRectMake(0, 0, KScreenWidth / 2, 30);
    _yqqButton.backgroundColor = [UIColor whiteColor];
    [_yqqButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _yqqButton.tag = 2015;
    [_yqqButton setTitle:@"一起去" forState:UIControlStateNormal];
    [_yqqButton addTarget:self action:@selector(yqqButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectView addSubview:_yqqButton];
    
    _lytButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lytButton.frame = CGRectMake(_yqqButton.right, 0, KScreenWidth / 2, 30);
    _lytButton.tag = 2016;
    [_lytButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _lytButton.backgroundColor = [UIColor darkGrayColor];
    [_lytButton setTitle:@"驴游团" forState:UIControlStateNormal];
    [_lytButton addTarget:self action:@selector(lytButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectView addSubview:_lytButton];
}

- (void)yqqButton:(UIButton *)button{

    _lytButton.backgroundColor = [UIColor darkGrayColor];
    button.backgroundColor = [UIColor whiteColor];
}

- (void)lytButton:(UIButton *)button{

    _yqqButton.backgroundColor = [UIColor darkGrayColor];
    
    button.backgroundColor = [UIColor whiteColor];
}


static void RGBtoHSV( float r, float g, float b, float *h, float *s, float *v )
{
    float min, max, delta;
    min = MIN( r, MIN( g, b ));
    max = MAX( r, MAX( g, b ));
    *v = max;               // v
    delta = max - min;
    if( max != 0 )
        *s = delta / max;       // s
    else {
        // r = g = b = 0        // s = 0, v is undefined
        *s = 0;
        *h = -1;
        return;
    }
    if( r == max )
        *h = ( g - b ) / delta;     // between yellow & magenta
    else if( g == max )
        *h = 2 + ( b - r ) / delta; // between cyan & yellow
    else
        *h = 4 + ( r - g ) / delta; // between magenta & cyan
    *h *= 60;               // degrees
    if( *h < 0 )
        *h += 360;
}


-(UIColor*)mostColor:(UIImage*)image{
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(40, 40);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    NSArray *MaxColor=nil;
    // NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    float maxScore=0;
    for (int x=0; x<thumbSize.width*thumbSize.height; x++) {
        
        
        int offset = 4*x;
        
        int red = data[offset];
        int green = data[offset+1];
        int blue = data[offset+2];
        int alpha =  data[offset+3];
        
        if (alpha<25)continue;
        
        float h,s,v;
        RGBtoHSV(red, green, blue, &h, &s, &v);
        
        float y = MIN(abs(red*2104+green*4130+blue*802+4096+131072)>>13, 235);
        y= (y-16)/(235-16);
        if (y>0.9) continue;
        
        float score = (s+0.1)*x;
        if (score>maxScore) {
            maxScore = score;
        }
        MaxColor=@[@(red),@(green),@(blue),@(alpha)];
        //[cls addObject:clr];
        
    }
    CGContextRelease(context);
    
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
    

}



@end
