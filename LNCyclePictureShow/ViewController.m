//
//  ViewController.m
//  LNCyclePictureShow
//
//  Created by cong on 16/5/29.
//  Copyright © 2016年 lin. All rights reserved.
//

#import "ViewController.h"
#import "LNCyclePictureController.h"

@interface ViewController ()

@property (nonatomic,strong) LNCyclePictureController *cycleShow;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.cycleShow = [LNCyclePictureController cyclePictureControllerWithJSONUrl:@"http://127.0.0.1/image.json" andFieldName:@"imageUrl" andViewFrame:CGRectMake(0, 0, 375, 200) andDirection:UICollectionViewScrollDirectionHorizontal andIsTimerOn:YES];
    

    
    self.cycleShow.collectionView.backgroundColor = [UIColor blueColor];
    
    self.tableView.tableHeaderView = self.cycleShow.view;
//    [self.view addSubview:self.cycleShow.view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
