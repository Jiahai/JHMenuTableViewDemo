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

#define JHMenuLeftTriggerDistance   (JHActionLeftButtonWidth*2/3)           //触发左侧Menu动画的距离
#define JHMenuRightTriggerDistance  (JHActionRightButtonWidth*2/3)          //触发右侧Menu动画的距离

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
        
        CGRect rect = self.bounds;
        rect.size.width = 0;
        self.leftActionsView = [[JHMenuActionLeftView alloc] initWithFrame:rect];
        self.leftActionsView.backgroundColor = [UIColor whiteColor];
        self.leftActionsView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.leftActionsView.delegate = self;
        [self addSubview:_leftActionsView];
        
        self.rightActionsView = [[JHMenuActionRightView alloc] initWithFrame:rect];
        self.rightActionsView.backgroundColor = [UIColor whiteColor];
        self.rightActionsView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        self.rightActionsView.delegate = self;
        [self addSubview:_rightActionsView];
        
        self.customView = [[UIView alloc] initWithFrame:self.bounds];
        self.customView.backgroundColor = [UIColor whiteColor];
        self.customView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_customView];
        
        if(kJHMenuMoveAllLeftCells || kJHMenuMoveAllRightCells)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationMoveAllCellsBegan:) name:JHNOTIFICATION_MoveAllCells_Began object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationMoveAllCellsChanged:) name:JHNOTIFICATION_MoveAllCells_Changed object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationMoveAllCellsEnded:) name:JHNOTIFICATION_MoveAllCells_Ended object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationSetMenuState:) name:JHNOTIFICATION_MoveAllCells_SetMenuState object:nil];
        }
        
    }
    return self;
}

- (void)prepareForReuse
{
    if(!(_menuState == JHMenuTableViewCellState_All_ToggledLeft || _menuState == JHMenuTableViewCellState_All_ToggledRight))
    {
        self.leftActionsView.state = self.rightActionsView.state = JHMenuActionViewState_Common;
        self.menuState = JHMenuTableViewCellState_Common;
    }
}

- (void)layoutSubviews
{
//    self.leftActionsView.frame = CGRectMake(0, 0, JHActionLeftButtonWidth*_leftActions.count, self.bounds.size.height);

    self.rightActionsView.frame = CGRectMake(self.bounds.size.width-JHActionRightButtonWidth*_rightActions.count, 0, _rightActionsView.bounds.size.width, self.bounds.size.height);
    
    self.customView.frame = CGRectMake(_customView.frame.origin.x, _customView.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
    NSAssert(self.leftActionsView.jh_width+self.rightActionsView.jh_width<self.customView.jh_width, @"左菜单和右菜单会出现重合，请合理设置菜单Actions！");
}

#pragma mark -

- (CGFloat)leftPrecent
{
    return self.leftActionsView.jh_width == 0 ? 0 : self.customView.jh_originX/self.leftActionsView.jh_width;
}

- (CGFloat)rightPrecent
{
    return self.rightActionsView.jh_width == 0 ? 0 : ABS(self.customView.jh_originX)/self.rightActionsView.jh_width;
}

#pragma mark -

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
    CGRect fromRect = self.customView.frame;
    CGRect toRect = fromRect;
    
    switch (menuState) {
        case JHMenuTableViewCellState_Common:
        {
            toRect.origin.x = 0;
            
            self.leftActionsView.state = self.rightActionsView.state = JHMenuActionViewState_Common;
        }
            break;
        case JHMenuTableViewCellState_ToggledLeft:
        case JHMenuTableViewCellState_All_ToggledLeft:
        {
            switch (_leftActionsView.state) {
                case JHMenuActionViewState_Common:
                {
                    _leftActionsView.state = JHMenuActionViewState_Expanded;
                    toRect.origin.x = _leftActionsView.jh_width;
                }
                    break;
                case JHMenuActionViewState_Division:
                {
                    toRect.origin.x = _leftActionsView.moreBtn.jh_originX + _leftActionsView.moreBtn.jh_width;
                }
                    break;
                case JHMenuActionViewState_Expanded:
                {
                    toRect.origin.x = _leftActionsView.jh_width;
                }
                    break;
            }
        }
            break;
        case JHMenuTableViewCellState_ToggledRight:
        case JHMenuTableViewCellState_All_ToggledRight:
        {
            switch (_rightActionsView.state) {
                case JHMenuActionViewState_Common:
                {
                    _rightActionsView.state = JHMenuActionViewState_Expanded;
                    toRect.origin.x = -_rightActionsView.jh_width;
                }
                    break;
                case JHMenuActionViewState_Division:
                {
                    toRect.origin.x = _rightActionsView.divisionOriginX;
                }
                    break;
                case JHMenuActionViewState_Expanded:
                {
                    toRect.origin.x = -_rightActionsView.jh_width;
                }
                    break;
            }
            
        }
            break;
        default:
            break;
    }
    
    _menuState = menuState;
    
    [UIView animateWithDuration:JHMenuExpandAnimationDuration animations:^{
        self.customView.frame = toRect;
    } completion:^(BOOL finished) {
        //解决重用时设置初始状态时，位置有误差的问题。
        self.customView.frame = toRect;
    }];
}

- (void)setDeltaX:(CGFloat)deltaX
{
    switch (self.menuState) {
        case JHMenuTableViewCellState_TogglingLeft:
        {
            [self swipeToMoveLeftActionViewWithDeltaX:deltaX];
        }
            break;
        case JHMenuTableViewCellState_TogglingRight:
        {
            [self swipeToMoveRightActionViewWithDeltaX:deltaX];
        }
            break;
        case JHMenuTableViewCellState_All_TogglingLeft:
        case JHMenuTableViewCellState_All_TogglingRight:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:JHNOTIFICATION_MoveAllCells_Changed object:nil userInfo:@{@"deltaX":@(deltaX)}];
        }
            break;
        default:
            break;
    }

}

- (void)swipeBeganWithDeltaX:(CGFloat)deltaX
{
    self.startOriginX = self.customView.jh_originX;
    
    if(deltaX > 0)
    {
        switch (_menuState) {
            case JHMenuTableViewCellState_Common:
            {
                if(kJHMenuMoveAllLeftCells)
                {
                    self.menuState = JHMenuTableViewCellState_All_TogglingLeft;
                    [[NSNotificationCenter defaultCenter] postNotificationName:JHNOTIFICATION_MoveAllCells_Began object:nil userInfo:@{@"deltaX":@(deltaX)}];
                }
                else
                {
                    self.menuState = JHMenuTableViewCellState_TogglingLeft;
                }
            }
                break;
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
                
            case JHMenuTableViewCellState_All_ToggledLeft:
            {
                self.menuState = JHMenuTableViewCellState_All_TogglingLeft;
                [[NSNotificationCenter defaultCenter] postNotificationName:JHNOTIFICATION_MoveAllCells_Began object:nil userInfo:@{@"deltaX":@(deltaX)}];
            }
                break;
                
            case JHMenuTableViewCellState_All_ToggledRight:
            {
                self.menuState = JHMenuTableViewCellState_All_TogglingRight;
                [[NSNotificationCenter defaultCenter] postNotificationName:JHNOTIFICATION_MoveAllCells_Began object:nil userInfo:@{@"deltaX":@(deltaX)}];
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
            {
                if(kJHMenuMoveAllRightCells)
                {
                    self.menuState = JHMenuTableViewCellState_All_TogglingRight;
                    [[NSNotificationCenter defaultCenter] postNotificationName:JHNOTIFICATION_MoveAllCells_Began object:nil userInfo:@{@"deltaX":@(deltaX)}];
                }
                else
                {
                    self.menuState = JHMenuTableViewCellState_TogglingRight;
                }
            }
                break;
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
                
            case JHMenuTableViewCellState_All_ToggledLeft:
            {
                self.menuState = JHMenuTableViewCellState_All_TogglingLeft;
                [[NSNotificationCenter defaultCenter] postNotificationName:JHNOTIFICATION_MoveAllCells_Began object:nil userInfo:@{@"deltaX":@(deltaX)}];
            }
                break;
                
            case JHMenuTableViewCellState_All_ToggledRight:
            {
                self.menuState = JHMenuTableViewCellState_All_TogglingRight;
                [[NSNotificationCenter defaultCenter] postNotificationName:JHNOTIFICATION_MoveAllCells_Began object:nil userInfo:@{@"deltaX":@(deltaX)}];
            }
                break;
            default:
                break;
        }
    }
}

- (void)swipeEndedWithDeltaX:(CGFloat)deltaX
{
    switch (_menuState) {
        case JHMenuTableViewCellState_TogglingLeft:
        {
            [self swipeEndLeftActionViewWithDeltaX:deltaX];
        }
            break;
        case JHMenuTableViewCellState_TogglingRight:
        {
            [self swipeEndRightActionViewWithDeltaX:deltaX];
        }
            break;
        case JHMenuTableViewCellState_All_TogglingLeft:
        case JHMenuTableViewCellState_All_TogglingRight:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:JHNOTIFICATION_MoveAllCells_Ended object:nil userInfo:@{@"deltaX":@(deltaX)}];
        }
            break;
        default:
            break;
    }
}
/**
 *  根据ActionView的state设置menuState，手动滑动时可用
 *
 *  @param actionView left/rightActionView
 */
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
            {
                if(_menuState == JHMenuTableViewCellState_All_TogglingLeft)
                {
                    self.menuState = JHMenuTableViewCellState_All_ToggledLeft;
                }
                else
                {
                    self.menuState = JHMenuTableViewCellState_ToggledLeft;
                }
            }
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
            {
                if(_menuState == JHMenuTableViewCellState_All_TogglingRight)
                {
                    self.menuState = JHMenuTableViewCellState_All_ToggledRight;
                }
                else
                {
                    self.menuState = JHMenuTableViewCellState_ToggledRight;
                }
            }
                break;
        }
    }
}

#pragma mark -

- (void)swipeToMoveLeftActionViewWithDeltaX:(CGFloat)deltaX
{
    if(self.leftActions == nil || self.leftActions.count == 0)
        return;
    
    CGFloat originX = self.startOriginX + deltaX;
    
    if(self.leftActionsView.state == JHMenuActionViewState_Division)
    {
        //分段显示时，移动customView处理"更多"按钮的动画
        if(deltaX > 0)
            self.leftActionsView.moreBtn.alpha = 1 - MIN(1, ABS(deltaX)/JHMenuLeftTriggerDistance);
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
    
    self.customView.jh_originX = MIN(originX,_leftActionsView.jh_width);
}

- (void)swipeToMoveRightActionViewWithDeltaX:(CGFloat)deltaX
{
    if(self.rightActions == nil || self.rightActions.count == 0)
        return;
    
    CGFloat originX = self.startOriginX + deltaX;
                
    if(self.rightActionsView.state == JHMenuActionViewState_Division)
    {
        //分段显示时，移动customView处理"更多"按钮的动画
        if(deltaX < 0)
            self.rightActionsView.moreBtn.alpha = 1 - MIN(1, ABS(deltaX)/JHMenuRightTriggerDistance);
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
                
    self.customView.jh_originX = MAX(originX,-_rightActionsView.jh_width);
}

- (void)swipeEndLeftActionViewWithDeltaX:(CGFloat)deltaX
{
    if(self.leftActions == nil || self.leftActions.count == 0)
    {
        self.menuState = JHMenuTableViewCellState_Common;
        return;
    }
        
    switch (_leftActionsView.state) {
        case JHMenuActionViewState_Common:
        {
            if(deltaX > JHMenuLeftTriggerDistance)
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
            if(deltaX < -JHMenuLeftTriggerDistance)
            {
                _leftActionsView.state = JHMenuActionViewState_Common;
            }
            else if(deltaX > JHMenuLeftTriggerDistance)
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
            if(deltaX < -JHMenuLeftTriggerDistance)
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

- (void)swipeEndRightActionViewWithDeltaX:(CGFloat)deltaX
{
    if(self.rightActions == nil || self.rightActions.count == 0)
    {
        self.menuState = JHMenuTableViewCellState_Common;
        return;
    }
    switch (_rightActionsView.state) {
        case JHMenuActionViewState_Common:
        {
            if(deltaX < -JHMenuRightTriggerDistance)
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
            if(deltaX < -JHMenuRightTriggerDistance)
            {
                _rightActionsView.state = JHMenuActionViewState_Expanded;
            }
            else if(deltaX > JHMenuRightTriggerDistance)
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
            if(deltaX > JHMenuRightTriggerDistance)
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

#pragma mark - 全局移动，通知处理
- (void)handleNotificationMoveAllCellsBegan:(NSNotification *)notification
{
    [self swipeBeganWithDeltaX:[[notification.userInfo objectForKey:@"deltaX"] floatValue]];
}

- (void)handleNotificationMoveAllCellsChanged:(NSNotification *)notification
{
    switch (_menuState) {
        case JHMenuTableViewCellState_All_TogglingLeft:
        {
            [self swipeToMoveLeftActionViewWithDeltaX:[[notification.userInfo objectForKey:@"deltaX"] floatValue]];
        }
            break;
        case JHMenuTableViewCellState_All_TogglingRight:
        {
            [self swipeToMoveRightActionViewWithDeltaX:[[notification.userInfo objectForKey:@"deltaX"] floatValue]];
        }
            break;
        default:
            break;
    }
}

- (void)handleNotificationMoveAllCellsEnded:(NSNotification *)notification
{
    switch (_menuState) {
        case JHMenuTableViewCellState_All_TogglingLeft:
        {
            [self swipeEndLeftActionViewWithDeltaX:[[notification.userInfo objectForKey:@"deltaX"] floatValue]];
        }
            break;
        case JHMenuTableViewCellState_All_TogglingRight:
        {
            [self swipeEndRightActionViewWithDeltaX:[[notification.userInfo objectForKey:@"deltaX"] floatValue]];
        }
            break;
        default:
            break;
    }
}

- (void)handleNotificationSetMenuState:(NSNotification *)notification
{
    self.menuState = [[notification.userInfo objectForKey:@"menuState"] integerValue];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
