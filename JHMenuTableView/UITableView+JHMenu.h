//
//  UITableView+JHMenu.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/4/1.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMenuTableViewCell.h"

@protocol JHMenuTableViewDelegate <NSObject>

- (void)jhMenuTableViewSwipeBegan:(UITableView *)tableView currentJHMenuTableViewCell:(JHMenuTableViewCell *)cell;
- (void)jhMenuTableViewSwipePrecentChanged:(UITableView *)tableView currentJHMenuTableViewCell:(JHMenuTableViewCell *)cell;
- (void)jhMenuTableViewSwipeEnded:(UITableView *)tableView currentJHMenuTableViewCell:(JHMenuTableViewCell *)cell;

@end

@interface UITableView (JHMenu) <UIGestureRecognizerDelegate>

@property (nonatomic, assign)       id<JHMenuTableViewDelegate>     jhMenuDelegate;
@property (nonatomic, readonly, getter=currentMenuTableCell) JHMenuTableViewCell *currentMenuTableCell;

/**
 *  打开TableView菜单手势监控
 */
- (void)openJHTableViewMenu;
/**
 *  移除TableView菜单手势
 */
- (void)closeJHTableViewMenu;

/**
 *  设置TableViewCell的菜单状态
 *  一般用在所有Cell联动的场景
 *
 *  @param state JHMenuTableViewCellState
 */
- (void)setTableViewCellMenuState:(JHMenuTableViewCellState)state;
@end
