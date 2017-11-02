//
//  Tool_DataOperation.m
//  恒实珠宝
//
//  Created by 邱凡Bookpro on 2017/9/4.
//  Copyright © 2017年 hszb. All rights reserved.
//

#import "Tool_DataOperation.h"
#import "Dataserialization.h"
@implementation Tool_DataOperation

-(void)run
{
    [super run];
    
    NSString * type = [self.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    if ([type isEqualToString:@"creater"]) {
        
        NSString *filePath = [self getfilepath];
        NSString * data =[NSString base64Decode:self.data];
        BOOL isSave = [data writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        if (isSave) {
            QFLOG(@"文件创建成功");
        }
        else
        {
            QFLOG(@"文件创建失败");
        }
    }
    else if ([type isEqualToString:@"read"]){
        
        NSString * datastr = [NSString stringWithContentsOfFile:[self getfilepath] encoding:NSUTF8StringEncoding error:nil];
        NSDictionary * plist_dic = [Dataserialization JSONObjectWithData:datastr];
        NSString * key =[NSString stringWithFormat:@"VC-item%ld",self.protocolVC.tabBarController.selectedIndex];
        NSArray  * plists = plist_dic[key];
        QFLOG(@"%@  %@  %@",plist_dic,datastr,plists);
        
        for (int i = 0; i < plists.count; i++) {
            
            [ProtocolClass ProtocolFactroy:plists[i] vc:self.protocolVC];
        }
    }
    else if ([type isEqualToString:@"modify"]){
        
        NSError  * error = nil;
        NSString * data = [NSString base64Decode:self.data];
        BOOL isSave = [data writeToFile:[self getfilepath] atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (isSave) {
            QFLOG(@"文件修改成功的数据------%@ ",data);
        }
        else
        {
            QFLOG(@"文件修改失败");
        }
    }
    else if ([type isEqualToString:@"delete"])
    {
        NSError * error = nil;
        NSFileManager * manager = [NSFileManager defaultManager];
        BOOL isremove = [manager removeItemAtPath:[self getfilepath] error:&error];
        if (isremove) {
            QFLOG(@"文件删除成功");
        }
        else
        {
            QFLOG(@"文件删除失败");
            
        }
    }
}

-(NSString *)getfilepath
{
    NSString * document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString * filePath = [document stringByAppendingPathComponent:self.filename];
    QFLOG(@"%@  %@",filePath,self.filename);
    return filePath;
}

@end
