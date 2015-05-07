//
//  JHMenuActionView.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/3/27.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMenuAction.h"

@protocol JHMenuActionViewDelegate <NSObject>

- (void)actionViewEventHandler:(JHActionBlock)actionBlock;
- (void)moreButtonEventHandler;

@end

@interface JHMenuActionView : UIView
{
    
}

@property (nonatomic, strong)       UIButton    *moreBtn;

@property (nonatomic, assign)       id<JHMenuActionViewDelegate>   delegate;
/**
 *  Menu是否能够分开展示
 */
@property (nonatomic, readonly)     BOOL        canDivision;
@property (nonatomic, getter=divisionOriginX)   CGFloat     divisionOriginX;

- (void)setActions:(NSArray *)actions;

- (void)setMoreButtonHidden:(BOOL)hidden;
@end
