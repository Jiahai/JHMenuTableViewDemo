//
//  JHMenuTableViewCell.h
//  JHMenuTableViewCell
//
//  Created by Jiahai on 15/3/27.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMenuAction.h"
#import "JHMenuActionView.h"

typedef NS_ENUM(NSInteger, JHMenuTableViewCellState)
{
    JHMenuTableViewCellState_Common       = 0,
    JHMenuTableViewCellState_Expanded
};


@interface JHMenuTableViewCell : UITableViewCell <JHMenuActionViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, assign)   JHMenuTableViewCellState   swipeState;

@property (nonatomic, strong)   UIView                      *customView;
@property (nonatomic, strong)   JHMenuActionView           *actionsView;

@property (nonatomic, strong)   NSArray                     *actions;

@property (nonatomic, assign)   CGFloat                     deltaX;

- (void)swipeBeganWithDeltaX:(CGFloat)deltaX;

- (void)swipeEndWithDeltaX:(CGFloat)deltaX;
@end
