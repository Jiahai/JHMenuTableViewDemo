//
//  ViewController.m
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/4/21.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+JHMenu.h"
#import "JHMenuTableViewCell.h"
#import "JHMenuAction.h"
#import "JHMicro.h"

@interface ViewController ()
@property (nonatomic, strong)           NSArray     *actions;
@property (nonatomic, strong)           NSArray     *actions1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_tableView openJHTableViewMenu];
    
    JHMenuAction *action = [[JHMenuAction alloc] init];
    action.title = @"标为\n已读";
    action.titleColor = [UIColor whiteColor];
    action.backgroundColor = JHRGBA(148, 158, 167, 1);
    action.actionBlock = ^(JHMenuTableViewCell *cell, NSIndexPath *indexPath){
        JHLog(@"标为已读:%@,row:%d",cell,indexPath.row);
    };
    
    
    JHMenuAction *action1 = [[JHMenuAction alloc] init];
    action1.title = @"标为\n红旗";
    action1.titleColor = [UIColor whiteColor];
    action1.backgroundColor = JHRGBA(159, 169, 178, 1);
    action1.actionBlock = ^(JHMenuTableViewCell *cell, NSIndexPath *indexPath){
        JHLog(@"标为红旗:%@,row:%d",cell,indexPath.row);
    };
    
    JHMenuAction *action2 = [[JHMenuAction alloc] init];
    action2.title = @"移动";
    action2.titleColor = [UIColor whiteColor];
    action2.backgroundColor = JHRGBA(178, 185, 191, 1);
    action2.actionBlock = ^(JHMenuTableViewCell *cell, NSIndexPath *indexPath){
        JHLog(@"移动:%@,row:%d",cell,indexPath.row);
    };
    
    JHMenuAction *action3 = [[JHMenuAction alloc] init];
    action3.title = @"删除";
    action3.titleColor = [UIColor whiteColor];
    action3.backgroundColor = JHRGBA(250, 88, 89, 1);
    action3.actionBlock = ^(JHMenuTableViewCell *cell, NSIndexPath *indexPath){
        JHLog(@"删除:%@,row:%d",cell,indexPath.row);
    };
    
    self.actions = @[action,action1,action2,action3];
    self.actions1 = @[action,action2,action3];
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
        cell
        = [[JHMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.actions = self.actions;
        
        UILabel *textField = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 120, 32)];
        textField.tag = 88;
        [cell.customView addSubview:textField];
    }
    
    if(indexPath.row % 3 == 0)
    {
        cell.actions = self.actions1;
    }
    
    UILabel *label = (UILabel *)[cell.customView viewWithTag:88];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
