//
//  LNCirculateCollectionController.m
//  LNCyclePictureShow
//
//  Created by 林森荣 on 16/5/30.
//  Copyright © 2016年 lin. All rights reserved.
//

#import "LNCirculateCollectionController.h"
#import "LNCollectionCell.h"
#import "LNCirculateModel.h"
@interface LNCirculateCollectionController ()<UICollectionViewDelegate,UICollectionViewDataSource>

// 定义URL属性
@property (nonatomic,strong) NSURL *imagesUrl;

// 定义collectionView的frame
@property (nonatomic,assign) CGRect viewFrame;

// 定义图片数组
@property (nonatomic,strong) NSArray * imageArray;

@end


@implementation LNCirculateCollectionController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // 添加collectionView
    [self setupCollectionView];
    
    // 获得数据
    __weak typeof(self) wSelf = self;
    [LNCirculateModel circulateModelWithURL:self.imagesUrl andCompletHandler:^(NSArray *imagesArray) {
        
        wSelf.imageArray = imagesArray;
        
    }];
    
}

static NSString *cellID = @"collectionCell";
// MARK: - 添加collectionView
- (void)setupCollectionView{
    
    UICollectionViewLayout *flowLayout = [[UICollectionViewLayout alloc]init];
    
    // 设置View大小
    
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:self.viewFrame collectionViewLayout:flowLayout];
    
    collectionV.backgroundColor = [UIColor blueColor];
    
    collectionV.delegate = self;
    collectionV.dataSource = self;
    
    [self.view addSubview:collectionV];
    
    // 注册
    [collectionV registerClass:[LNCollectionCell class] forCellWithReuseIdentifier:cellID];
}


#pragma mark - 数据源方法

// MARK: - 设置单元格内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LNCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.picView.image = self.imageArray[indexPath.item];
    
    
    return cell;
    
}

// MARK: - 单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.imageArray.count;
}

// MARK: - 组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

#pragma mark - 快速构造方法
// MARK: - 初始化方法
+ (instancetype)circulateCollectionControllerWithURL:(NSURL *)url andCollectionViewFrame:(CGRect)viewFrame{
    
    LNCirculateCollectionController *collectionVC = [[LNCirculateCollectionController alloc]init];
    
    collectionVC.imagesUrl = url;
    
    collectionVC.viewFrame = viewFrame;
    
    return collectionVC;
}



@end
