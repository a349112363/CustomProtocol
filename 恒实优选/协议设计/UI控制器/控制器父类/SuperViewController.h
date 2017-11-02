//
//  SuperViewController.h
//  装修项目管理
//
//  Created by mmxd on 16/12/21.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCPermissionsEnum.h"

/**
 *  所有UI控制器的父类  包含一些子类中需要的公共参数
 */
@interface SuperViewController : UIViewController<UIGestureRecognizerDelegate,UISearchBarDelegate>
{
    VCPermissionsenum _vcp;

}

//添加在头部控制器容器
@property (nonatomic,strong) NSMutableArray * ControlLeftitems;
@property (nonatomic,strong) NSMutableArray * ControlRightitems;

@property (nonatomic,readonly) VCPermissionsenum vcp ;// 当前VC需要的权限



//所有控制器公共属性
//父类属性 子类调用父类属性
//@property (nonatomic,assign) BOOL isslide;//是否侧滑
//
//@property (nonatomic,assign) BOOL istransparent; //判断头部是否透明
////设置导航条背景色
//@property (nonatomic,copy) NSString * headbackgroundcolor;

/********************************************************************/

//在打开原生控制器的时候 通过反射赋值的方法给当前控制器赋值 所以在父类设置一个参数
@property (nonatomic,copy) NSString * eventstring;

//保存需要查看的本地图片
@property (nonatomic,strong) NSMutableDictionary *SaveLocalImage;
//取出本地图片 对应的key
@property (nonatomic,strong) NSMutableDictionary *SaveLocalImageKey;



/**
 *  提供给子类获取导航控制器背景view
 *
 *  @return 导航条背景view
 */
//-(UIView *)getNavgationBackgroundView;







@end
