//
//  JHMenuActionView.m
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/7/13.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import "JHMenuActionView.h"
#import "JHMicro.h"
#import "JHMenuTextAction.h"
#import "JHMenuImageAction.h"

@interface JHMenuActionView ()
@end

@implementation JHMenuActionView

- (void)setState:(JHMenuActionViewState)state
{
    _state = state;
    
    switch (_state) {
        case JHMenuActionViewState_Common:
        {
            [self setMoreButtonHidden:NO];
        }
            break;
        case JHMenuActionViewState_Division:
        {
            [self setMoreButtonHidden:NO];
        }
            break;
        case JHMenuActionViewState_Expanded:
        {
            [self setMoreButtonHidden:YES];
        }
            break;
    }
}

- (void)setActions:(NSArray *)actions
{
    [self clearAllActions];
    
    _actions = actions;
    
    _canDivision = NO;
    
    for(NSInteger i=0; i<(NSInteger)[_actions count]; i++)
    {
        JHMenuAction *action = [_actions objectAtIndex:i];
        
        if([action isKindOfClass:[JHMenuTextAction class]])
        {
            JHMenuTextAction *textAction = (JHMenuTextAction *)action;
            UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            actionBtn.titleLabel.font = [UIFont systemFontOfSize:JHTextActionButtonTextFontSize];
            [actionBtn setBackgroundColor:textAction.backgroundColor];
            [actionBtn setTitle:textAction.title forState:UIControlStateNormal];
            [actionBtn setTitleColor:textAction.titleColor forState:UIControlStateNormal];
            actionBtn.titleLabel.numberOfLines = 0;
            actionBtn.frame = CGRectMake(JHActionButtonWidth*i, 0, JHActionButtonWidth, self.bounds.size.height);
            actionBtn.tag = i;
            actionBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
            [actionBtn addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:actionBtn];
        }
        else if([action isKindOfClass:[JHMenuImageAction class]])
        {
            JHMenuImageAction *imageAction = (JHMenuImageAction *)action;
            UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if(imageAction.selected)
            {
                [actionBtn setImage:[UIImage imageNamed:imageAction.image_selected] forState:UIControlStateNormal];
                [actionBtn setImage:[UIImage imageNamed:imageAction.image_normal] forState:UIControlStateSelected];
            }
            else
            {
                [actionBtn setImage:[UIImage imageNamed:imageAction.image_normal] forState:UIControlStateNormal];
                [actionBtn setImage:[UIImage imageNamed:imageAction.image_selected] forState:UIControlStateSelected];
            }
            actionBtn.frame = CGRectMake(JHActionButtonWidth*i, 0, JHActionButtonWidth, self.bounds.size.height);
            actionBtn.tag = i;
            actionBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
            [actionBtn addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:actionBtn];
        }
    }
    
    if(JHActionMoreButtonShow && _actions.count-1 > JHActionMoreButtonIndex)
    {
        _canDivision = YES;
        NSInteger i = _actions.count-JHActionMoreButtonIndex-1;
        JHMenuTextAction *action = [_actions objectAtIndex:i];
        
        self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:JHTextActionButtonTextFontSize];
        [_moreBtn setBackgroundColor:action.backgroundColor];
        [_moreBtn setTitle:@"<" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:action.titleColor forState:UIControlStateNormal];
        _moreBtn.titleLabel.numberOfLines = 0;
        _moreBtn.frame = CGRectMake(JHActionButtonWidth*i, 0, JHActionButtonWidth, self.bounds.size.height);
        _moreBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        [_moreBtn addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreBtn];
    }
}

- (void)setMoreButtonHidden:(BOOL)hidden
{
    [UIView animateWithDuration:JHMenuExpandAnimationDuration animations:^{
        _moreBtn.alpha = hidden ? 0 : 1;
    } completion:^(BOOL finished) {
        _moreBtn.hidden = hidden;
    }];
}

/**
 *  清除现有的Actions
 */
- (void)clearAllActions
{
    NSArray *subViews = [self subviews];
    
    for(UIView *subView in subViews)
    {
        [subView removeFromSuperview];
    }
    
    _actions = nil;
}

- (void)actionButtonClicked:(UIButton *)actionBtn
{
    JHMenuAction *action = [self.actions objectAtIndex:actionBtn.tag];
    if([action isKindOfClass:[JHMenuImageAction class]])
    {
        JHMenuImageAction *imageAction = (JHMenuImageAction *)action;
        if(imageAction.checkboxModel)
        {
            imageAction.selected = !imageAction.selected;
            if(imageAction.selected)
            {
                [actionBtn setImage:[UIImage imageNamed:imageAction.image_selected] forState:UIControlStateNormal];
                [actionBtn setImage:[UIImage imageNamed:imageAction.image_normal] forState:UIControlStateSelected];
            }
            else
            {
                [actionBtn setImage:[UIImage imageNamed:imageAction.image_normal] forState:UIControlStateNormal];
                [actionBtn setImage:[UIImage imageNamed:imageAction.image_selected] forState:UIControlStateSelected];
            }
        }
    }
}

- (void)moreButtonClicked
{
    
}


@end
