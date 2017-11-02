//
//  MSSBrowseBaseViewController.h
//  MSSBrowse
//
//  Created by 于威 on 16/4/26.
//  Copyright © 2016年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "MSSBrowseCollectionViewCell.h"
#import "MSSBrowseModel.h"

@interface PictureViewController : SuperViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIViewControllerTransitioningDelegate>

@property (nonatomic,assign)BOOL isEqualRatio;// 大小图是否等比（默认为等比）

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,assign)CGFloat screenWidth;
@property (nonatomic,assign)CGFloat screenHeight;
@property (nonatomic,assign) int currentindex;
/**
 *  通过协议参数赋值，得到图片集合,标识
 */
@property (nonatomic,strong) NSString * picturestr;


@property (nonatomic,strong) NSString * group;


// 获取指定视图在window中的位置
- (CGRect)getFrameInWindow:(UIView *)view;



@end
