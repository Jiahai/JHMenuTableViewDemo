//
//  JHMenuActionRightView.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/5/13.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import "JHMenuActionRightView.h"
#import "JHMenuTextAction.h"
#import "JHMicro.h"
#import "UIView+JHExtension.h"

@interface JHMenuActionRightView ()
@end

@implementation JHMenuActionRightView


- (void)setActions:(NSArray *)actions
{
    [super setActions:actions moreButtonShow:kJHActionRightMoreButtonShow moreButtonIndex:kJHActionRightMoreButtonIndex actionButtonWidth:kJHActionRightButtonWidth];
    
    self.frame = CGRectMake(self.superview.bounds.size.width-kJHActionRightButtonWidth*actions.count, 0, kJHActionRightButtonWidth*actions.count, self.bounds.size.height);
}

- (CGFloat)divisionOriginX
{
    return -(self.jh_width - self.moreBtn.jh_originX);
}

/**
 *  清除现有的Actions
 */
//- (void)clearAllActions
//{
//    NSArray *subViews = [self subviews];
//    
//    for(UIView *subView in subViews)
//    {
//        [subView removeFromSuperview];
//    }
//    
//    self.actions = nil;
//}
//
- (void)actionButtonClicked:(UIButton *)actionBtn
{
    [super actionButtonClicked:actionBtn];
    JHMenuAction *action = [self.actions objectAtIndex:actionBtn.tag];
    
    if([self.delegate respondsToSelector:@selector(rightActionViewEventHandler:)])
    {
        [self.delegate rightActionViewEventHandler:action.actionBlock];
    }
}

- (void)moreButtonClicked
{
    if([self.delegate respondsToSelector:@selector(rightMoreButtonEventHandler)])
    {
        [self.delegate rightMoreButtonEventHandler];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
