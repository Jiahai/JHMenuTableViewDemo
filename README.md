JHMenuTableViewDemo
====
仿网易邮箱列表侧滑菜单
----

#目录
* [如何导入？](#import)
* [如何使用？](#use)
* [配置JHMenuTableView参数](#config)
* [效果图](#gif)

<a name="import" />
##如何导入？
* cocoapods导入： `pod 'JHMenuTableView'`
* 手动导入：将`JHMenuTableView`文件夹中的所有文件添加至工程中

<a name="use"/>
##如何使用？(具体请参看Demo)
####导入头文件
```Objective-C
#import "JHMenuTableView.h"
```

####TableView调用openJHTableViewMenu方法
```Objective-C
[_tableView openJHTableViewMenu];
```

####定义Cell的菜单动作数组
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

####返回JHMenuTableViewCell并设置相应的Action数组，自定义View添加到JHMenuTableViewCell.customView上
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
<a name="config"/>
##配置JHMenuTableView参数
####在JHMicro.h文件中配置JHMenuTableView参数

```Objective-C
/**
 *  JHActionButton的宽度
 */
extern const NSInteger      JHActionButtonWidth;

/**
 *  JHActionButton文本的字体
 */
extern const NSInteger      JHActionButtonTextFontSize;

/**
 *  展开Menu时，是否显示更多按钮
 */
extern const BOOL           JHActionMoreButtonShow;

/**
 *  更多按钮出现的index，从右向左，从0开始
 */
extern const NSInteger      JHActionMoreButtonIndex;

/**
 *  Menu展开/收缩的动画持续时间，单位为秒
 */
extern const float          JHMenuExpandAnimationDuration;
```
<a name="gif"/>
##效果图
![](https://github.com/Jiahai/JHMenuTableViewDemo/blob/master/SnapShot/JHMenuTableViewDemo.gif)


License (MIT)
===========================================

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

