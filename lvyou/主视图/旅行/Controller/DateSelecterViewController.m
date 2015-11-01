//
//  DateSelecterViewController.m
//  lvyou
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DateSelecterViewController.h"
#import "DateSelecterTableViewCell.h"
@interface DateSelecterViewController ()

@end

@implementation DateSelecterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor orangeColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *dateSelecterCell = @"dateSelecterCell";
    
    DateSelecterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dateSelecterCell];
    
    if (cell  == nil) {
        cell = [[DateSelecterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dateSelecterCell];
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return (KScreenWidth - 20) / 7.0 * 5 + 30;
}





@end
