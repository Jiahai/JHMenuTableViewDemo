//
//  ViewController.m
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/4/21.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)           NSArray     *actions;
@property (nonatomic, strong)           NSArray     *actions1;
@property (nonatomic, strong)           NSArray     *iActions;
@property (nonatomic, strong)           NSMutableArray  *selectedArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_tableView openJHTableViewMenu];
    _tableView.jhMenuDelegate = self;
    
    
    _toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 60)];
    _toolBarView.backgroundColor = [UIColor orangeColor];
    _toolBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:_toolBarView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:_toolBarView.bounds];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Click me,Thanks for using! ^_^";
    [_toolBarView addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = _tableView.bounds;
    [btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_toolBarView addSubview:btn];
    
    self.selectedArray = [NSMutableArray array];
    
    JHMenuTextAction *action = [[JHMenuTextAction alloc] init];
    action.title = @"标为\n已读";
    action.titleColor = [UIColor whiteColor];
    action.backgroundColor = JHRGBA(148, 158, 167, 1);
    action.actionBlock = ^(JHMenuTableViewCell *cell, NSIndexPath *indexPath){
        JHLog(@"标为已读:%@,row:%d",cell,indexPath.row);
    };
    
    JHMenuTextAction *action1 = [[JHMenuTextAction alloc] init];
    action1.title = @"标为\n红旗";
    action1.titleColor = [UIColor whiteColor];
    action1.backgroundColor = JHRGBA(159, 169, 178, 1);
    action1.actionBlock = ^(JHMenuTableViewCell *cell, NSIndexPath *indexPath){
        JHLog(@"标为红旗:%@,row:%d",cell,indexPath.row);
    };
    
    JHMenuTextAction *action2 = [[JHMenuTextAction alloc] init];
    action2.title = @"移动";
    action2.titleColor = [UIColor whiteColor];
    action2.backgroundColor = JHRGBA(178, 185, 191, 1);
    action2.actionBlock = ^(JHMenuTableViewCell *cell, NSIndexPath *indexPath){
        JHLog(@"移动:%@,row:%d",cell,indexPath.row);
    };
    
    JHMenuTextAction *action3 = [[JHMenuTextAction alloc] init];
    action3.title = @"删除";
    action3.titleColor = [UIColor whiteColor];
    action3.backgroundColor = JHRGBA(250, 88, 89, 1);
    action3.actionBlock = ^(JHMenuTableViewCell *cell, NSIndexPath *indexPath){
        JHLog(@"删除:%@,row:%d",cell,indexPath.row);
    };
    
    
    JHMenuImageAction *iAction = [[JHMenuImageAction alloc] init];
    iAction.image_normal = @"jhmenu_unchecked.png";
    iAction.image_selected = @"jhmenu_checked.png";
    iAction.actionBlock = ^(JHMenuTableViewCell *cell, NSIndexPath *indexPath){
        if([self.selectedArray containsObject:indexPath])
        {
            [self.selectedArray removeObject:indexPath];
        }
        else
        {
            [self.selectedArray addObject:indexPath];
        }
        JHLog(@"选中:%@,row:%d",cell,indexPath.row);
    };
    
    self.actions = @[action,action1,action2,action3];
    self.actions1 = @[action,iAction,action2];
    self.iActions = @[iAction];
}

- (void)buttonClicked
{
    [_tableView setTableViewCellMenuState:JHMenuTableViewCellState_Common];
    
    CGRect rect = _toolBarView.bounds;
    rect.origin.y = self.view.bounds.size.height;
    
    [UIView animateWithDuration:JHMenuExpandAnimationDuration animations:^{
        _toolBarView.frame = rect;
    } completion:^(BOOL finished) {
        _toolBarView.alpha = 1;
    }];
}

#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    JHMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil)
    {
        //-----------------------此处请务必按此设置--------------------------
        cell = [[JHMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //不需要的菜单可以不用设置
        cell.leftActions = self.iActions;
        cell.rightActions = self.actions;
        cell.menuState = tableView.currentMenuTableCell.menuState;
        //----------------------------------------------------------------
        
        UILabel *textField = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 120, 32)];
        textField.tag = 88;
        [cell.customView addSubview:textField];
        cell.customView.layer.borderColor = [UIColor blackColor].CGColor;
        cell.customView.layer.borderWidth = 0.5;
    }
    
    //此步骤可针对不同的cell修改JHAction
    //使用时请注意，防止JHAction错乱
    if(indexPath.row % 2 == 0)
    {
        cell.rightActions = self.actions1;
    }
    else
    {
        cell.rightActions = self.actions;
    }
    
    JHMenuImageAction *imageAction = [self.iActions objectAtIndex:0];
    imageAction.selected = [self.selectedArray containsObject:indexPath];
    cell.leftActions = self.iActions;
    
    
    UILabel *label = (UILabel *)[cell.customView viewWithTag:88];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

#pragma mark - JHMenuTableViewDelegate

- (void)jhMenuTableViewSwipeBegan:(UITableView *)tableView currentJHMenuTableViewCell:(JHMenuTableViewCell *)cell
{
    NSLog(@"Swipe Began");
}
- (void)jhMenuTableViewSwipePrecentChanged:(UITableView *)tableView currentJHMenuTableViewCell:(JHMenuTableViewCell *)cell
{
    NSLog(@"Swipe Precent:%.2f   right:%.2f",cell.leftPrecent,cell.rightPrecent);
    switch (cell.menuState) {
        case JHMenuTableViewCellState_All_TogglingLeft:
        {
            CGRect rect = _toolBarView.bounds;
            rect.origin.y = self.view.bounds.size.height - cell.leftPrecent*rect.size.height;
            _toolBarView.frame = rect;
            
            _toolBarView.alpha = cell.leftPrecent;
        }
            break;
            
        default:
            break;
    }
}
- (void)jhMenuTableViewSwipeEnded:(UITableView *)tableView currentJHMenuTableViewCell:(JHMenuTableViewCell *)cell
{
    NSLog(@"Swipe Ended");
    CGRect rect = _toolBarView.bounds;
    
    switch (cell.menuState) {
        case JHMenuTableViewCellState_Common:
        {
            rect.origin.y = self.view.bounds.size.height;
            
            [UIView animateWithDuration:JHMenuExpandAnimationDuration animations:^{
                _toolBarView.frame = rect;
            } completion:^(BOOL finished) {
                _toolBarView.alpha = 1;
            }];
        }
            break;
        case JHMenuTableViewCellState_All_ToggledLeft:
        {
            rect.origin.y = self.view.bounds.size.height - rect.size.height;
            
            [UIView animateWithDuration:JHMenuExpandAnimationDuration animations:^{
                _toolBarView.frame = rect;
            } completion:^(BOOL finished) {
                _toolBarView.alpha = 1;
            }];
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
