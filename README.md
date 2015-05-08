JHMenuTableViewDemo
====

#如何使用？
####*1、导入头文件
```Objective-C
#import "JHMenuTableView.h"
```

####*2、TableView调用openJHTableViewMenu方法
```Objective-C
[_tableView openJHTableViewMenu];
```

####*3、定义Cell的菜单动作数组
```Objective-C
JHMenuAction *action = [[JHMenuAction alloc] init];
action.title = @"标为\n已读";
action.titleColor = [UIColor whiteColor];
action.backgroundColor = JHRGBA(148, 158, 167, 1);
action.actionBlock = ^(JHMenuTableViewCell *cell, NSIndexPath *indexPath){
    JHLog(@"标为已读:%@,row:%d",cell,indexPath.row);
};
```

####*4、UITableViewCell继承JHMenuTableViewCell并设置相应的Action数组
```Objective-C
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
        cell.customView.layer.borderColor = [UIColor blackColor].CGColor;
        cell.customView.layer.borderWidth = 0.5;
    }
    
    //此步骤可针对不同的cell修改JHAction
    //使用时请注意，防止JHAction错乱
    if(indexPath.row % 2 == 0)
    {
        cell.actions = self.actions1;
    }
    else
    {
        cell.actions = self.actions;
    }
    
    UILabel *label = (UILabel *)[cell.customView viewWithTag:88];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

```
