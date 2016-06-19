//
//  ViewController.m
//  LNCyclePictureShow
//
//  Created by cong on 16/5/29.
//  Copyright © 2016年 lin. All rights reserved.
//

#import "ViewController.h"
#import "LNCyclePictureController.h"
#import "AFNetworking.h"

@interface ViewController ()

@property (nonatomic,strong) LNCyclePictureController *cycleShow;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSString *homeURL = @"http://iosapi.itcast.cn/life/homeData.json.php";
    NSDictionary *param = @{@"anu":@"api/1/index/get_index_info"};
    
    // 从网络获取图片
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:homeURL parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *homeDict = responseObject;
        NSArray *dataArray = [homeDict[@"focus"] valueForKey:@"list"];
        NSMutableArray *arrayM = [NSMutableArray array];
        
        for (NSDictionary *dict in dataArray) {
            [arrayM addObject:dict[@"cover"]];
        }
        
        self.cycleShow = [LNCyclePictureController cyclePictureControllerWithArray:arrayM.copy andContentType:ContentTypeImageURL andFieldName:nil andViewFrame:CGRectMake(0, 0, 375, 200) andDirection:UICollectionViewScrollDirectionHorizontal andIsTimerOn:YES];
        
        self.cycleShow.collectionView.backgroundColor = [UIColor blueColor];
        //
            self.tableView.tableHeaderView = self.cycleShow.view;
            [self.view addSubview:self.cycleShow.view];
                          //cyclePictureControllerWithJSONUrl:@"http://127.0.0.1/image.json" andFieldName:@"imageUrl" andViewFrame:CGRectMake(0, 0, 375, 200) andDirection:UICollectionViewScrollDirectionHorizontal andIsTimerOn:YES];
        //
        //
        //
        //    self.cycleShow.collectionView.backgroundColor = [UIColor blueColor];
        //
        //    self.tableView.tableHeaderView = self.cycleShow.view;
        //    [self.view addSubview:self.cycleShow.view];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
