//
//  LNCirculateModel.m
//  LNCyclePictureShow
//
//  Created by David on 16/5/30.
//  Copyright © 2016年 lin. All rights reserved.
//

#import "LNCirculateModel.h"
#import "UIImageView+WebCache.h"

@implementation LNCirculateModel


+ (void)circulateModelWithURL:(NSURL *)imgURL andFieldName:(NSString *)fieldName andCompletHandler:(getImagesBlock)handler{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:imgURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError || data == nil) {
            NSLog(@"error : %@\ndata:%@",connectionError,data);
            return ;
        }
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        if ([jsonObj isKindOfClass:[NSArray class]] && handler) {
            NSArray *array = jsonObj;
            NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
            [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSString *imageUrl = obj[fieldName];
                [arrayM addObject:imageUrl];
            }];
            
            handler(arrayM);
        }
        
    }];
    
}



@end
