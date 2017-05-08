JHMenuTableViewDemo
===
UITableview左右侧滑菜单
---
## V1.2版本新增功能
* 加入左侧侧滑菜单功能
* 增加左/右菜单整体侧滑功能
* 增加Delegate回调

## 目录
* [如何导入？](#import)
* [如何使用？](#use)
* [配置JHMenuTableView参数](#config)
* [效果图](#gif)

<a name="gif"/>
### 效果图
![](https://github.com/Jiahai/JHMenuTableViewDemo/blob/master/SnapShot/JHMenuTableViewDemo.gif)

<a name="import"/>
### 如何导入？
* cocoapods导入： `pod 'JHMenuTableView'`
* 手动导入：将`JHMenuTableView`文件夹中的所有文件添加至工程中

<a name="use"/>
### 如何使用？(具体请参看Demo)
#### 导入头文件
```Objective-C
#import "JHMenuTableView.h"
```

#### TableView调用openJHTableViewMenu方法
```Objective-C
[_tableView openJHTableViewMenu];
```

#### 定义Cell的菜单动作数组
```Objective-C
JHMenuAction *action = [[JHMenuAction alloc] init];
action.title = @"标为\n已读";
action.titleColor = [UIColor whiteColor];
action.backgroundColor = JHRGBA(148, 158, 167, 1);
action.actionBlock = ^(JHMenuTableViewCell *cell, NSIndexPath *indexPath){
    JHLog(@"标为已读:%@,row:%d",cell,indexPath.row);
};
self.actions = @[action];
```

#### 返回JHMenuTableViewCell并设置相应的Action数组，自定义View添加到JHMenuTableViewCell.customView上
```Objective-C
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

```
<a name="config"/>
### 配置JHMenuTableView参数
#### 在JHMicro.h文件中配置JHMenuTableView参数

```Objective-C
#pragma mark -
#pragma mark - JHMenuTableView参数配置

/**
 *  支持横屏模式
 */
extern const BOOL           kJHMenuSupportLandspaceOrientation;
/**
 *  JHTextActionButton文本的字体
 */
extern const NSInteger      kJHTextActionButtonTextFontSize;
/**
 *  Menu展开/收缩的动画持续时间，单位为秒
 */
extern const float          kJHMenuExpandAnimationDuration;

#pragma mark - 左侧菜单参数配置
/**
 *  左侧JHActionButton的宽度
 */
extern const NSInteger      kJHActionLeftButtonWidth;
/**
 *  展开左侧Menu时，是否显示更多按钮
 */
extern const BOOL           kJHActionLeftMoreButtonShow;
/**
 *  左侧菜单更多按钮出现的index，从左向右，从0开始
 */
extern const NSInteger      kJHActionLeftMoreButtonIndex;
/**
 *  全部左侧菜单联动
 */
extern const BOOL           kJHMenuMoveAllLeftCells;


#pragma mark - 右侧菜单参数配置
/**
 *  右侧侧JHActionButton的宽度
 */
extern const NSInteger      kJHActionRightButtonWidth;
/**
 *  展开右侧Menu时，是否显示更多按钮
 */
extern const BOOL           kJHActionRightMoreButtonShow;
/**
 *  右侧菜单更多按钮出现的index，从右向左，从0开始
 */
extern const NSInteger      kJHActionRightMoreButtonIndex;
/**
 *  全部右侧菜单联动
 */
extern const BOOL           kJHMenuMoveAllRightCells;
```



