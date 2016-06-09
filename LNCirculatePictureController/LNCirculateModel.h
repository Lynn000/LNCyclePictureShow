//
//  LNCirculateModel.h
//  LNCyclePictureShow
//
//  Created by David on 16/5/30.
//  Copyright © 2016年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^getImagesBlock)(NSArray *imagesArray);

@interface LNCirculateModel : NSObject

// 进行异步获取图片信息
+ (void)circulateModelWithURL:(NSURL *)imgURL andFieldName:(NSString *)fieldName andCompletHandler:(getImagesBlock)handler;

//+ (void)circulateModelWithURL:(NSURL *)imgURL andCompletHandler:(getImagesBlock)handler;

@end
