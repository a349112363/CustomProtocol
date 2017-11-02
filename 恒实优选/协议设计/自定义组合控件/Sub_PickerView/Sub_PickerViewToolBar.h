//
//  Sub_PickerViewToolBar.h
//  PickerView
//
//  Created by mmxd on 17/1/18.
//  Copyright © 2017年 WTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sub_ToolBarBtnModel : NSObject

@property (nonatomic,strong) NSString * tag;
@property (nonatomic,strong) NSString * text;
@property (nonatomic,strong) NSString * textColor;
@property (nonatomic,strong) NSString * fontsize;
@property (nonatomic,strong) NSString * backColor;
@property (nonatomic,strong) NSString * backImage;
@property (nonatomic,strong) NSString * iconImage;
@property (nonatomic,strong) NSString * jsCallBack;


@end

@interface Sub_PickerViewToolBar : UIView

typedef void(^BtnAction)();
@property (strong, readonly, nonatomic) UIButton *doneBtn;
@property (strong, readonly, nonatomic) UIButton *cancelBtn;
@property (strong, readonly, nonatomic) UILabel *label;
@property (nonatomic,strong) NSString * menus;
@property (nonatomic,strong) NSMutableArray * datamenus;

- (instancetype)initWithToolbarcancelAction:(BtnAction)cancelAction doneAction:(BtnAction)doneAction;

-(void)setMenueListValue;

@end
