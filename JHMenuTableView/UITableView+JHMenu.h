//
//  UITableView+JHMenu.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/4/1.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHMenuTableViewCell;

@protocol JHMenuTableViewDelegate <NSObject>

- (void)jhMenuTableViewSwipeBegan:(UITableView *)tableView;
- (void)jhMenuTableViewSwipePrecentChanged:(UITableView *)tableView currentJHMenuTableViewCell:(JHMenuTableViewCell *)cell;
- (void)jhMenuTableViewSwipeEnded:(UITableView *)tableView;

@end

@interface UITableView (JHMenu) <UIGestureRecognizerDelegate>

@property (nonatomic, assign)       id<JHMenuTableViewDelegate>     jhMenuDelegate;

- (void)openJHTableViewMenu;

- (void)closeJHTableViewMenu;

@end
