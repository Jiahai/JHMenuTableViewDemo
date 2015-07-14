//
//  JHMenuActionView.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/5/13.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import "JHMenuActionView.h"

@interface JHMenuActionRightView : JHMenuActionView
{
    
}

//@property (nonatomic, strong)       UIButton    *moreBtn;
//
//@property (nonatomic, assign)       id<JHMenuActionViewDelegate>   delegate;
/**
 *  Menu是否能够分开展示
 */
//@property (nonatomic, readonly)     BOOL        canDivision;
@property (nonatomic, getter=divisionOriginX)   CGFloat     divisionOriginX;

//- (void)setActions:(NSArray *)actions;
//
//- (void)setMoreButtonHidden:(BOOL)hidden;
@end
