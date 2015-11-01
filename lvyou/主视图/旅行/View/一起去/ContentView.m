//
//  ContentView.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.backgroundColor = [UIColor clearColor];
        [self _initView];
    }
    return self;
}

- (void)_initView{
    
    _textLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _textLabel.font = [UIFont systemFontOfSize:14];
    _textLabel.numberOfLines = 0;
    [self addSubview:_textLabel];
    img1 = [[UIImageView alloc] initWithFrame:CGRectZero];
    img1.layer.cornerRadius = 2;
    img1.layer.masksToBounds = YES;
    img1.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:img1];
    
    _requireLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _requireLabel.numberOfLines = 0;
    _requireLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_requireLabel];
    
    [self addSubview:_textLabel];
    img2 = [[UIImageView alloc] initWithFrame:CGRectZero];
    img2.layer.cornerRadius = 2;
    img2.layer.masksToBounds = YES;
    img2.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:img2];
    
    _moneyTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _moneyTypeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_moneyTypeLabel];
    
    for (int i = 0; i < 3; i++) {
        
        ZoomImageView *imgView = [[ZoomImageView alloc] initWithFrame:CGRectMake(((KScreenWidth - 20 * 3) / 3.0 + 10) * i, 0, (KScreenWidth - 20 * 3) / 3.0, (KScreenWidth - 20 * 3) / 3.0)];
        imgView.userInteractionEnabled = YES;
        imgView.tag = 100 + i;
        
        [self addSubview:imgView];
        
        if (i == 2) {
            _imgCount = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom - 20, imgView.width, 20)];
            _imgCount.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            _imgCount.textColor = [UIColor whiteColor];
            _imgCount.font = [UIFont systemFontOfSize:14];
            _imgCount.textAlignment = NSTextAlignmentCenter;
//            [imgView addSubview:_imgCount];
            _imgCount.hidden = YES;
        }
    }
    
}

- (void)setModel:(YQQModel *)model{
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect rect = [self getTextSize:self.model.Remark font:[UIFont systemFontOfSize:14]];
    _textLabel.frame = CGRectMake(0, 0, self.width, rect.size.height + 20);
    _textLabel.text = self.model.Remark;
    _textLabel.wxLabelDelegate = self;
    
    CGRect rect1 = [self getTextSize:self.model.Require font:[UIFont systemFontOfSize:12]];
    _requireLabel.frame = CGRectMake(10, _textLabel.bottom, self.width, rect1.size.height + 5);
    _requireLabel.textColor = [UIColor blueColor];
    _requireLabel.text = self.model.Require;
    
    img1.frame = CGRectMake(_requireLabel.left - 10, _requireLabel.top + 7, 4, 4);
    
    _moneyTypeLabel.frame = CGRectMake(_requireLabel.left + 5, _requireLabel.bottom + 5, self.width, 20);
    _moneyTypeLabel.textColor = [UIColor blueColor];
    _moneyTypeLabel.text = self.model.MoneyType;
    
    img2.frame = CGRectMake(img1.left, _moneyTypeLabel.top + 7, 4, 4);
    
    
    for (int i = 0; i < 3; i++) {
        ZoomImageView *imgView = (ZoomImageView *)[self viewWithTag:100 + i];
        if (i < self.model.picList.count) {
            imgView.hidden = NO;
            imgView.top = _moneyTypeLabel.bottom + 5;
            PicListModel *pic = self.model.picList[i];
            [imgView sd_setImageWithURL:[NSURL URLWithString:pic.Url]];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            [imgView zoomBiggerImageViewWithFullImageView:pic.Url];
        }else{
            //没有图片，隐藏对应的imgView
//            [imgView removeFromSuperview];
            imgView.hidden = YES;
        }
        
    }
    
    if (self.model.picList.count > 3) {
        _imgCount.hidden = NO;
        _imgCount.text = [NSString stringWithFormat:@"共%ld张图片", self.model.picList.count];
        
    }
    
    self.height = _textLabel.height + _requireLabel.height + _moneyTypeLabel.height + ((KScreenWidth - 20 * 3) / 3.0) + 20;
    
}

- (CGRect)getTextSize:(NSString *)text font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth - 40, KScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    return rect;
}

#pragma mark -WXLabelDelegate
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@[.\\w\\-]+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#.+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel
{
    return [UIColor orangeColor];
}


@end
