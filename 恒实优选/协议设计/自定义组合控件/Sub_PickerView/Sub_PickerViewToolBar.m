//
//  Sub_PickerViewToolBar.m
//  PickerView
//
//  Created by mmxd on 17/1/18.
//  Copyright © 2017年 WTC. All rights reserved.
//

#define ToolHeight 30

#import "Sub_PickerViewToolBar.h"

@implementation Sub_ToolBarBtnModel

-(id)init
{
    self = [super init];
    
    if (self) {
        
        self.fontsize = @"16.0f";
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

@interface Sub_PickerViewToolBar()

@property (strong, nonatomic) UIButton *doneBtn;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UILabel *label;

@property (copy, nonatomic) BtnAction doneAction;
@property (copy, nonatomic) BtnAction cancelAction;

@end

@implementation Sub_PickerViewToolBar

-(NSMutableArray *)datamenus
{
    if (_datamenus == nil) {
        
        _datamenus =[[NSMutableArray alloc]init];
    }
    
    return _datamenus;
}
- (instancetype)initWithToolbarcancelAction:(BtnAction)cancelAction doneAction:(BtnAction)doneAction {
    if (self = [super init]) {
        _doneAction = [doneAction copy];
        _cancelAction = [cancelAction copy];
        self.backgroundColor =[UIColor whiteColor];
        [self createLabel];
    }
    
    return self;
}

-(void)createDonbtn
{
    Sub_ToolBarBtnModel * model = self.datamenus[0];
    self.doneBtn = [UIButton setBtnTitle:model.text
                                setImage:model.iconImage
                            setbackimage:model.backImage
                                 setFont:[model.fontsize floatValue]
                                setframe:CGRectMake(IPHONE_WIDTH-60, 0, 50, ToolHeight)
                                  settag:[model.tag intValue]
                             setposition:ControlPositionCenter
                               setweight:0
                           settitlecolor:model.textColor];
    
    [self.doneBtn addTarget:self action:@selector(doneBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.doneBtn];
   
}

-(void)createCancelbtn
{
    Sub_ToolBarBtnModel * model = self.datamenus[1];
    self.cancelBtn = [UIButton setBtnTitle:model.text
                                setImage:model.iconImage
                            setbackimage:model.backImage
                                 setFont:[model.fontsize floatValue]
                                setframe:CGRectMake(10, 0, 50, ToolHeight)
                                  settag:[model.tag intValue]
                             setposition:ControlPositionCenter
                               setweight:0
                           settitlecolor:model.textColor];

    [self.cancelBtn addTarget:self action:@selector(cancelBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];

}

-(void)createLabel
{
 
    UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, ToolHeight)];
    label.textAlignment = NSTextAlignmentCenter;
    
    self.label = label;
    [self addSubview:self.label];

}

//设置tableview 数据源
-(void)setMenueListValue
{
    if (![NSString isBlankString:self.menus])
    {
        NSArray * Bottoms = [Sub_ToolBarBtnModel mj_objectArrayWithKeyValuesArray:[Dataserialization JSONObjectWithData:self.menus]];
        
        for (Sub_ToolBarBtnModel * subBtnModel in Bottoms)
        {
            [self.datamenus addObject:subBtnModel];
        }
        if (Bottoms.count > 1) {
            
            [self createCancelbtn];
        }

        [self createDonbtn];
    }
    
}

- (void)doneBtnOnClick:(UIButton *)btn {
    if (self.doneAction) {
        self.doneAction(btn);
    }
}

- (void)cancelBtnOnClick:(UIButton *)btn {
    if (self.cancelAction) {
        self.cancelAction(btn);
    }
}

@end
