//
//  JHMenuActionLeftView.m
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/7/13.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import "JHMenuActionLeftView.h"

@implementation JHMenuActionLeftView

- (void)actionButtonClicked:(UIButton *)actionBtn
{
    [super actionButtonClicked:actionBtn];
    JHMenuAction *action = [self.actions objectAtIndex:actionBtn.tag];
    
    if([self.delegate respondsToSelector:@selector(leftActionViewEventHandler:)])
    {
        [self.delegate leftActionViewEventHandler:action.actionBlock];
    }
}

- (void)moreButtonClicked
{
    if([self.delegate respondsToSelector:@selector(leftMoreButtonEventHandler)])
    {
        [self.delegate leftMoreButtonEventHandler];
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
