//
//  SubUI_DropdownList.h
//  装修项目管理
//
//  Created by mmxd on 16/12/7.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "YLButton.h"
//关联DropDownBtn 保存 SubUI_DropdownList 对象指针
@interface DropDownBtn : YLButton

@property (nonatomic,weak) id  subuidropdownlistid;

@property (nonatomic,assign) BOOL isSelected;

@end

/****
 SubUI_DropdownList
 *****/
@interface SubUI_DropdownList : UIView <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) DropDownBtn * DropDownBtn;

@property (nonatomic,strong) NSMutableArray * tableData;

@property (nonatomic,strong) NSString * menueJson;

@property (nonatomic,strong) WebViewController * vc;

-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc;

-(void)setMenueListValue;

-(void)hiddenSubDropDownList;

-(void)showSubDropDownList;


@end

/******** Sub_DropDownListCellModel ***********/


@interface Sub_DropDownListCellModel : NSObject

@property (nonatomic,strong) NSString * tag;
@property (nonatomic,strong) NSString * isHide;
@property (nonatomic,strong) NSString * text;
@property (nonatomic,strong) NSString * textColor;
@property (nonatomic,strong) NSString * fontsize;
@property (nonatomic,strong) NSString * backColor;
@property (nonatomic,strong) NSString * backImage;
@property (nonatomic,strong) NSString * iconImage;
@property (nonatomic,strong) NSString * eventString;
@property (nonatomic,strong) NSString * alpha;
@property (nonatomic,strong) NSString * redPoint;//小红点个数
@end


/*****Sub_DropdownListCell*********/
@interface Sub_DropdownListCell : UITableViewCell


@property (nonatomic,strong) UILabel * label; //菜单文字
@property (nonatomic,strong) UIImageView * menueImage;//下拉菜单图标
@property (nonatomic,strong) UIView * lineView;//下拉菜单线
@property (nonatomic,strong) UILabel * RedPoint;

@property (nonatomic,strong) Sub_DropDownListCellModel * model;

-(void)setModel:(Sub_DropDownListCellModel *)model tableviewCellRadius:(CGFloat)tableviewCellRadius
 tableViewWidth:(CGFloat)tableViewWidth
tableViewheight:(CGFloat)tableViewheigth
 iconImagewidth:(CGFloat)iconimageWidth
iconImageHeight:(CGFloat)iconImageHeight
  RedPointWidth:(CGFloat)RedPointWidth
 RedPointHeight:(CGFloat)RedPointHeight;

@end
