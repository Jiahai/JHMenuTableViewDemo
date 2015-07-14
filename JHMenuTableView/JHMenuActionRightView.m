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


//- (void)setActions:(NSArray *)actions
//{
//    [self clearAllActions];
//    
//    self.actions = actions;
//    
//    _canDivision = NO;
//    
//    for(NSInteger i=0; i<(NSInteger)[_actions count]; i++)
//    {
//        JHMenuTextAction *action = [_actions objectAtIndex:i];
//        UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        actionBtn.titleLabel.font = [UIFont systemFontOfSize:JHTextActionButtonTextFontSize];
//        [actionBtn setBackgroundColor:action.backgroundColor];
//        [actionBtn setTitle:action.title forState:UIControlStateNormal];
//        [actionBtn setTitleColor:action.titleColor forState:UIControlStateNormal];
//        actionBtn.titleLabel.numberOfLines = 0;
//        actionBtn.frame = CGRectMake(JHActionButtonWidth*i, 0, JHActionButtonWidth, self.bounds.size.height);
//        actionBtn.tag = i;
//        actionBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
//        [actionBtn addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:actionBtn];
//    }
//    
//    if(JHActionMoreButtonShow && _actions.count-1 > JHActionMoreButtonIndex)
//    {
//        _canDivision = YES;
//        NSInteger i = _actions.count-JHActionMoreButtonIndex-1;
//        JHMenuTextAction *action = [_actions objectAtIndex:i];
//        
//        self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:JHTextActionButtonTextFontSize];
//        [_moreBtn setBackgroundColor:action.backgroundColor];
//        [_moreBtn setTitle:@"<" forState:UIControlStateNormal];
//        [_moreBtn setTitleColor:action.titleColor forState:UIControlStateNormal];
//        _moreBtn.titleLabel.numberOfLines = 0;
//        _moreBtn.frame = CGRectMake(JHActionButtonWidth*i, 0, JHActionButtonWidth, self.bounds.size.height);
//        _moreBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
//        [_moreBtn addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_moreBtn];
//    }
//}
//
//- (void)setMoreButtonHidden:(BOOL)hidden
//{
//    [UIView animateWithDuration:JHMenuExpandAnimationDuration animations:^{
//        _moreBtn.alpha = hidden ? 0 : 1;
//    } completion:^(BOOL finished) {
//        _moreBtn.hidden = hidden;
//    }];
//}

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
