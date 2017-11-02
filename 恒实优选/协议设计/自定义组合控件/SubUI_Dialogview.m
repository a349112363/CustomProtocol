//
//  SubUI_Dialogview.m
//  装修项目管理
//
//  Created by mmxd on 17/1/11.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "SubUI_Dialogview.h"
#import "ProtocolClass.h"
#pragma mark Sub_DropDownListCellModel.m 数据模型类
@implementation SubUI_DialogButtonModel

-(id)init
{
    self = [super init];
    
    if (self) {
        
        self.fontsize = @"18.0f";
        self.textColor= @"000000";
        self.backColor = @"ffffff";
        
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

@interface SubUI_Dialogview()

@property (nonatomic,strong)UIView * centerView;

@end

@implementation SubUI_Dialogview
{
    
    CGFloat blankHeight;
    UILabel * titleLabel;
    CGFloat Digalogheight;
    //弹窗左右边距50
    CGFloat x ;
    //弹窗Y坐标
    CGFloat y;
    //弹窗宽度
    CGFloat Dialogwidth;
    
    CGFloat titlex;
    CGFloat btnHeight;
}
-(UIView *)centerView
{
    if (_centerView == nil) {
        
        //提示框
        _centerView=[[UIView alloc]init];
        // UIView * centerView=[[UIView alloc]initWithFrame:CGRectMake(x, y - height / 2, width, height)];
        _centerView.layer.cornerRadius = 5.0f;
        _centerView.clipsToBounds = YES;
        //centerView.backgroundColor =[UIColor setColor:self.dialogbackcolor];
        _centerView.backgroundColor =[UIColor whiteColor];
    }
    return _centerView;
}
//提示框数据源
-(NSMutableArray *)DialogButtonData
{
    if (_DialogButtonData == nil) {
        
        _DialogButtonData =[[NSMutableArray alloc]init];
    }
    return _DialogButtonData;
}

//初始化构造函数
-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc
{
    self =[super initWithFrame:frame];
    
    if (self) {
        
        self.vc = vc;
        
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        
    }
    return self;
}

//设置提示框 数据源
-(void)setMenueListValue
{
    if (![NSString isBlankString:self.menueJson])
    {
        NSArray * DialogButtonmenus =[Dataserialization JSONObjectWithData:self.menueJson];
        
        NSArray * Buttonmenus = [SubUI_DialogButtonModel mj_objectArrayWithKeyValuesArray:DialogButtonmenus];
        
        for (SubUI_DialogButtonModel * subDialogModel in Buttonmenus)
        {
            [self.DialogButtonData addObject:subDialogModel];
        }
    }

    self.closeable= YES;
    [self creatDialog];

}

-(void)creatDialog
{
    
    
    //弹窗左右边距50
    x = 50;
    //弹窗Y坐标
    y = self.centerY;
    //弹窗宽度
    Dialogwidth  = self.width - x * 2;
    //弹窗整体高度
    Digalogheight = 0;
    //内容之间留白间距
    blankHeight = 10;
    //按钮高度
    btnHeight = 0;
    //当设置按钮才设置按钮高度
    if (self.DialogButtonData.count > 0) {
        
        btnHeight  = 30;
    }
    
    //标题提示高度
    
    CGFloat titleHeight  = [self.title boundingRectWithSize:CGSizeMake(Dialogwidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[self.titlefontsize floatValue]]} context:nil].size.height;
    
    UIButton * closebtn;
    if (self.closeable) {
        
        closebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closebtn setImage:[UIImage imageNamed:@"closeBtn_Icon"] forState:UIControlStateNormal];
        CGFloat btnImageWidth = closebtn.imageView.image.size.width;
        CGFloat btnImageHeight = closebtn.imageView.image.size.height;
        closebtn.frame = CGRectMake(Dialogwidth / 2,0, Dialogwidth / 2,btnImageHeight + 10);
        closebtn.imageEdgeInsets = UIEdgeInsetsMake(5, Dialogwidth / 2 - btnImageWidth - 10, 0, 0);
        [closebtn addTarget:self action:@selector(closeclick) forControlEvents:UIControlEventTouchUpInside];
        [self.centerView addSubview:closebtn];
    }
    
    titlex = 15;
    //标题提示
    titleLabel =[UILabel setLabelTitle:self.title
                                         setFont:[self.titlefontsize floatValue]
                                        setframe:CGRectMake(titlex,5 + closebtn.height+closebtn.y, Dialogwidth-titlex * 2, titleHeight)
                                     setposition:ControlPositionCenter
                                       setweight:0
                                setnumberOfLines:0
                                   settitlecolor:self.titlecolor];
    [self.centerView addSubview:titleLabel];
    
    
     UIWebView * webview =[[UIWebView alloc]initWithFrame:CGRectMake(titleLabel.x, titleLabel.y + titleLabel.height+blankHeight, titleLabel.width,blankHeight * 3 )];
    webview.scrollView.bounces = NO;
    webview.scrollView.showsHorizontalScrollIndicator = NO;
    webview.scrollView.showsVerticalScrollIndicator = NO;
    webview.backgroundColor =self.centerView.backgroundColor;
    webview.opaque = NO;
    webview.delegate = self;
    [webview loadHTMLString:self.content baseURL:nil];
    [self.centerView addSubview:webview];
    
    [self addSubview:self.centerView];
}

//点击关闭按钮事件
-(void)closeclick
{
    [self removeDialogview];
}

//创建弹窗按钮
-(void)creatDialogBtn
{
    UIButton * DialogBtn;
    //按钮
    if (self.DialogButtonData.count == 2) {
        
        for (int i = 0; i < self.DialogButtonData.count; i ++) {
            
            SubUI_DialogButtonModel * model = self.DialogButtonData[i];
            
            CGRect rect = CGRectMake((titleLabel.width / 2 + titlex ) * i  + titlex, self.centerView.height - btnHeight - 15, titleLabel.width / 2-titlex, btnHeight);
            
            DialogBtn =[UIButton setBtnTitle:model.text
                                    setImage:nil
                                setbackimage:nil
                                     setFont:[model.fontsize floatValue]
                                    setframe:rect
                                      settag:[model.tag intValue]
                                 setposition:ControlPositionCenter
                                   setweight:0
                               settitlecolor:model.textColor];
            [self setBtnLayer:DialogBtn andModel:model];
            
        }
    }
    else if (self.DialogButtonData.count == 1)
    {
        SubUI_DialogButtonModel * model = self.DialogButtonData[0];
        
        CGRect rect = CGRectMake(50, self.centerView.height - btnHeight - 15, Dialogwidth-100, btnHeight);
        DialogBtn =[UIButton setBtnTitle:model.text
                                setImage:nil
                            setbackimage:nil
                                 setFont:[model.fontsize floatValue]
                                setframe:rect
                                  settag:[model.tag intValue]
                             setposition:ControlPositionCenter
                               setweight:0
                           settitlecolor:model.textColor];
        
        [self setBtnLayer:DialogBtn andModel:model];
    }
    else
    {
        QFLOG(@"传过来提示框不需要显示按钮");
    }
}


-(void)setBtnLayer:(UIButton *)DialogBtn andModel:(SubUI_DialogButtonModel *)model
{
    DialogBtn.layer.cornerRadius = 5.0f;
    DialogBtn.clipsToBounds = YES;
    DialogBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    DialogBtn.layer.borderWidth = 0.5f;
    DialogBtn.backgroundColor =[UIColor setColor:model.backColor];
    [DialogBtn addTarget:self action:@selector(DialogbtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerView addSubview:DialogBtn];
}

//点击提示框按钮执行事件
-(void)DialogbtnClickEvent:(UIButton *)sender
{
    [self removeDialogview];
    SubUI_DialogButtonModel * model = self.DialogButtonData[0];
    QFLOG(@"%ld  %ld",sender.tag,[model.tag integerValue]);
    NSInteger number = sender.tag > [model.tag integerValue] ? sender.tag - [model.tag integerValue] : [model.tag integerValue] - sender.tag;
    //前端弹窗tag 暂时是以10 为间隔 之后改进
    if (number < self.DialogButtonData.count) {
        
        SubUI_DialogButtonModel * model = self.DialogButtonData[number];
        
        //需要告诉前端  在menus的时候 整体都已经加密 所有evensting不用加密也行
        NSString * DecodeString = [NSString base64Decode:model.eventString];
        
        QFLOG(@"%@",DecodeString);
        
        [self.vc protocolCallback:DecodeString];
        
    }
    else
    {
        QFLOG(@"弹出框按钮tag值不对----------%ld",sender.tag);
    }
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat _webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue] + 20;
    
    webView.frame = CGRectMake(titleLabel.x, titleLabel.y + titleLabel.height+blankHeight, titleLabel.width, _webViewHeight+ blankHeight * 3);
    
    //提示框整个高度
    Digalogheight  =  titleLabel.y + titleLabel.height + blankHeight * 4 + _webViewHeight + btnHeight;
    
    QFLOG(@"%lf  %lf  %lf",Digalogheight,_webViewHeight,btnHeight);
    //提示框整个高度
    self.centerView.frame = CGRectMake(x, y - Digalogheight / 2, Dialogwidth, Digalogheight);
    
    [self creatDialogBtn];
}

-(void)removeDialogview
{
    [UIView animateWithDuration:0.2 animations:^{
        
        self.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}


@end
