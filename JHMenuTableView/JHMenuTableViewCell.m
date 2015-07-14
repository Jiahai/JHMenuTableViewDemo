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
#import "JHMenuActionLeftView.h"
#import "JHMenuActionRightView.h"

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
        
        self.leftActionsView = [[JHMenuActionLeftView alloc] initWithFrame:self.bounds];
        self.leftActionsView.backgroundColor = [UIColor whiteColor];
        self.leftActionsView.delegate = self;
        [self addSubview:_leftActionsView];
        
        self.rightActionsView = [[JHMenuActionRightView alloc] initWithFrame:self.bounds];
        self.rightActionsView.backgroundColor = [UIColor whiteColor];
        self.rightActionsView.delegate = self;
        [self addSubview:_rightActionsView];
        
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
    self.leftActionsView.frame = CGRectMake(0, 0, JHActionButtonWidth*_leftActions.count, self.bounds.size.height);

    self.rightActionsView.frame = CGRectMake(self.bounds.size.width-JHActionButtonWidth*_rightActions.count, 0, JHActionButtonWidth*_rightActions.count, self.bounds.size.height);
    
    self.customView.frame = CGRectMake(_customView.frame.origin.x, _customView.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
    
    NSAssert(self.leftActionsView.jh_width+self.rightActionsView.jh_width<self.customView.jh_width, @"左菜单和右菜单会出现重合，请合理设置菜单Actions！");
}

- (void)setLeftActions:(NSArray *)leftActions
{
    _leftActions = leftActions;
    
    [_leftActionsView setActions:_leftActions];
}

- (void)setRightActions:(NSArray *)rightActions
{
    _rightActions = rightActions;
    
    [_rightActionsView setActions:_rightActions];
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
            
            self.leftActionsView.state = self.rightActionsView.state = JHMenuActionViewState_Common;
        }
            break;
        case JHMenuTableViewCellState_ToggledLeft:
        {
            switch (_leftActionsView.state) {
                case JHMenuActionViewState_Common:
                {
                    toRect.origin.x = 0;
//                    [_leftActionsView setMoreButtonHidden:NO];
                }
                    break;
                case JHMenuActionViewState_Division:
                {
                    toRect.origin.x = _leftActionsView.moreBtn.jh_originX + _leftActionsView.moreBtn.jh_width;
//                    [_leftActionsView setMoreButtonHidden:NO];
                }
                    break;
                case JHMenuActionViewState_Expanded:
                {
                    toRect.origin.x = _leftActionsView.jh_width;
//                    [_leftActionsView setMoreButtonHidden:YES];
                }
                    break;
            }
        }
            break;
        case JHMenuTableViewCellState_ToggledRight:
        {
            switch (_rightActionsView.state) {
                case JHMenuActionViewState_Common:
                {
                    toRect.origin.x = 0;
//                    [_rightActionsView setMoreButtonHidden:NO];
                }
                    break;
                case JHMenuActionViewState_Division:
                {
                    toRect.origin.x = _rightActionsView.divisionOriginX;
//                    [_rightActionsView setMoreButtonHidden:NO];
                }
                    break;
                case JHMenuActionViewState_Expanded:
                {
                    toRect.origin.x = -_rightActionsView.jh_width;
//                    [_rightActionsView setMoreButtonHidden:YES];
                }
                    break;
            }
            
        }
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:JHMenuExpandAnimationDuration animations:^{
        self.customView.frame = toRect;
    }];
}

- (void)setDeltaX:(CGFloat)deltaX
{
    CGFloat originX = self.startOriginX + deltaX;
    
    switch (self.menuState) {
        case JHMenuTableViewCellState_TogglingLeft:
        {
            if(self.leftActionsView.state == JHMenuActionViewState_Division)
            {
                //分段显示时，移动customView处理"更多"按钮的动画
                if(deltaX > 0)
                    self.leftActionsView.moreBtn.alpha = 1 - MIN(1, ABS(deltaX)/JHMenuTriggerDistance);
            }
            
            if(originX < 0)
                originX = 0;
            
            /**
             *  x坐标的右极限
             */
            CGFloat originX_R = _leftActionsView.jh_width;
            if(_leftActionsView.canDivision && _leftActionsView.state == JHMenuActionViewState_Common)
            {
                originX_R = _leftActionsView.moreBtn.jh_originX + _leftActionsView.moreBtn.jh_width;
            }
            
            if(originX > originX_R)
                originX = originX_R;
        }
            break;
        case JHMenuTableViewCellState_TogglingRight:
        {
            if(self.rightActionsView.state == JHMenuActionViewState_Division)
            {
                //分段显示时，移动customView处理"更多"按钮的动画
                if(deltaX < 0)
                    self.rightActionsView.moreBtn.alpha = 1 - MIN(1, ABS(deltaX)/JHMenuTriggerDistance);
            }
            
            if(originX > 0)
                originX = 0;
            
            /**
             *  x坐标的左极限
             */
            CGFloat originX_L = -_rightActionsView.jh_width;
            if(_rightActionsView.canDivision && _rightActionsView.state == JHMenuActionViewState_Common)
            {
                originX_L = -(_rightActionsView.jh_width-_rightActionsView.moreBtn.jh_originX);
            }
            
            if(originX < originX_L)
                originX = originX_L;

        }
            break;
        default:
            break;
    }

    self.customView.jh_originX = originX;
}

- (void)swipeBeganWithDeltaX:(CGFloat)deltaX
{
    self.startOriginX = self.customView.jh_originX;
    
    if(deltaX > 0)
    {
        switch (_menuState) {
            case JHMenuTableViewCellState_Common:
            case JHMenuTableViewCellState_ToggledLeft:
            {
                self.menuState = JHMenuTableViewCellState_TogglingLeft;
            }
                break;
            case JHMenuTableViewCellState_ToggledRight:
            {
                self.menuState = JHMenuTableViewCellState_TogglingRight;
            }
                break;
            default:
                break;
        }
    }
    else
    {
        switch (_menuState) {
            case JHMenuTableViewCellState_Common:
            case JHMenuTableViewCellState_ToggledRight:
            {
                self.menuState = JHMenuTableViewCellState_TogglingRight;
            }
                break;
            case JHMenuTableViewCellState_ToggledLeft:
            {
                self.menuState = JHMenuTableViewCellState_TogglingLeft;
            }
                break;
            default:
                break;
        }
    }
}

- (void)swipeEndWithDeltaX:(CGFloat)deltaX
{
    switch (_menuState) {
        case JHMenuTableViewCellState_TogglingLeft:
        {
            switch (_leftActionsView.state) {
                case JHMenuActionViewState_Common:
                {
                    if(deltaX > JHMenuTriggerDistance)
                    {
                        _leftActionsView.state = _leftActionsView.canDivision ? JHMenuActionViewState_Division : JHMenuActionViewState_Expanded;
                    }
                    else
                    {
                        _leftActionsView.state = JHMenuActionViewState_Common;
                    }
                }
                    break;
                case JHMenuActionViewState_Division:
                {
                    if(deltaX < -JHMenuTriggerDistance)
                    {
                        _leftActionsView.state = JHMenuActionViewState_Common;
                    }
                    else if(deltaX > JHMenuTriggerDistance)
                    {
                        _leftActionsView.state = JHMenuActionViewState_Expanded;
                    }
                    else
                    {
                        _leftActionsView.state = JHMenuActionViewState_Division;
                    }
                }
                    break;
                case JHMenuActionViewState_Expanded:
                {
                    if(deltaX < -JHMenuTriggerDistance)
                    {
                        _leftActionsView.state = JHMenuActionViewState_Common;
                    }
                    else
                    {
                        _leftActionsView.state = JHMenuActionViewState_Expanded;
                    }
                }
                    break;
            }
            
            [self changeMenuStateWithActionView:_leftActionsView];
        }
            break;
        case JHMenuTableViewCellState_TogglingRight:
        {
            switch (_rightActionsView.state) {
                case JHMenuActionViewState_Common:
                {
                    if(deltaX < -JHMenuTriggerDistance)
                    {
                        _rightActionsView.state = _rightActionsView.canDivision ? JHMenuActionViewState_Division : JHMenuActionViewState_Expanded;
                    }
                    else
                    {
                        _rightActionsView.state = JHMenuActionViewState_Common;
                    }
                }
                    break;
                case JHMenuActionViewState_Division:
                {
                    if(deltaX < -JHMenuTriggerDistance)
                    {
                        _rightActionsView.state = JHMenuActionViewState_Expanded;
                    }
                    else if(deltaX > JHMenuTriggerDistance)
                    {
                        _rightActionsView.state = JHMenuActionViewState_Common;
                    }
                    else
                    {
                        _rightActionsView.state = JHMenuActionViewState_Division;
                    }
                }
                    break;
                case JHMenuActionViewState_Expanded:
                {
                    if(deltaX > JHMenuTriggerDistance)
                    {
                        _rightActionsView.state = JHMenuActionViewState_Common;
                    }
                    else
                    {
                        _rightActionsView.state = JHMenuActionViewState_Expanded;
                    }
                }
                    break;
            }
            
            [self changeMenuStateWithActionView:_rightActionsView];
        }
            break;
        default:
            break;
    }
}

- (void)changeMenuStateWithActionView:(JHMenuActionView *)actionView
{
    if(actionView == _leftActionsView)
    {
        switch (_leftActionsView.state) {
            case JHMenuActionViewState_Common:
            {
                self.menuState = JHMenuTableViewCellState_Common;
            }
                break;
            default:
                self.menuState = JHMenuTableViewCellState_ToggledLeft;
                break;
        }
    }
    else if (actionView == _rightActionsView)
    {
        
        switch (_rightActionsView.state) {
            case JHMenuActionViewState_Common:
            {
                self.menuState = JHMenuTableViewCellState_Common;
            }
                break;
            default:
                self.menuState = JHMenuTableViewCellState_ToggledRight;
                break;
        }
    }
}

#pragma mark - JHMenuActionViewDelegate
- (void)leftActionViewEventHandler:(JHActionBlock)actionBlock
{
    if(actionBlock)
    {
        UITableView *tableView = (UITableView *)self.superview.superview;
        
        actionBlock(self, [tableView indexPathForCell:self]);
    }
}
- (void)leftMoreButtonEventHandler
{
    _leftActionsView.state = JHMenuActionViewState_Expanded;
    
    [self changeMenuStateWithActionView:_leftActionsView];
}
- (void)rightActionViewEventHandler:(JHActionBlock)actionBlock
{
    if(actionBlock)
    {
        UITableView *tableView = (UITableView *)self.superview.superview;
        
        actionBlock(self, [tableView indexPathForCell:self]);
    }
}
- (void)rightMoreButtonEventHandler
{
    _rightActionsView.state = JHMenuActionViewState_Expanded;
    
    [self changeMenuStateWithActionView:_rightActionsView];
}
@end
