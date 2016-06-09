//
//  LNCyclePictureController.h
//  LNCyclePictureShow
//
//  Created by cong on 16/5/29.
//  Copyright © 2016年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    ContentTypeImageURL = 0, // 传入url数组方法
    ContentTypeImageName = 1, // 传入imgName数组方法
    ContentTypeImage = 2, // 传入img数组方法
    ContentTypeJSON = 3 // 传入json
    
}ContentType;

// 此类是用来管理collectionView的

@interface LNCyclePictureController : UICollectionViewController

// 基本初始化类方法
+ (instancetype)cyclePictureControllerWithArray:(NSArray *)picArray andContentType:(ContentType)contentType andFieldName:(NSString *)fieldName andViewFrame:(CGRect)viewFrame andDirection:(UICollectionViewScrollDirection)scrollDirection andIsTimerOn:(BOOL)isOn;

// 传入JSON数据
+ (instancetype)cyclePictureControllerWithJSONUrl:(NSString *)JSONUrl andFieldName:(NSString *)fieldName andViewFrame:(CGRect)viewFrame andDirection:(UICollectionViewScrollDirection)scrollDirection andIsTimerOn:(BOOL)isOn;



@end
