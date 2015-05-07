//
//  JHMenuActionView.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/3/27.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import "JHMenuActionView.h"
#import "JHMenuAction.h"
#import "JHMicro.h"
#import "UIView+JHExtension.h"

@interface JHMenuActionView ()
@property (nonatomic, strong)       NSArray     *actions;
@end

@implementation JHMenuActionView


- (void)setActions:(NSArray *)actions
{
    [self clearAllActions];
    
    _actions = actions;
    
    for(NSInteger i=0; i<(NSInteger)[_actions count]; i++)
    {
        JHMenuAction *action = [_actions objectAtIndex:i];
        UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.titleLabel.font = [UIFont systemFontOfSize:JHActionButtonTextFontSize];
        [actionBtn setBackgroundColor:action.backgroundColor];
        [actionBtn setTitle:action.title forState:UIControlStateNormal];
        [actionBtn setTitleColor:action.titleColor forState:UIControlStateNormal];
        actionBtn.titleLabel.numberOfLines = 0;
        actionBtn.frame = CGRectMake(JHActionButtonWidth*i, 0, JHActionButtonWidth, self.bounds.size.height);
        actionBtn.tag = i;
        actionBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        [actionBtn addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:actionBtn];
    }
    
    if(JHActionMoreButtonShow && _actions.count-1 > JHActionMoreButtonIndex)
    {
        _canDivision = YES;
        NSInteger i = _actions.count-JHActionMoreButtonIndex-1;
        JHMenuAction *action = [_actions objectAtIndex:i];
        
        self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:JHActionButtonTextFontSize];
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

- (CGFloat)divisionOriginX
{
    return -(self.jh_width - _moreBtn.jh_originX);
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

- (void)actionButtonClicked:(UIButton *)btn
{
    JHMenuAction *action = [_actions objectAtIndex:btn.tag];
    
    if([self.delegate respondsToSelector:@selector(actionViewEventHandler:)])
    {
        [self.delegate actionViewEventHandler:action.actionBlock];
    }
}

- (void)moreButtonClicked
{
    if([self.delegate respondsToSelector:@selector(moreButtonEventHandler)])
    {
        [self.delegate moreButtonEventHandler];
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
