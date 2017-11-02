//
//  ProtocolClass.m
//  注册协议跳转
//
//  Created by mmxd on 16/12/1.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "ProtocolClass.h"
//正则匹配协议
#define REGEX @"^([a-zA-Z]+://)|([a-zA-Z0-9]+\\.[a-zA-Z0-9\\.%\\-\\:]*)|(/+[/a-zA-Z0-9\\.%\\-\\_\u4e00-\u9fa5\\&\\=\\+\\/]*)|(\\?+[0-9a-zA-Z\u4e00-\u9fa5\\=\\-%\\&\\+\\-\\_\\/\\,\\.//[//]]*)$"

@interface ProtocolClass()

@property (nonatomic,strong) NSMutableArray * keys;//解析保存数据的所有key

@property (nonatomic,strong) NSMutableArray * values;//解析保存数据所有value


@end

@implementation ProtocolClass


/**
 *   基类构造函数中进行协议处理 2016-12-10 QF
 *
 *  @param urlstr 整个协议链接
 *  @param vc     获取当前控制器
 *
 *  @return self
 */
-(id)initWithStr:(NSString *)urlstr viewcontrol:(SuperViewController *)vc
{
    self = [super init];
    
    if (self) {
        
        self.keys =[[NSMutableArray alloc]init];
        
        self.values =[[NSMutableArray alloc]init];
        
        self.parameter =[[NSMutableDictionary alloc]init];
        
        self.protocolUtlStr = urlstr;
        
        self.protocolVC = vc;
        
        
        if ([CheckDataTool checkForProtocolstr:urlstr]) {
            //正则分割协议
            NSArray * protocols =[CheckDataTool baseCheckForProtocolstr:urlstr regEx:REGEX];
            
            if (protocols.count > 4)
            {
                QFLOG(@"--------------------------协议解析有错误");
            }
            else
            {
                switch (protocols.count) {
                    case 4:
                    {
                        self.Protocol = protocols[0];
                        self.ProtocolContext = protocols[1];
                        self.path = protocols[2];
                        self.parameterStr = protocols[3];
                        [self getValue];
                    }
                        break;
                    case 3:
                    {
                        self.Protocol=protocols[0];
                        self.ProtocolContext = protocols[1];
                        if ([[protocols[2] substringToIndex:1]isEqualToString:@"/"])
                        {
                            self.path =protocols[2];
                        }
                        else if ([[protocols[2] substringToIndex:1]isEqualToString:@"?"])
                        {
                            self.parameterStr = protocols[2];
                            [self getValue];
                        }
                        else
                        {
                            QFLOG(@"-----------------------协议有错误");
                        }
                    }
                        break;
                    case 2:
                    {
                        self.Protocol = protocols[0];
                        self.ProtocolContext=protocols[1];
                    }
                        break;
                    case 1:
                        QFLOG(@"-------------------------协议有错误");
                        break;
                    default:
                        break;
                }
            }
            
            QFLOG(@"正则分割协议protocols--------------------%@",protocols);
        }
        else
        {
            QFLOG(@"协议验证错误-----------------------%@",urlstr);
        }
        
    }
    return self;
}

/**
 *  获取解析协议后的参数 2016-12-10 QF
 */
-(void)getValue
{
    
    NSString * check = [self.parameterStr stringByReplacingOccurrencesOfString:@"?" withString:@""];
    
    QFLOG(@"%@",check);
    //对url 进行解码
    check =[NSString URLDecodedString:check];
    
    NSString * Decoding =[NSString URLDecodedString:check];
    
    QFLOG(@"获取协议参数解码Decoding-------------------%@",Decoding);
    //截取协议中的参数
    if ([Decoding rangeOfString:@"&"].location != NSNotFound){
        //得到所有截取&后的参数
        NSArray * dics =[Decoding componentsSeparatedByString:@"&"];
        
        for (int i = 0; i < dics.count; i++)
        {
            if ([dics[i] componentsSeparatedByString:@"="].count > 1){
                
                NSRange range =[dics[i] rangeOfString:@"="];
                
                if (range.location != NSNotFound)
                {
                    [self.keys addObject:[dics[i] substringToIndex:range.location]];
                    [self.values addObject:[dics[i] substringFromIndex:range.location+1]];
                }
                else
                {
                    QFLOG(@"-----------------------协议参数有误");
                }
            }
            else
            {
                QFLOG(@"-------------------传过来的参数不符合规则");
            }
        }
    }
    else
    {
        
        NSRange range =[Decoding rangeOfString:@"="];
        
        if (range.location !=NSNotFound)
        {
            [self.keys addObject:[Decoding substringToIndex:range.location]];
            [self.values addObject:[Decoding substringFromIndex:range.location+1]];
        }
        else
        {
            QFLOG(@"-------------------------协议参数有误");
        }
        
    }
    
    if (self.values.count == self.keys.count)
    {
        for (int i = 0; i < self.keys.count; i++){
            
            [self.parameter setObject:self.values[i] forKey:self.keys[i]];
        }
    }
    else
    {
        QFLOG(@"------------------------协议参数有错误");
    }
    
    
    QFLOG(@"%@  \n key===%@  \n value ====%@",self.parameter,self.keys,self.values);
    
}

/**
 *  协议解析的工厂方法 2016-12-10 QF
 *
 *  @param protocolStr 协议文本链接
 *  @param vc          当前控制器
 */
+(void)ProtocolFactroy:(NSString *) protocolStr vc:(SuperViewController *) vc
{
    
    //为了不让协议处理两次
    
    NSString * classname;
    
    if ([CheckDataTool checkForProtocolstr:protocolStr]) {
        //正则分割协议
        NSArray * protocols =[CheckDataTool baseCheckForProtocolstr:protocolStr regEx:REGEX];
        
        if (protocols.count > 4)
        {
            QFLOG(@"--------------------------协议解析有错误");
            
            return;
        }
        else
        {
            
            classname = protocols[1];
            
        }
        
        QFLOG(@"正则分割协议protocols--------------------%@",protocols);
    }
    else
    {
        QFLOG(@"协议验证错误-----------------------%@",protocolStr);
        return;
    }
    
    
    // ProtocolClass * prtocolclass = [[ProtocolClass alloc] initWithStr:protocolStr viewcontrol:vc];
    
    //反射出当前类 处理协议
    Class class = NSClassFromString([classname stringByReplacingOccurrencesOfString:@"." withString:@"_"]);
    
    ProtocolClass * prot =[[class alloc]initWithStr:protocolStr viewcontrol:vc];
    
    [prot run];
}

-(void)run
{
    /**
     *  在方法名前添加set 来匹配类方法 遍历字典 设置传进来的对象属性值
     *self 当前类自己
     *  @param key   当前类属性
     *  @param value 给类属性赋的值
     *  @param stop  类里面设置的方法
     *
     *  @return nil
     */
    [self.parameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        
        //统一将参数属性名大写改小写
        NSString * tolowerKey = [NSString toLower:key];
        
        NSString * method = [NSString stringWithFormat:@"set%@",tolowerKey];
        
        QFLOG(@"%@类\n tolower-%@ \n key-%@ \n value-%@  \n method-%@  \n self.protocolVC-%@ ",self,tolowerKey,key,value,method,self.protocolVC);
        
        //判断类中是否存在该属性  从子类 和父类中查找
        if ([NSString checkIsExistPropertyWithInstance:self.superclass verifyPropertyName:tolowerKey] || [NSString checkIsExistPropertyWithInstance:self.class verifyPropertyName:tolowerKey])
        {
            //找到类属性 给属性赋值
            [self setValue:value forKey:tolowerKey];
            
            if ([self respondsToSelector:NSSelectorFromString(method)])
            {
                SEL selector = NSSelectorFromString(method);
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self performSelector:selector];
            }
            else
            {
                QFLOG(@"方法找不到-------------------------%@" ,method);
            }
        }
        else
        {
            
            
            QFLOG(@"%@类----------------不存在该%@属性",self,tolowerKey);
        }
        
        
    }];
}

/**
 *  //通过传过来的控制器查找对应控件
 *
 *  @return 返回查找到的view 或者 创建的view
 */
-(id)findControl
{
    int tag = 0;
    id obj;
    NSString * action;
    NSString * position;
    //通过@“/”截取协议路径
    NSArray * strs =[self.path componentsSeparatedByString:@"/"];
    
    //协议路径只有一个的时候 直接查找对应tag 的控件
    if (strs.count ==2)
    {
        NSString * tagStr = [strs[1] stringByReplacingOccurrencesOfString:@"/" withString:@""];
        
        if ([CheckDataTool checkForNumber:tagStr]) {
            
            tag = [tagStr intValue];
            
            if (strs[1]) {
                
                self.isFindControl = YES;
                obj = [self.protocolVC.navigationController.navigationBar viewWithTag:tag];
                QFLOG(@"FindControl------------------------------tag  %d",tag);
            }
        }
        else
        {
            QFLOG(@"------------------------------tag值不是纯数字");
        }
    }
    else if (strs.count == 4)
    {
        tag = [[strs[3] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue] ;
        action = strs[1];
        position = strs[2];
        if (strs[3]) {
            //大小写转换
            action = [NSString toLower:action];
            position =[NSString toLower:position];
            if ([action isEqualToString:@"create"])
            {
                //创建一个控件 返回control
                obj = [self createControlposition:position tag:tag];
            }
            else
            {
                QFLOG(@"action匹配不正确-------------------------%@",action);
                
            }
        }
        
        //需要创建控件的时候
    }
    else if (strs.count == 3)
    {
        //需要创建控件的时候
        action = strs[1];
        position = strs[2];
        tag = [[strs[2] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue];
        //大小写转换
        action = [NSString toLower:action];
        position =[NSString toLower:position];
        if ([action isEqualToString:@"create"])
        {
            //创建一个控件 返回control
            obj = [self createControlposition:position tag:tag];
        }
        else
        {
            QFLOG(@"action匹配不正确-------------------------%@",action);
        }
        
    }
    else
    {
        QFLOG(@"协议路径有错误 --------------------%@",self.path);
    }
    QFLOG(@"查找的控件-----------------------%@",obj);
    return obj;
}

/**
 *  根据位置 在导航条上添加控件
 *
 *  @param position 控件摆放位置
 *  @param tag      控件tag值
 *
 *  @return 返回创建出来的控件
 */
-(id)createControlposition:(NSString *)position tag:(int)tag
{
    UIView * control = [self CreateControlView];
    
    control.tag = tag;
    //创建控件
    if(self.ProtocolContext)
    {
        self.ProtocolPosition = position;
        
        if ([position isEqualToString:@"headleft"])
        {
            
            UIBarButtonItem * item =[[UIBarButtonItem alloc]initWithCustomView:control];
            //用appdelegate 数组保存左侧数据 当页面变化打开新页面时候,记得清空数组
            [self.protocolVC.ControlLeftitems addObject:item];
            self.protocolVC.navigationItem.leftBarButtonItems =self.protocolVC.ControlLeftitems;
        
        }
        else if ([position isEqualToString:@"headright"])
        {
            
            UIBarButtonItem * item =[[UIBarButtonItem alloc]initWithCustomView:control];
            //用appdelegate 数组保存右侧数据  当页面变化打开新页面时候,记得清空数组
            [self.protocolVC.ControlRightitems addObject:item];
            self.protocolVC.navigationItem.rightBarButtonItems = self.protocolVC.ControlRightitems;
            
            
        }
        else if ([position isEqualToString:@"headcenter"])
        {
            self.protocolVC.navigationItem.titleView = control;

        }
        else if ([position isEqualToString:@"bodycenter"])
        {
            //添加在中心的弹窗
            [[AppDelegate appdelegate].window addSubview:control];
        }
        else if ([position isEqualToString:@"bodybottom"])
        {
            //添加在底部的滚轴
            [[AppDelegate appdelegate].window addSubview:control];
            
            //[self.protocolVC.view addSubview:control];
            
        }
        
    }
    QFLOG(@"返回创建的控件---------------%@  %@",control,position);
    return control;
}
/**
 *  创建控件基类方法
 *
 *  @return nil
 */
-(UIView *)CreateControlView
{
    return nil;
}

/**
 *  js回调方法
 */
-(void)setjscallback
{
    QFLOG(@"jscallbackencode-------------------%@  %@",self.jscallback,self);
    //对协议传过来的代码块进行base64解码
    if (![NSString  isBlankString:self.jscallback])
    {
        //获取base64明文参数
        NSString * DeCodeString = [NSString base64Decode:self.jscallback];
        
        QFLOG(@"jscallbackDecode----------------%@",DeCodeString);
        //找到当前控制器的webview 并且执行相应js代码块
        for ( id view in self.protocolVC.view.subviews)
        {
            if ([view isKindOfClass:[UIWebView class]] )
            {
                UIWebView * webview =(UIWebView *)view;
                [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@",DeCodeString]];
                return;
            }
        }
    }
}
/**
 *  替换协议参数中指定参数的特殊字符
 *
 *  @param param      指定替换参数
 *  @param paramkey   特殊字符值
 *  @param paramvalue 替换后的字符值
 */
-(void)paramrepalcebase64:(NSString *)param paramkey:(NSString *)paramkey paramvalue:(NSString *)paramvalue
{
    if (![NSString isBlankString:_parameter[param]]) {
        
        NSString * Decode =[[NSString base64Decode:_parameter[param]] stringByReplacingOccurrencesOfString:paramkey withString:paramvalue];
        
        _parameter[param] =[NSString base64encode:Decode];
        
        [self parameterStr];
        
        QFLOG(@"%@  %@  %@",Decode,_parameter[param],[self parameterStr]);
    }
    else
    {
        QFLOG(@"基类协议替换字符串参数为空-------------------%@",param);
    }
    
}

/**
 *  获取到替换参数后 拼接的协议
 *
 *  @return 返回一个拼接后的协议
 */
-(NSString *)protocolUtlStr
{
    if (self.parameter.count > 0)
    {
        _protocolUtlStr =[NSString stringWithFormat:@"%@%@%@?%@",_Protocol,_ProtocolContext,_path,self.parameterStr];
        
    }else
    {
        _protocolUtlStr =[NSString stringWithFormat:@"%@%@%@",_Protocol,_ProtocolContext,_path];
        
    }
    
    return _protocolUtlStr;
}

/**
 *  重新替换拼凑参数
 *
 *  @return 返回拼凑替换后的参数
 */
-(NSString *)parameterStr
{
    NSString * temp = @"";
    
    if (self.parameter.count > 0)
    {
        for (int i = 0; i < self.parameter.count; i++) {
            
            temp = [NSString stringWithFormat:@"%@=%@",self.parameter.allKeys[i],self.parameter[self.parameter.allKeys[i]]];
            
            if (i>0)
            {
                temp =[NSString stringWithFormat:@"&%@",temp];
            }
        }
        
        _parameterStr = temp;
    }
    
    return _parameterStr;
}

@end
