//
//  Sub_InputBox.m
//  装修项目管理
//
//  Created by mmxd on 17/2/18.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Sub_InputBox.h"
#import "ZYKeyboardUtil.h"
#import "CheckDataTool.h"

#define BlankWidth  10 //留白间隙
#define InputViewHeight 35//默认输入框高度
#define SenderBtnwidth 60//默认按钮宽度
#define SenderBtnHeight 35//默认按钮高度

@implementation QFTextView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textLable =[[UILabel alloc]initWithFrame:frame];
        self.textLable.textColor = [UIColor lightGrayColor];
        [self addSubview:self.textLable];
    }
    return self;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    self.textLable.text = placeholder;
    
}

@end


@interface Sub_InputBox()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong) UIView * backgroundViwe;

@property (nonatomic,strong) UIView * inputView;

@property (nonatomic,strong) UIButton * senderBtn;

@property (nonatomic,strong) UILabel *messageLabel;

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

@property (nonatomic,strong) QFTextView * textView;

@end

@implementation Sub_InputBox
{
    NSInteger deltaY; //键盘高度
    CGFloat TextSizeHeight;//记录输入文字高度
}
-(id)initWithFrame:(CGRect)frame vc:(SuperViewController *)vc;
{
    self = [super initWithFrame:frame];
    if (self) {

        self.vc = vc;
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return self;
}

//整个背景view
-(UIView *)backgroundViwe
{
    if (_backgroundViwe == nil) {
        
        CGFloat backHeight = TextSizeHeight + BlankWidth * 2;
        QFLOG(@"%lf",backHeight);
        _backgroundViwe =[[UIView alloc]initWithFrame:CGRectMake(0, self.height - backHeight, self.width, backHeight)];
        _backgroundViwe.backgroundColor =[UIColor whiteColor];
    }
    
    return _backgroundViwe;
}

//输入框背景view
-(UIView *)inputView
{
    if (_inputView == nil) {
        
        _inputView =[[UIView alloc]initWithFrame:CGRectMake(5, BlankWidth, self.width - BlankWidth * 2 - SenderBtnwidth, TextSizeHeight)];
        _inputView.backgroundColor  =[UIColor whiteColor];
        _inputView.layer.cornerRadius = 5;
        _inputView.clipsToBounds = YES;
        _inputView.layer.borderWidth = 0.5;
        _inputView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
    }
    
    return _inputView;
}
//输入框
-(QFTextView *)textView
{
    if (_textView == nil) {

        _textView =[[QFTextView alloc]initWithFrame:CGRectMake(5, 0, self.inputView.width - BlankWidth, TextSizeHeight)];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.delegate = self;
        _textView.placeholder =self.placeholder;

        //判断输入框是否存在文字  存在就隐藏默认提示文字
        if (![NSString isBlankString:self.text]) {
            
            _textView.text = self.text;
            _textView.textLable.hidden = YES;
        }
        else
        {
            _textView.textLable.hidden = NO;
        }
        
        //选择键盘类型
        if ([self.keyboardType isEqualToString:@"phone"]) {
            
            _textView.keyboardType = UIKeyboardTypePhonePad;
        }
        else if ([self.keyboardType isEqualToString:@"number"])
        {
            _textView.keyboardType = UIKeyboardTypeNumberPad;
        }
        else
        {
            _textView.keyboardType = UIKeyboardTypeDefault;
        }
    }
    
    return _textView;
}
//发送按钮创建
-(UIButton *)senderBtn
{
    if (_senderBtn == nil) {
        
        _senderBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _senderBtn.frame = CGRectMake(self.inputView.x + self.inputView.width + BlankWidth, self.inputView.y + self.inputView.height - SenderBtnHeight, SenderBtnwidth, SenderBtnHeight);
        _senderBtn.backgroundColor =[UIColor setColor:self.buttonbackgroundcolor];
        [_senderBtn setTitle:self.buttontext forState:UIControlStateNormal];
        [_senderBtn addTarget:self action:@selector(senderBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _senderBtn.titleLabel.font =[UIFont systemFontOfSize:[self.buttonfontsize floatValue]];
        _senderBtn.layer.cornerRadius = 5;
        _senderBtn.clipsToBounds = YES;
    }
    
    return _senderBtn;
}

//提示消息
-(UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        
        _messageLabel =[[UILabel alloc]init];
        
        _messageLabel.text =[NSString stringWithFormat:@"提示* 这是一个测试"];
        
        _messageLabel.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        _messageLabel.font = [UIFont systemFontOfSize:14];
        
        _messageLabel.textColor =[UIColor redColor];
        
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}
//显示输入框
-(void)showInput
{
    NSString *regEx = @"^[0-9]*$";
    self.regex = regEx;
    //判断默认文字是否存在 存在则计算输入框实际高度
    if (![NSString isBlankString:self.text]) {
        
        TextSizeHeight = [self ComparisonSizeFrame:self.text];
    }
    else
    {
        TextSizeHeight = InputViewHeight;
    }
    
    QFLOG(@"%lf",TextSizeHeight);
    [self.inputView addSubview:self.textView];
    [self.backgroundViwe addSubview:self.inputView];
    [self.backgroundViwe addSubview:self.senderBtn];
    [self addSubview:self.backgroundViwe];

    //[self addSubview:self.messageLabel];
    //键盘弹起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.textView becomeFirstResponder];
}

//点击按钮事件
-(void)senderBtnClick
{
   [self setjscallback];
}

//点击收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self endEditing:YES];
        self.alpha = 0;
    
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter] removeObserver:self];

    }];
}

//通知键盘弹起
-(void)keyBoardShow:(NSNotification *)note{
    
    NSDictionary *info = note.userInfo;
    CGRect keyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    keyBoardFrame = [self convertRect:keyBoardFrame toView:nil];
    deltaY = keyBoardFrame.size.height;
    [UIView animateWithDuration:duration delay:0 options:[[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16 animations:^{
        self.backgroundViwe.transform = CGAffineTransformMakeTranslation(0, -deltaY);
        
    } completion:nil];
    
}
//通知键盘隐藏
-(void)keyBoardHide:(NSNotification *)note{
    
    self.backgroundViwe.transform = CGAffineTransformIdentity;
}

//点击按钮后 将输入参数回调给前端
-(void)setjscallback
{
    
//    QFLOG(@"%@  %@",self.regex,self.errormessage);
//    
//    self.regex = [NSString base64Decode:self.regex];
//    
//    //匹配正则 错误的情况下弹出提示
//    if (![CheckDataTool baseCheckForRegEx:self.regex data:self.textView.text]) {
//        
//        //当弹窗存在 防止重复点击
//        if (self.messageLabel.y !=self.backgroundViwe.y - 30) {
//            
//            self.messageLabel.frame = CGRectMake(0, self.backgroundViwe.y, self.width, 30);
//            
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                self.messageLabel.frame = CGRectMake(0, self.backgroundViwe.y - 30, self.width, 30);
//                
//            }completion:^(BOOL finished) {
//                
//            }];
//        }
//        
//        return;
//        
//    }
//  

    [self.textView resignFirstResponder];
    [self.vc setjscallback:[NSString base64Decode:self.jscallback] Replacing:self.textView.text rangOfString:@"#inputbox#"];
    
    [UIView animateWithDuration:0.2 animations:^{
       
        self.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter] removeObserver:self];

    }];
}

//监控textview 输入状态 处理相应事情
- (void)textViewDidChange:(UITextView *)textView{
    
    //得到输入框实际高度
    CGFloat inputHeight = [self ComparisonSizeFrame:textView.text];
    //输入框后面整个viewY轴
    CGFloat backviewY = self.height- (inputHeight + BlankWidth * 2 + deltaY);
    
    CGFloat backviewHeight =inputHeight + BlankWidth * 2;

    //按钮x 轴
    CGFloat Btnx = self.inputView.x + self.inputView.width + BlankWidth;
    //输入框背景view宽度
    CGFloat InputWidth = self.width - BlankWidth * 2 - SenderBtnwidth;
    //输入框宽度
    CGFloat TextViewWidth = self.inputView.width - BlankWidth;
    
    //当弹窗存在的时候 操作textview 将隐藏消息弹窗
//    if (self.messageLabel.y == self.backgroundViwe.y - 30) {
//            
//        self.messageLabel.frame = CGRectMake(0, self.backgroundViwe.y - 30, self.width, 30);
//            
//        [UIView animateWithDuration:0.5 animations:^{
//                
//            self.messageLabel.frame = CGRectMake(0,self.backgroundViwe.y, self.width, 0);
//                
//        }];
//    }

    
    if (textView.text.length == 0) {
        
        //禁止滑动和显示默认文字
        self.textView.scrollEnabled = NO;
        self.textView.textLable.hidden = NO;
        
        //重新调整textView的高度
        self.inputView.frame =CGRectMake(5, BlankWidth, InputWidth, inputHeight);
        self.textView.frame =CGRectMake(5, 0, TextViewWidth, inputHeight);
        self.senderBtn.frame = CGRectMake(Btnx, self.inputView.y + self.inputView.height - SenderBtnHeight, SenderBtnwidth, SenderBtnHeight);
        self.backgroundViwe.frame =CGRectMake(0, backviewY, self.width,backviewHeight);
    }
    else
    {
        //允许滑动 隐藏默认文字
        self.textView.scrollEnabled = YES;
        self.textView.textLable.hidden = YES;
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.inputView.frame =CGRectMake(5,BlankWidth,InputWidth,inputHeight);
            //重新调整textView的高度
            self.textView.frame =CGRectMake(5,0,TextViewWidth,inputHeight);
            self.senderBtn.frame = CGRectMake(Btnx, self.inputView.y + self.inputView.height - SenderBtnHeight, SenderBtnwidth, SenderBtnHeight);
            self.backgroundViwe.frame =CGRectMake(0, backviewY, self.width,backviewHeight);
        }];
        
    }
}

//点击键盘return 按钮执行事件
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) //获取键盘中发送事件（回车事件）
    {
        [self setjscallback];
    }
    
    return YES;
}

//传如文字 计算实际实际高度 返回
-(CGFloat )ComparisonSizeFrame:(NSString *)text
{

    CGSize constraintSize;
    constraintSize.width = self.width - BlankWidth * 3 - SenderBtnwidth;
    constraintSize.height = MAXFLOAT;
    CGFloat Height = 0;
    CGSize sizeframe = [text boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    if (sizeframe.height > InputViewHeight) {
        
        if (sizeframe.height > 100) {
            
            sizeframe.height = 100;
        }
        
        Height = sizeframe.height;
    }
    else
    {
        Height = InputViewHeight;
    }
    
    return Height;
}
@end
