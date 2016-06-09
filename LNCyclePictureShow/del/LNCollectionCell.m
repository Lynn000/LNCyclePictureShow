//
//  LNCollectionCell.m
//  LNCyclePictureShow
//
//  Created by 林森荣 on 16/5/31.
//  Copyright © 2016年 lin. All rights reserved.
//

#import "LNCollectionCell.h"


@implementation LNCollectionCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *picV = [[UIImageView alloc]initWithFrame:frame];
        [self addSubview:picV];
        self.picView = picV;
        
    }
    return self;
}



@end
