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

@interface JHMenuActionView ()
@property (nonatomic, strong)       NSArray     *actions;
@end

@implementation JHMenuActionView


- (void)setActions:(NSArray *)actions
{
    _actions = actions;
    
    for(NSInteger i=0; i<(NSInteger)[_actions count]; i++)
    {
        JHMenuAction *action = [_actions objectAtIndex:i];
        UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [actionBtn setBackgroundColor:action.backgroundColor];
        [actionBtn setTitle:action.title forState:UIControlStateNormal];
        [actionBtn setTitleColor:action.titleColor forState:UIControlStateNormal];
        actionBtn.titleLabel.numberOfLines = 2;
        actionBtn.frame = CGRectMake(JHActionButtonWidth*i, 0, JHActionButtonWidth, self.bounds.size.height);
        actionBtn.tag = i;
        actionBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        [actionBtn addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:actionBtn];
    }
}



- (void)actionButtonClicked:(UIButton *)btn
{
    JHMenuAction *action = [_actions objectAtIndex:btn.tag];
    
    if([self.delegate respondsToSelector:@selector(actionViewEventHandler:)])
    {
        [self.delegate actionViewEventHandler:action.actionBlock];
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
