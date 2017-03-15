//
//  UITableView+JHMenu.m
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/4/1.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import "UITableView+JHMenu.h"
#import "JHMicro.h"
#import "JHMenuTableViewCell.h"
#import "objc/runtime.h"

@interface UITableView ()
@property (nonatomic, weak)     JHMenuTableViewCell             *currentMenuTableCell;
@property (nonatomic, strong)   UIPanGestureRecognizer          *jhPanGestureRecognizer;
@end

@implementation UITableView (JHMenu)

#pragma mark - 关联属性
- (void)setJhMenuDelegate:(id<JHMenuTableViewDelegate>)jhMenuDelegate
{
    objc_setAssociatedObject(self, @selector(jhMenuDelegate), jhMenuDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<JHMenuTableViewDelegate>)jhMenuDelegate
{
    return objc_getAssociatedObject(self, @selector(jhMenuDelegate));
}
- (void)setCurrentMenuTableCell:(JHMenuTableViewCell *)currentMenuTableCell
{
    [self willChangeValueForKey:@"currentMenuTableCell"];
    
    objc_setAssociatedObject(self, @selector(currentMenuTableCell), currentMenuTableCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self didChangeValueForKey:@"currentMenuTableCell"];
}

- (JHMenuTableViewCell *)currentMenuTableCell
{
    return objc_getAssociatedObject(self, @selector(currentMenuTableCell));
}

- (void)setJhPanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    [self willChangeValueForKey:@"jhPanGestureRecognizer"];
    
    objc_setAssociatedObject(self, @selector(jhPanGestureRecognizer), panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self didChangeValueForKey:@"jhPanGestureRecognizer"];
}

- (UIPanGestureRecognizer *)jhPanGestureRecognizer
{
    return objc_getAssociatedObject(self, @selector(jhPanGestureRecognizer));
}

#pragma mark -

- (void)openJHTableViewMenu
{
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if(self.jhPanGestureRecognizer == nil)
    {
        self.jhPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandler:)];
        self.jhPanGestureRecognizer.maximumNumberOfTouches = 1;
        self.jhPanGestureRecognizer.delegate = self;
    }
    [self addGestureRecognizer:self.jhPanGestureRecognizer];
}

- (void)closeJHTableViewMenu
{
    [self removeGestureRecognizer:self.jhPanGestureRecognizer];
    self.jhPanGestureRecognizer = nil;
    
    [self setTableViewCellMenuState:JHMenuTableViewCellState_Common];
}

- (void)setTableViewCellMenuState:(JHMenuTableViewCellState)state
{
    switch (state) {
        case JHMenuTableViewCellState_Common:
        case JHMenuTableViewCellState_All_ToggledLeft:
        case JHMenuTableViewCellState_All_ToggledRight:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:JHNOTIFICATION_MoveAllCells_SetMenuState object:nil userInfo:@{@"menuState":@(state)}];
        }
            break;
        case JHMenuTableViewCellState_ToggledLeft:
        case JHMenuTableViewCellState_ToggledRight:
        {
            self.currentMenuTableCell.menuState = state;
        }
        default:
            break;
    }
}

#pragma mark - 手势处理
- (void)panGestureHandler:(UIPanGestureRecognizer *)gesture
{
    CGFloat deltaX = [gesture translationInView:self].x;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint point = [gesture locationInView:self];
            NSIndexPath *indexPath = [self indexPathForRowAtPoint:point];
            self.currentMenuTableCell = (JHMenuTableViewCell *)[self cellForRowAtIndexPath:indexPath];
            
            [self.currentMenuTableCell swipeBeganWithDeltaX:deltaX];
            
            if(self.currentMenuTableCell.leftActions)
            {
                if([self.jhMenuDelegate respondsToSelector:@selector(jhMenuTableViewSwipeBegan:currentJHMenuTableViewCell:)])
                {
                    [self.jhMenuDelegate jhMenuTableViewSwipeBegan:self currentJHMenuTableViewCell:self.currentMenuTableCell];
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            self.currentMenuTableCell.deltaX = deltaX;
            
            if([self.jhMenuDelegate respondsToSelector:@selector(jhMenuTableViewSwipePrecentChanged:currentJHMenuTableViewCell:)])
            {
                [self.jhMenuDelegate jhMenuTableViewSwipePrecentChanged:self currentJHMenuTableViewCell:self.currentMenuTableCell];
            }

        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.currentMenuTableCell swipeEndedWithDeltaX:deltaX];
            
            if([self.jhMenuDelegate respondsToSelector:@selector(jhMenuTableViewSwipeEnded:currentJHMenuTableViewCell:)])
            {
                [self.jhMenuDelegate jhMenuTableViewSwipeEnded:self currentJHMenuTableViewCell:self.currentMenuTableCell];
            }
        }
            break;
        default:
            break;
    }
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( gestureRecognizer == self.jhPanGestureRecognizer )
    {
        BOOL result = YES;
        if(self.currentMenuTableCell)
        {
            if(self.currentMenuTableCell.menuState == JHMenuTableViewCellState_All_ToggledLeft || self.currentMenuTableCell.menuState == JHMenuTableViewCellState_All_ToggledRight)
            {
                result = YES;
            }
            else if(self.currentMenuTableCell.menuState != JHMenuTableViewCellState_Common)
            {
                CGPoint point = [gestureRecognizer locationInView:self];
                NSIndexPath *indexPath = [self indexPathForRowAtPoint:point];
                JHMenuTableViewCell *cell = (JHMenuTableViewCell *)[self cellForRowAtIndexPath:indexPath];
                
                if(cell != self.currentMenuTableCell)
                {
                    self.currentMenuTableCell.menuState = JHMenuTableViewCellState_Common;
                    result = NO;
                }
            }
        }
        CGPoint translation = [self.jhPanGestureRecognizer translationInView:self];
        return (fabs(translation.y) <= fabs(translation.x)) && result;
    }
    else
    {
        return YES;
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
