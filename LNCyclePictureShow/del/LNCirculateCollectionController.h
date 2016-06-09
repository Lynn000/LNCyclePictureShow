//
//  LNCirculateCollectionController.h
//  LNCyclePictureShow
//
//  Created by 林森荣 on 16/5/30.
//  Copyright © 2016年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>


// 此类是用来管理collectionView的

@interface LNCirculateCollectionController : UIViewController

@property (nonatomic,strong) UICollectionView *collectionView;

// 通过URL连接获取轮播图片数据
+ (instancetype)circulateCollectionControllerWithURL:(NSURL *)url andCollectionViewFrame:(CGRect)viewFrame;


@end
