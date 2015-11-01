//
//  SearchFriendsTableView.m
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SearchFriendsTableView.h"
#import "SearchFriendsTableViewCell.h"
@implementation SearchFriendsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *friendsTableResult = @"friendsTable";
    SearchFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:friendsTableResult];
    if (cell == nil) {
        cell = [[SearchFriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:friendsTableResult];
    }
    cell.model = self.data[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

@end
