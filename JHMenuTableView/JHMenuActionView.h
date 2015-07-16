//
//  JHMenuActionView.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/7/13.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMenuAction.h"

/**
 *  JHMenuActionViewState
 */
typedef NS_ENUM(NSInteger, JHMenuActionViewState){
    /**
     *  正常状态
     */
    JHMenuActionViewState_Common       = 0,
    /**
     *  展开一部分，显示更多按钮
     */
    JHMenuActionViewState_Division,
    /**
     *  全部展开
     */
    JHMenuActionViewState_Expanded
};


@interface JHMenuActionView : UIView

@property (nonatomic, assign)       id<JHMenuActionViewDelegate>   delegate;

@property (nonatomic, strong)       NSArray     *actions;
/**
 *  Menu是否能够分开展示
 */
@property (nonatomic, readonly)     BOOL        canDivision;
@property (nonatomic, strong)       UIButton    *moreBtn;
@property (nonatomic, assign)       JHMenuActionViewState   state;

- (void)setActions:(NSArray *)actions moreButtonShow:(BOOL)moreButtonShow moreButtonIndex:(NSInteger)moreButtonIndex actionButtonWidth:(NSInteger)actionButtonWidth;

- (void)setMoreButtonHidden:(BOOL)hidden;

- (void)actionButtonClicked:(UIButton *)actionBtn;

@end
