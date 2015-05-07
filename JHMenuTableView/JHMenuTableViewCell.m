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


#define JHMenuTriggerDistance   (JHActionButtonWidth*2/3)           //触发Menu动画的距离

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.actionsView = [[JHMenuActionView alloc] initWithFrame:self.bounds];
        self.actionsView.backgroundColor = [UIColor whiteColor];
        self.actionsView.delegate = self;
        [self addSubview:_actionsView];
        
        self.customView = [[UIView alloc] initWithFrame:self.bounds];
        self.customView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_customView];
    }
    return self;
}

- (void)prepareForReuse
{
    self.menuState = JHMenuTableViewCellState_Common;
}

- (void)layoutSubviews
{
    self.actionsView.frame = CGRectMake(self.bounds.size.width-JHActionButtonWidth*_actions.count, 0, JHActionButtonWidth*_actions.count, self.bounds.size.height);
    self.customView.frame = CGRectMake(_customView.frame.origin.x, _customView.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (void)setActions:(NSArray *)actions
{
    _actions = actions;
    
    [_actionsView setActions:actions];
}

- (void)setMenuState:(JHMenuTableViewCellState)menuState
{
    _menuState = menuState;
    
    CGRect fromRect = self.customView.frame;
    CGRect toRect = fromRect;
    switch (_menuState) {
        case JHMenuTableViewCellState_Common:
        {
            toRect.origin.x = 0;
            [self.actionsView setMoreButtonHidden:NO];
        }
            break;
        case JHMenuTableViewCellState_Division:
        {
            toRect.origin.x = self.actionsView.divisionOriginX;
            [self.actionsView setMoreButtonHidden:NO];
        }
            break;
        case JHMenuTableViewCellState_Expanded:
        {
            toRect.origin.x = -self.actionsView.jh_width;
            [self.actionsView setMoreButtonHidden:YES];
        }
            break;
    }
    
    [UIView animateWithDuration:JHMenuExpandAnimationDuration animations:^{
        self.customView.frame = toRect;
    }];
}

- (void)setDeltaX:(CGFloat)deltaX
{
    CGFloat originX = self.startOriginX + deltaX;
    
    if(_menuState == JHMenuTableViewCellState_Division)
    {
        //分段显示时，移动customView处理更多按钮的动画
        if(deltaX < 0)
            self.actionsView.moreBtn.alpha = 1 - MIN(1, ABS(deltaX)/JHMenuTriggerDistance);
    }
    
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
    switch (_menuState) {
        case JHMenuTableViewCellState_Common:
        {
            if(deltaX < -JHMenuTriggerDistance)
            {
                self.menuState = self.actionsView.canDivision ? JHMenuTableViewCellState_Division : JHMenuTableViewCellState_Expanded;
            }
            else
            {
                self.menuState = JHMenuTableViewCellState_Common;
            }
        }
            break;
        case JHMenuTableViewCellState_Division:
        {
            if(deltaX < -JHMenuTriggerDistance)
            {
                self.menuState = JHMenuTableViewCellState_Expanded;
            }
            else if(deltaX > JHMenuTriggerDistance)
            {
                self.menuState = JHMenuTableViewCellState_Common;
            }
            else
            {
                self.menuState = JHMenuTableViewCellState_Division;
            }
        }
            break;
        case JHMenuTableViewCellState_Expanded:
        {
            if(deltaX > JHMenuTriggerDistance)
            {
                self.menuState = JHMenuTableViewCellState_Common;
            }
            else
            {
                self.menuState = JHMenuTableViewCellState_Expanded;
            }
        }
            break;
    }
}

//- (CGPoint)

#pragma mark - JHMenuActionViewDelegate
- (void)actionViewEventHandler:(JHActionBlock)actionBlock
{
    if(actionBlock)
    {
        UITableView *tableView = (UITableView *)self.superview.superview;
        
        actionBlock(self, [tableView indexPathForCell:self]);
    }
}
- (void)moreButtonEventHandler
{
    self.menuState = JHMenuTableViewCellState_Expanded;
}
@end
