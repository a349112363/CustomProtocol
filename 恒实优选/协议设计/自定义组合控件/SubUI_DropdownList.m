//
//  SubUI_DropdownList.m
//  装修项目管理
//
//  Created by mmxd on 16/12/7.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "SubUI_DropdownList.h"
#import "ProtocolClass.h"
#import <AVFoundation/AVFoundation.h>


#define DropdownListCell @"DropdownListCell"

#pragma mark - Sub_DropdownListCell.m类
@implementation Sub_DropdownListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    
        
        self.label =[[UILabel alloc]initWithFrame:CGRectZero];
        self.label.numberOfLines = 0;
        [self.contentView addSubview:self.label];
        
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.lineView];
        
        
        self.menueImage =[[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.menueImage];
        
        
        self.RedPoint =[[UILabel alloc]init];
        [self.contentView addSubview:self.RedPoint];
        
        
        
    }
    return self;
}

-(void)setModel:(Sub_DropDownListCellModel *)model tableviewCellRadius:(CGFloat)tableviewCellRadius
 tableViewWidth:(CGFloat)tableViewWidth
tableViewheight:(CGFloat)tableViewheigth
 iconImagewidth:(CGFloat)iconimageWidth
iconImageHeight:(CGFloat)iconImageHeight
  RedPointWidth:(CGFloat)RedPointWidth
 RedPointHeight:(CGFloat)RedPointHeight
{
    
    CGFloat lablex = 0;
    CGFloat labelwidth = 0;
   
    self.backgroundColor = [[UIColor setColor:model.backColor] colorWithAlphaComponent:[model.alpha floatValue] / 100];
    self.label.text   = model.text;
    self.label.hidden = [model.isHide boolValue];
    self.label.tag    = [model.tag integerValue];
    self.label.textColor = [UIColor setColor:model.textColor];
    self.label.font   = [UIFont systemFontOfSize:[model.fontsize floatValue]];
    //判断图标是否存在
    if (![NSString isBlankString:model.iconImage]) {
        
        //设置图标位置
        self.menueImage.image =[UIImage imageNamed:model.iconImage];
        self.menueImage.frame = CGRectMake(tableviewCellRadius, (tableViewheigth - self.menueImage.image.size.height) / 2, self.menueImage.image.size.width, self.menueImage.image.size.height);
        //文字X轴 = 图片宽度+左右留白
        lablex = iconimageWidth + tableviewCellRadius + 10;
        //文字宽度 = tableview整体宽度 - 图标宽度 - 小红点宽度 - 3个留白宽度
        labelwidth = tableViewWidth - iconimageWidth - RedPointWidth - tableviewCellRadius * 3;
        
        //图标存在 小红点就存在
        self.RedPoint.text = model.redPoint;
        self.RedPoint.font = [UIFont systemFontOfSize:10];
        self.RedPoint.textAlignment = NSTextAlignmentCenter;
        //小红点位置 =
        self.RedPoint.frame  = CGRectMake(lablex + labelwidth + 5,(tableViewheigth - RedPointHeight) / 2 ,RedPointWidth, RedPointHeight);
        self.RedPoint.layer.cornerRadius = RedPointHeight / 2;
        
        self.RedPoint.clipsToBounds = YES;
        self.RedPoint.backgroundColor =[UIColor redColor];
  
    }
    else
    {
        lablex = iconimageWidth + tableviewCellRadius;
        labelwidth = tableViewWidth - tableviewCellRadius * 2;
    }
    
    
    self.label.frame  = CGRectMake(lablex, 0, labelwidth, tableViewheigth);
    self.lineView.frame =CGRectMake(tableviewCellRadius - 5, tableViewheigth, tableViewWidth-(tableviewCellRadius-5)*2, 1);
    self.lineView.backgroundColor =[UIColor lightGrayColor];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state

}

@end



#pragma mark Sub_DropDownListCellModel.m 数据模型类
@implementation Sub_DropDownListCellModel
//初始化模型一些基础数据
-(id)init
{
    self = [super init];
    
    if (self) {
        
        self.textColor = @"ffffff";
        self.fontsize = @"16.0f";
        self.alpha = @"100";
    }
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
@end

#pragma mark -DropDownBtn
@implementation DropDownBtn


@end

#pragma mark - SubUI_DropdownList
@implementation SubUI_DropdownList
{
    CGFloat tableViewHeight;  //计算出tableview高度
    CGFloat tableViewRadius;  //留白宽度
    CGFloat tableViewWidth;   //tablview宽度
    CGFloat tableViewCellHeight;//tablviewcell 高度
    
    CGFloat IconImageWidth; //图标宽度
    CGFloat IconImageHeight;//图标高度
    
    CGFloat RedPointWidth;//红点宽度
    CGFloat RedPointHeight;//红点高度
}

//tableview 数据源
-(NSMutableArray *)tableData
{
    if (_tableData == nil) {
        
        _tableData =[[NSMutableArray alloc]init];
    }
    return _tableData;
}
//懒加载加载tableview
-(UITableView *)tableView
{
    if (_tableView== nil)
    {

        _tableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
        _tableView.backgroundColor =[UIColor clearColor];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        _tableView.bounces = NO;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableViewRadius = 15;
    
        _tableView.layer.cornerRadius = 2;
        
        _tableView.clipsToBounds = YES;

    }
    return _tableView;
}

//初始化构造函数
-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc
{
    self =[super initWithFrame:frame];
    
    if (self) {
                
        self.vc = vc;
        
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self addSubview:self.tableView];
        
        [self.tableView registerClass:[Sub_DropdownListCell class] forCellReuseIdentifier:DropdownListCell];

    }
    return self;
}

//设置tableview 数据源
-(void)setMenueListValue
{
  
    if (![NSString isBlankString:self.menueJson])
    {
        NSData *data = [self.menueJson dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray * tablemenus =[NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * Bottoms = [Sub_DropDownListCellModel mj_objectArrayWithKeyValuesArray:tablemenus];
        
        for (Sub_DropDownListCellModel * subCellModel in Bottoms)
        {
            
            [self.tableData addObject:subCellModel];
            
        }
        
    }
   
    [_DropDownBtn addTarget:self.vc action:@selector(SelectProtocolEvent:) forControlEvents:UIControlEventTouchUpInside];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Sub_DropdownListCell * cell =[tableView dequeueReusableCellWithIdentifier:DropdownListCell];
    
    [cell setModel:self.tableData[indexPath.row] tableviewCellRadius:tableViewRadius
    tableViewWidth:tableViewWidth
   tableViewheight:tableViewCellHeight
    iconImagewidth:IconImageWidth
   iconImageHeight:IconImageHeight
     RedPointWidth:RedPointWidth
    RedPointHeight:RedPointHeight];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    Sub_DropDownListCellModel * model = self.tableData[indexPath.row];

    NSString * DecodeString = model.eventString;
        
    [self.vc protocolCallback:DecodeString];
    
    //点击后隐藏下拉菜单
    self.DropDownBtn.isSelected = !self.DropDownBtn.isSelected;
    
    [self hiddenSubDropDownList];
}

//点击隐藏
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.DropDownBtn.isSelected = !self.DropDownBtn.isSelected;
    [self hiddenSubDropDownList];
}

//显示自己
-(void)showSubDropDownList
{

    self.hidden = NO;
    
    self.tableView.frame = CGRectMake(self.DropDownBtn.x + self.DropDownBtn.width, 64, 0, 0);

    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 1;
        self.tableView.frame = [self GetFrame];
        
    } completion:^(BOOL finished) {
        
        
    }];

}



//隐藏自己
-(void)hiddenSubDropDownList
{
    
    [UIView animateWithDuration:.3f animations:^{
        
        self.alpha = 0;
        self.tableView.frame = CGRectMake(self.DropDownBtn.x + self.DropDownBtn.width, 64, 0, 0);
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;

    }];

}

//重新设置tableview 位置
-(CGRect)GetFrame
{
    CGRect textsize;
    //取出最长宽度文字
    CGFloat intermediaryWidth = 0;
    //tableview宽度
    CGFloat tableWidth = 0;
    
    if (self.tableData.count > 0)
    {
        for (int i = 0; i < self.tableData.count; i ++ )
        {
            Sub_DropDownListCellModel * model = self.tableData[i];
            
            CGRect titlesize = [model.text boundingRectWithSize:CGSizeMake(self.tableView.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[model.fontsize floatValue]]} context:nil];
            
            textsize.size.width = titlesize.size.width > intermediaryWidth ? titlesize.size.width: intermediaryWidth;
            
            textsize.size.height = titlesize.size.height;
            
            intermediaryWidth = titlesize.size.width;
            
        }
        
        tableWidth = textsize.size.width  + tableViewRadius * 2;
        
        tableViewWidth = [self GetTableviewWidth:tableWidth];
        
        tableViewCellHeight =  textsize.size.height  * 2.2;
        
        self.tableView.rowHeight = tableViewCellHeight;
        
        tableViewHeight = self.tableData.count * tableViewCellHeight;
    }

    
    
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navgationBarHeight = self.vc.navigationController.navigationBar.height;
    
    CGFloat isX = self.DropDownBtn.x +self.DropDownBtn.width / 2;
    
    //上左
    if (isX < self.center.x && self.DropDownBtn.y < self.center.y)
    {
        x = self.DropDownBtn.x;
        
        y = navgationBarHeight + statusBarHeight;
        
    }
    //上右
    else if (isX > self.center.x && self.DropDownBtn.y < self.center.y)
    {
        x = self.DropDownBtn.x + self.DropDownBtn.width - tableViewWidth;
        
        y = navgationBarHeight + statusBarHeight;
    }
    //上中
    else if (isX  == self.center.x && self.DropDownBtn.y < self.center.y)
    {
        x = self.center.x - tableViewWidth / 2;
        
        y = navgationBarHeight + statusBarHeight;
    }
   
    //下左
    if (isX < self.center.x && self.DropDownBtn.y > self.center.y)
    {
        x = self.DropDownBtn.x;
        y = self.DropDownBtn.y + tableViewHeight;
    }
    //下右
    else if (isX > self.center.x && self.DropDownBtn.y > self.center.y)
    {
        x = self.DropDownBtn.x + self.DropDownBtn.width - tableViewWidth;
        y = self.DropDownBtn.y + tableViewHeight;
    }
    //下中
    else if (isX  == self.center.x && self.DropDownBtn.y > self.center.y)
    {
        x = self.center.x - self.DropDownBtn.width;
        y = self.DropDownBtn.y + tableViewHeight;
    }

    QFLOG(@" 计算tableViewCell  单行高度 %lf   计算tableview   高度   %lf  %lf   %lf" , tableViewCellHeight ,tableViewHeight,tableViewWidth,tableWidth);
    
    CGRect rect  = CGRectMake(x, y, tableViewWidth, tableViewHeight);
    return rect;
}
//动态计算tableview宽度
-(CGFloat)GetTableviewWidth:(CGFloat)tableWidth
{
   
    //留白宽度 根据有无图标计算具体留白 得到tablview 总宽度
    CGFloat superTableViewx  = 0;
    
    if (self.tableData.count > 0)
    {
        Sub_DropDownListCellModel * model = self.tableData[0];
        //判断是否存在图标
        if(![NSString isBlankString:model.iconImage])
        {
            UIImage * image =[UIImage imageNamed:model.iconImage];
            //设置图片跟红点宽高
            IconImageHeight = image.size.height;
            IconImageWidth  = image.size.width;
        }
        if (![NSString isBlankString:model.redPoint]) {
            
            RedPointWidth  = 14;
            RedPointHeight = 14;
        }

        superTableViewx = tableViewRadius;
        
    }
    //tablviewwidth = 留白宽度 + 计算出文字宽度 +图标宽度 + 红点宽度
    
    CGFloat tableviewWidth = superTableViewx + tableWidth + IconImageWidth + RedPointWidth;
    return tableviewWidth;
}



//绘图 三角形
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.tableData.count > 0) {
        
        Sub_DropDownListCellModel * model = self.tableData[0];
        UIColor *aColor = [UIColor setColor:model.backColor];
        CGContextRef context  = UIGraphicsGetCurrentContext();
        
        /*画三角形*/
        //只要三个点就行跟画一条线方式一样，把三点连接起来
        CGPoint sPoints[3];//坐标点
        CGFloat StatusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat x1;//左边的点x坐标
        CGFloat x2;//右边的点X坐标
        //约束画出的三角形坐标
        if ( self.DropDownBtn.width >= 44) {
            
            x1 = self.DropDownBtn.center.x - self.DropDownBtn.width / 4;
            x2 = self.DropDownBtn.center.x + self.DropDownBtn.width / 4;
        }
        else
        {
            x1 = self.DropDownBtn.center.x - 44 / 4;
            x2 = self.DropDownBtn.center.x + 44 / 4;
        }
        //x = 按钮中心x轴  y = 按钮图片Y轴 + 状态栏高度 + 图片高度 + 留白
        sPoints[0] =CGPointMake(self.DropDownBtn.center.x, self.DropDownBtn.y + StatusBarHeight + self.DropDownBtn.height / 2 + 10);//坐标1
        sPoints[1] =CGPointMake(x1,  StatusBarHeight +self.DropDownBtn.height);//坐标2
        sPoints[2] =CGPointMake(x2, StatusBarHeight +self.DropDownBtn.height);//坐标3
        
        CGContextAddLines(context, sPoints, 3);//添加线
        CGContextSetLineWidth(context, 0.0);//线的宽度
        CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
        CGContextClosePath(context);//封起来
        CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    }
 
}
@end
