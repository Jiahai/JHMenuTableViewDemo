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
@property (nonatomic, weak)     JHMenuTableViewCell            *currentMenuTableCell;
@property (nonatomic, strong)   UIPanGestureRecognizer          *panGestureRecognizer;
@end

@implementation UITableView (JHSwipe)

#pragma mark - 关联属性
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

//- (void)setSwipeState:(JHSwipeTableViewCellState)swipeState
//{
//    [self willChangeValueForKey:@"swipeState"];
//    
//    objc_setAssociatedObject(self, @selector(swipeState), @(swipeState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    [self didChangeValueForKey:@"swipeState"];
//}
//
//- (JHSwipeTableViewCellState)swipeState
//{
//    return [objc_getAssociatedObject(self, @selector(swipeState)) integerValue];
//}

- (void)setPanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    [self willChangeValueForKey:@"panGestureRecognizer"];
    
    objc_setAssociatedObject(self, @selector(panGestureRecognizer), panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self didChangeValueForKey:@"panGestureRecognizer"];
}

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    return objc_getAssociatedObject(self, @selector(panGestureRecognizer));
}

#pragma mark -

- (void)openJHSwipeMenu
{
    if(self.panGestureRecognizer == nil)
    {
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandler:)];
        self.panGestureRecognizer.maximumNumberOfTouches = 1;
        self.panGestureRecognizer.delegate = self;
    }
    [self addGestureRecognizer:self.panGestureRecognizer];
}

- (void)closeJHSwipeMenu
{
    [self removeGestureRecognizer:self.panGestureRecognizer];
    self.panGestureRecognizer = nil;
}

- (void)panGestureHandler:(UIPanGestureRecognizer *)gesture
{
    CGFloat deltaX = [gesture translationInView:self].x;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            JHLog(@"%d",self.currentMenuTableCell.swipeState);
//            self.swipeState = JHSwipeTableViewCellState_Moving;
            CGPoint point = [gesture locationInView:self];
            NSIndexPath *indexPath = [self indexPathForRowAtPoint:point];
            self.currentMenuTableCell = (JHMenuTableViewCell *)[self cellForRowAtIndexPath:indexPath];
//            JHLog(@"UIGestureRecognizerStateBegan,%@",indexPath);
            [self.currentMenuTableCell swipeBeganWithDeltaX:deltaX];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            self.currentMenuTableCell.deltaX = deltaX;
//            JHLog(@"UIGestureRecognizerStateChanged,%f",deltaX);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.currentMenuTableCell swipeEndWithDeltaX:deltaX];
//            JHLog(@"UIGestureRecognizerStateEnded，%f",deltaX);
        }
            break;
        default:
            break;
    }
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( gestureRecognizer == self.panGestureRecognizer )
    {
        if(self.currentMenuTableCell && self.currentMenuTableCell.swipeState != JHMenuTableViewCellState_Common)
        {
            CGPoint point = [gestureRecognizer locationInView:self];
            NSIndexPath *indexPath = [self indexPathForRowAtPoint:point];
            JHMenuTableViewCell *cell = (JHMenuTableViewCell *)[self cellForRowAtIndexPath:indexPath];
            
            if(cell != self.currentMenuTableCell)
            {
                self.currentMenuTableCell.swipeState = JHMenuTableViewCellState_Common;
                return NO;
            }
        }
        
        CGPoint translation = [self.panGestureRecognizer translationInView:self];
        return fabs(translation.y) <= fabs(translation.x);
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
