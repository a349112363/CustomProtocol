//
//  Control_Share.m
//  恒实优选
//
//  Created by 邱凡Bookpro on 2017/10/17.
//  Copyright © 2017年 shenzhenHengshi. All rights reserved.
//

#import "Control_Share.h"

@implementation Control_Share

-(void)run
{
    self.sub_ShareView =(Sub_ShareView *)[self findControl];

    [super run];
    

}
-(UIView *)CreateControlView
{
    self.sub_ShareView = [[Sub_ShareView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    
    return self.sub_ShareView;
}
@end
