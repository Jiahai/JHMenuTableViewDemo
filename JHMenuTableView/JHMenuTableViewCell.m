//
//  JHMenuTableViewCell.h
//  JHMenuTableViewCell
//
//  Created by Jiahai on 15/3/27.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import "JHMenuTableViewCell.h"
#import "JHMicro.h"
#import "UIView+JHExtension.h"

@interface JHMenuTableViewCell ()
@property (nonatomic, assign)   CGFloat                         startOriginX;
//@property (nonatomic, assign)       CGPoint                         lastPoint;

@end

@implementation JHMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.actionsView = [[JHMenuActionView alloc] initWithFrame:self.bounds];
        self.actionsView.delegate = self;
        self.actionsView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_actionsView];
        
        self.customView = [[UIView alloc] initWithFrame:self.bounds];
        self.customView.backgroundColor = [UIColor redColor];
        self.customView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_customView];
    }
    return self;
}

- (void)layoutSubviews
{
    
}

- (void)setActions:(NSArray *)actions
{
    _actions = actions;
    
    self.actionsView.frame = CGRectMake(self.bounds.size.width-JHActionButtonWidth*_actions.count, 0, JHActionButtonWidth*actions.count, self.bounds.size.height);
    
    [_actionsView setActions:actions];
    
}

- (void)setSwipeState:(JHMenuTableViewCellState)swipeState
{
    _swipeState = swipeState;
    
    CGRect fromRect = self.customView.frame;
    CGRect toRect = fromRect;
    switch (swipeState) {
        case JHMenuTableViewCellState_Common:
        {
            //self.customView.jh_originX = 0;
            toRect.origin.x = 0;
        }
            break;
        case JHMenuTableViewCellState_Expanded:
        {
//            self.customView.jh_originX = -self.actionsView.jh_width;
            toRect.origin.x = -self.actionsView.jh_width;
        }
            break;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.customView.frame = toRect;
    }];
}

- (void)setDeltaX:(CGFloat)deltaX
{
//    CGFloat originX = self.customView.jh_width + deltaX;
    
    CGFloat originX = self.startOriginX + deltaX;
    
    if(originX > 0)
        originX = 0;
    if(originX < -(_actionsView.jh_width))
        originX = -(_actionsView.jh_width);

    self.customView.jh_originX = originX;
}

- (void)swipeBeganWithDeltaX:(CGFloat)deltaX
{
    self.startOriginX = self.customView.jh_originX;
}

- (void)swipeEndWithDeltaX:(CGFloat)deltaX
{
    switch (_swipeState) {
        case JHMenuTableViewCellState_Common:
        {
            if(deltaX < -(JHActionButtonWidth*2/3))
            {
                self.swipeState = JHMenuTableViewCellState_Expanded;
            }
            else
                self.swipeState = JHMenuTableViewCellState_Common;
        }
            break;
        case JHMenuTableViewCellState_Expanded:
        {
            if(deltaX > JHActionButtonWidth*2/3)
                self.swipeState = JHMenuTableViewCellState_Common;
            else
                self.swipeState = JHMenuTableViewCellState_Expanded;
        }
            break;
    }
}

//- (CGPoint)

#pragma mark - JHSwipeActionViewDelegate
- (void)actionViewEventHandler:(JHActionBlock)actionBlock
{
    if(actionBlock)
    {
        UITableView *tableView = (UITableView *)self.superview.superview;
        
        actionBlock(self, [tableView indexPathForCell:self]);
    }
}
@end
