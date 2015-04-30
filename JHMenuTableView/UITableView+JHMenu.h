//
//  UITableView+JHMenu.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/4/1.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView (JHMenu) <UIGestureRecognizerDelegate>

- (void)openJHSwipeMenu;

- (void)closeJHSwipeMenu;

@end
