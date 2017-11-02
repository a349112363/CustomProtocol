//
//  MSSBrowseBaseViewController.m
//  MSSBrowse
//
//  Created by 于威 on 16/4/26.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "PictureViewController.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "UIImage+MSSScale.h"
#import "MSSBrowseRemindView.h"
#import "MSSBrowseActionSheet.h"
#import "MSSBrowseDefine.h"

#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@interface PictureViewController ()

@property (nonatomic,strong)NSArray *browseItemArray;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,assign)BOOL isRotate;// 判断是否正在切换横竖屏
@property (nonatomic,strong)UILabel *countLabel;// 当前图片位置
@property (nonatomic,strong)UIView *snapshotView;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,assign)UIDeviceOrientation currentOrientation;
@property (nonatomic,strong)MSSBrowseActionSheet *browseActionSheet;
@property (nonatomic,strong)MSSBrowseRemindView *browseRemindView;

@end

@implementation PictureViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _isEqualRatio = YES;
        _screenWidth = MSS_SCREEN_WIDTH;
        _screenHeight = MSS_SCREEN_HEIGHT;
        _currentOrientation = UIDeviceOrientationPortrait;
        
        

    }
    return self;
}


- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  //  self.getNavgationBackgroundView.alpha = 1;

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
//    self.navigationItem.title = @"图片浏览";
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0f]}];
    
  //  self.getNavgationBackgroundView.alpha = 0;
    
    
    [self getbrowseItemArray];
    [self createBrowseView];
}



//解析数据后 获取图片数据
-(void)getbrowseItemArray
{
    _currentIndex = self.currentindex;
    
    if (![NSString isBlankString:self.picturestr]) {
        
        NSString * decode =[NSString base64Decode:self.picturestr];
        
        NSArray  * pictures =[Dataserialization JSONObjectWithData:decode];
                
        NSMutableArray * browseItemArray =[NSMutableArray array];
        
        MSSBrowseModel *browseItem ;
        if (pictures.count > 0) {
            
            for(int i = 0;i < pictures.count;i++)
            {
                //对图片链接中有\\进行过滤，防止出现加载失败
                NSString * pic = [pictures[i] stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
                
                browseItem = [[MSSBrowseModel alloc]init];
                
                if ([pic hasPrefix:@"http"] || [pic hasPrefix:@"https"]) {
                    
                    browseItem.bigImageUrl = pic;// 加载网络图片大图地址
                    
                    [browseItemArray addObject:browseItem];
                }
            }
        }
        //取出保存图片字典中的第几组
        if (![NSString isBlankString:self.group]) {
            
            if ([[self.SaveLocalImage objectForKey:self.group] count] > 0) {
                
                for(int j = 0;j < [[self.SaveLocalImage objectForKey:self.group] count];j++)
                {
                    browseItem = [[MSSBrowseModel alloc]init];
                    //获取沙盒路径
                   // NSString *filePath=[self filePath:[self.SaveLocalImage objectForKey:self.group][j]];
                    
                 
                    QFLOG(@"---------- %@",[self.SaveLocalImage objectForKey:self.group][j]);

                    //根据路径读取image
                   // browseItem.bigImage=[UIImage imageWithContentsOfFile:filePath];
                    browseItem.bigImage =[UIImage imageWithData:[self.SaveLocalImage objectForKey:self.group][j]];// 加载本地图片
                    
                    [browseItemArray addObject:browseItem];
                }
            }
        }

        _browseItemArray = browseItemArray;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];

}
#pragma mark----获取沙盒路径
-(NSString *)filePath:(NSString *)fileName
{
    //获取沙盒目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //保存文件名称
    NSString *filePath=[paths[0] stringByAppendingPathComponent:fileName];
    
    return filePath;
}

// 获取指定视图在window中的位置
- (CGRect)getFrameInWindow:(UIView *)view
{
    // 改用[UIApplication sharedApplication].keyWindow.rootViewController.view，防止present新viewController坐标转换不准问题
    return [view.superview convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}

- (void)createBrowseView
{
    self.view.backgroundColor = [UIColor blackColor];
    if(_snapshotView)
    {
        _snapshotView.hidden = YES;
        [self.view addSubview:_snapshotView];
    }
    
    //背景界面
    _bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    _bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgView];
    
    
    //图片加载背景view上
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    // 布局方式改为从上至下，默认从左到右
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // Section Inset就是某个section中cell的边界范围
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 每行内部cell item的间距
    flowLayout.minimumInteritemSpacing = 0;
    // 每行的间距
    flowLayout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _screenWidth + kBrowseSpace, _screenHeight) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor blackColor];
    [_collectionView registerClass:[MSSBrowseCollectionViewCell class] forCellWithReuseIdentifier:@"NetworkImageCell"];
    [_collectionView registerClass:[MSSBrowseCollectionViewCell class] forCellWithReuseIdentifier:@"LocalImageCell"];

    _collectionView.contentSize = CGSizeMake(_browseItemArray.count * (_screenWidth + kBrowseSpace), 0);
    _collectionView.contentOffset = CGPointMake(_currentIndex * (_screenWidth + kBrowseSpace), 0);
    [_bgView addSubview:_collectionView];
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.frame = CGRectMake(0, _screenHeight - 50, _screenWidth, 50);
    _countLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)_currentIndex + 1,(long)_browseItemArray.count];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_countLabel];
    
    //显示提示的view
    _browseRemindView = [[MSSBrowseRemindView alloc]initWithFrame:_bgView.bounds];
    [_bgView addSubview:_browseRemindView];
}


#pragma mark UIColectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSBrowseModel *browseItem = [_browseItemArray objectAtIndex:indexPath.row];
    MSSBrowseCollectionViewCell *cell;

    //网络图片cell  和 本地图片cell
    if(browseItem.bigImageUrl)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NetworkImageCell" forIndexPath:indexPath];
     
    }
    else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LocalImageCell" forIndexPath:indexPath];

    }
    
    if (cell) {
        
         // 还原初始缩放比例
        cell.zoomScrollView.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
        cell.zoomScrollView.zoomScale = 1.0f;
        // 将scrollview的contentSize还原成缩放前
        cell.zoomScrollView.contentSize = CGSizeMake(_screenWidth, _screenHeight);
        //
        [cell.loadingView mss_setFrameInSuperViewCenterWithSize:CGSizeMake(30, 30)];
        CGRect bigImageRect = CGRectZero;
        //加载图片
        [self loadBrowseImageWithBrowseItem:browseItem Cell:cell bigImageRect:bigImageRect];
    
        __weak __typeof(self)weakSelf = self;
        //点击cell 执行的block
        [cell tapClick:^(MSSBrowseCollectionViewCell *browseCell) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf tap:browseCell];
        }];
        
        //cell 长按执行block
        [cell longPress:^(MSSBrowseCollectionViewCell *browseCell) {
            
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            if([[SDImageCache sharedImageCache]diskImageExistsWithKey:browseItem.bigImageUrl])
            {
                [strongSelf longPress:browseCell];
            }
        }];
    }
    return cell;
}

// 子类重写此方法
- (void)loadBrowseImageWithBrowseItem:(MSSBrowseModel *)browseItem Cell:(MSSBrowseCollectionViewCell *)cell bigImageRect:(CGRect)bigImageRect
{
    // 停止加载
    [cell.loadingView stopAnimation];
    
    //查看本地图片
    if (browseItem.bigImage)
    {
        cell.zoomScrollView.zoomImageView.image = browseItem.bigImage;
        CGRect bigRect = [self getBigImageRectIfIsEmptyRect:bigImageRect bigImage:cell.zoomScrollView.zoomImageView.image];
        cell.zoomScrollView.zoomImageView.frame = bigRect;
    }
    else
    {
        
        // 判断大图是否存在
        if([[SDImageCache sharedImageCache]diskImageExistsWithKey:browseItem.bigImageUrl])
        {
            // 显示大图
            [self showBigImage:cell.zoomScrollView.zoomImageView browseItem:browseItem rect:bigImageRect];
        }
        // 如果大图不存在
        else
        {
            // 加载大图
            [self loadBigImageWithBrowseItem:browseItem cell:cell rect:bigImageRect];
  
        }
        
    }
}

- (void)showBigImage:(UIImageView *)imageView browseItem:(MSSBrowseModel *)browseItem rect:(CGRect)rect
{
    // 取消当前请求防止复用问题
    [imageView sd_cancelCurrentImageLoad];
    // 如果存在直接显示图片
    imageView.image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:browseItem.bigImageUrl];
    // 当大图frame为空时，需要大图加载完成后重新计算坐标
    CGRect bigRect = [self getBigImageRectIfIsEmptyRect:rect bigImage:imageView.image];

    imageView.frame = bigRect;

}

// 加载大图
- (void)loadBigImageWithBrowseItem:(MSSBrowseModel *)browseItem cell:(MSSBrowseCollectionViewCell *)cell rect:(CGRect)rect
{
    UIImageView *imageView = cell.zoomScrollView.zoomImageView;
    //            // 加载圆圈显示
    [cell.loadingView startAnimation];
    //
    [imageView sd_setImageWithURL:[NSURL URLWithString:browseItem.bigImageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 关闭图片浏览view的时候，不需要继续执行小图加载大图动画
        if(self.collectionView.userInteractionEnabled)
        {
            // 停止加载
            [cell.loadingView stopAnimation];
            if(error)
            {
                [self showBrowseRemindViewWithText:@"图片加载失败"];
            }
            else
            {
                // 当大图frame为空时，需要大图加载完成后重新计算坐标
                CGRect bigRect = [self getBigImageRectIfIsEmptyRect:rect bigImage:image];
                // 图片加载成功
                imageView.frame = bigRect;
                
            }
        }
    }];

}

// 当大图frame为空时，需要大图加载完成后重新计算坐标
- (CGRect)getBigImageRectIfIsEmptyRect:(CGRect)rect bigImage:(UIImage *)bigImage
{
    if(CGRectIsEmpty(rect))
    {
        return [bigImage mss_getBigImageRectSizeWithScreenWidth:self.screenWidth screenHeight:self.screenHeight ];
    }
    return rect;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _browseItemArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_screenWidth + kBrowseSpace, _screenHeight);
}

#pragma mark UIScrollViewDeletate
//页面滑动执行
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!_isRotate)
    {
        _currentIndex = scrollView.contentOffset.x / (_screenWidth + kBrowseSpace);
        _countLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)_currentIndex + 1,(long)_browseItemArray.count];
    }
    _isRotate = NO;
}

#pragma mark Tap Method
- (void)tap:(MSSBrowseCollectionViewCell *)browseCell
{
    QFLOG(@"TAP------");
    // 移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];

    // 动画结束前不可点击透明背景后的内容
     _collectionView.userInteractionEnabled = NO;
    
    browseCell.zoomScrollView.zoomScale = 1.0f;

    [self.navigationController popViewControllerAnimated:YES];
  
}

//长按cell 弹出选择框
- (void)longPress:(MSSBrowseCollectionViewCell *)browseCell
{
    [_browseActionSheet removeFromSuperview];
    _browseActionSheet = nil;
    __weak __typeof(self)weakSelf = self;
    _browseActionSheet = [[MSSBrowseActionSheet alloc]initWithTitleArray:@[@"保存图片"] cancelButtonTitle:@"取消" didSelectedBlock:^(NSInteger index) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf browseActionSheetDidSelectedAtIndex:index currentCell:browseCell];
    }];
    [_browseActionSheet showInView:_bgView];
}


#pragma mark Orientation Method
//页面旋转执行
- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if(orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)
    {
        _isRotate = YES;
        _currentOrientation = orientation;
        if(_currentOrientation == UIDeviceOrientationPortrait)
        {
            _screenWidth = MSS_SCREEN_WIDTH;
            _screenHeight = MSS_SCREEN_HEIGHT;
            [UIView animateWithDuration:0.5 animations:^{
                _bgView.transform = CGAffineTransformMakeRotation(0);
            }];
        }
        else
        {
            _screenWidth = MSS_SCREEN_HEIGHT;
            _screenHeight = MSS_SCREEN_WIDTH;
            if(_currentOrientation == UIDeviceOrientationLandscapeLeft)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _bgView.transform = CGAffineTransformMakeRotation(M_PI / 2);
                }];
            }
            else
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _bgView.transform = CGAffineTransformMakeRotation(- M_PI / 2);
                }];
            }
        }
        _bgView.frame = CGRectMake(0, 0, MSS_SCREEN_WIDTH, MSS_SCREEN_HEIGHT);
        _browseRemindView.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
        if(_browseActionSheet)
        {
            [_browseActionSheet updateFrame];
        }
        _countLabel.frame = CGRectMake(0, _screenHeight - 50, _screenWidth, 50);
        [_collectionView.collectionViewLayout invalidateLayout];
        _collectionView.frame = CGRectMake(0, 0, _screenWidth + kBrowseSpace, _screenHeight);
        _collectionView.contentOffset = CGPointMake((_screenWidth + kBrowseSpace) * _currentIndex, 0);
        [_collectionView reloadData];
    }
}

#pragma mark MSSActionSheetClick
//选择提示框执行事件
- (void)browseActionSheetDidSelectedAtIndex:(NSInteger)index currentCell:(MSSBrowseCollectionViewCell *)currentCell
{
    __block NSString * text = nil;
    // 保存图片
    if(index == 0)
    {
        // UIImageWriteToSavedPhotosAlbum(currentCell.zoomScrollView.zoomImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
        if (currentCell.zoomScrollView.zoomImageView.image) {
            //保存图片在自己创建的相册中
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            
            [library saveImage:currentCell.zoomScrollView.zoomImageView.image toAlbum:@"过家家" completion:^(NSURL *assetURL, NSError *error) {
                
                if (!error)
                {
                    text = @"保存图片成功";
                    
                }
                else
                {
                    text = @"保存图片失败";
                }
                [self showBrowseRemindViewWithText:text];
                
            } failure:^(NSError *error) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"存储失败"
                                                               message:@"请打开 设置-隐私-照片 来进行设置"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil, nil];
                [alert show];
            }];
        }
    }

}


#pragma mark RemindView Method
- (void)showBrowseRemindViewWithText:(NSString *)text
{
    [_browseRemindView showRemindViewWithText:text];
    _bgView.userInteractionEnabled = NO;
    [self performSelector:@selector(hideRemindView) withObject:nil afterDelay:0.7];
}

- (void)hideRemindView
{
    [_browseRemindView hideRemindView];
    _bgView.userInteractionEnabled = YES;
}

@end
