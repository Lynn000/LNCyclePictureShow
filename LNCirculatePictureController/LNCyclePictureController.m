//
//  LNCyclePictureController.m
//  LNCyclePictureShow
//
//  Created by cong on 16/5/29.
//  Copyright © 2016年 lin. All rights reserved.
//

#import "LNCyclePictureController.h"
#import "LNCirculateModel.h"
#import "UIImageView+WebCache.h"
@interface LNCyclePictureController ()

// 设置存储图片数组
@property (nonatomic,strong) NSArray * pictureArray;

// 设置数据内容类型
@property (nonatomic,assign) ContentType dataContentType;

// 设置JSON数据中的字段
@property (nonatomic,copy) NSString *fieldName;

@property (nonatomic,strong) NSURL *imageUrl;

// 设置索引
@property (nonatomic,assign) NSInteger index;


// 设置下一页索引
@property (nonatomic,strong) NSIndexPath *nextIndex;

// 设置页码
@property (nonatomic,strong) UIPageControl * pageControl;

// 设置定时器
@property (nonatomic,strong) NSTimer * timer;

// 设置是否开启定时器
@property (nonatomic,assign) BOOL isTimerOpen;

// 设置view大小
@property (nonatomic, strong) NSValue *viewFrame;

@end


@implementation LNCyclePictureController

static NSString *cellID = @"cell";

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    // 设置collectionView样式
    [self setupCollectionView];
    
    // 获取图片信息
    if (self.dataContentType == ContentTypeJSON) {
        
        __weak typeof(self ) weakSelf = self;
        [LNCirculateModel circulateModelWithURL:self.imageUrl andFieldName:self.fieldName andCompletHandler:^(NSArray<UIImage *> *imagesArray) {
            
            // 获得图片信息
            weakSelf.pictureArray = imagesArray;
            
            [weakSelf.collectionView reloadData];
            
            // 进行设置初始位置
            NSIndexPath *originalIndex = [NSIndexPath indexPathForItem:0 inSection:1];
            NSLog(@"ori %zd----%zd",originalIndex.section,originalIndex.item);
            __weak typeof(self) weakSelf = self;
            [weakSelf.collectionView scrollToItemAtIndexPath:originalIndex atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
            
            [self setupPageControl];
            
            // 开启定时器事件
            [self timerStart];
            
        }];
    }else if(self.dataContentType == ContentTypeImageURL){
        
        NSIndexPath *originalIndex = [NSIndexPath indexPathForItem:0 inSection:1];
        NSLog(@"ori %zd----%zd",originalIndex.section,originalIndex.item);
        __weak typeof(self) weakSelf = self;
         [weakSelf.collectionView scrollToItemAtIndexPath:originalIndex atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
        
        [self setupPageControl];
        
        // 开启定时器事件
        if (self.isTimerOpen) {
            [self timerStart];
        }
        
    }else if (self.isTimerOpen){

        // 开启定时器事件
        [self timerStart];
    }
    
}

#pragma mark - 图片轮播
// MARK: - 定时器事件
- (void)timerStart{

    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextPicture) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop]run];
    });
}

// MARK: - 下一张图片
- (void)nextPicture{
    
    // 索引加1
    self.index = [[self.collectionView indexPathsForVisibleItems] lastObject].item;
    
    self.index++;
    NSIndexPath *nextIndex;
    if (self.index >= self.pictureArray.count) {
        
        self.index = self.index % self.pictureArray.count;
        nextIndex = [NSIndexPath indexPathForItem:self.index inSection:2];

    }else{
        
        nextIndex = [NSIndexPath indexPathForItem:self.index inSection:1];
        
    }
    self.nextIndex = nextIndex;
    NSLog(@"next %zd---%zd",self.nextIndex.section,self.nextIndex.item);
    [self.collectionView scrollToItemAtIndexPath:self.nextIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    self.pageControl.currentPage = self.index;

}

#pragma mark - 代理方法
// 开始拖拽 停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.timer invalidate];
    self.timer = nil;
}

// 滚动减速结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (decelerate == NO && self.isTimerOpen) {
        [self timerStart];
    }
    
}

// 滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.isTimerOpen) {
        [self timerStart];
    }
//    else{
//        NSIndexPath *currentIndex = [[self.collectionView indexPathsForVisibleItems]lastObject];
//        NSLog(@"%@",currentIndex);
//        self.pageControl.currentPage = currentIndex.item;
//    }
    
}

// 滚动结束动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    // 获得当前索引
    NSIndexPath *currentIndex = self.nextIndex;

    if (currentIndex.section == 1) {
        return ;
    }
    currentIndex = [NSIndexPath indexPathForItem:currentIndex.item inSection:1];
    NSLog(@"scorll end:%zd ---- %zd",currentIndex.section,currentIndex.item);
    [self.collectionView scrollToItemAtIndexPath:currentIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark - 初始化相关信息

// MARK: - 设置collectionView相关样式信息
- (void)setupCollectionView{
    
    // 注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
    // 设置样式
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;

    
}

// MARK: - 创建pageControl
- (void)setupPageControl{
    
    // 创建pageControl
    CGRect frame = [self.viewFrame CGRectValue];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height * 0.8, frame.size.width, 30)];
    self.pageControl.currentPage = self.index;
    self.pageControl.numberOfPages = self.pictureArray.count;
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.pageControl];
    [self.view bringSubviewToFront:self.pageControl];

    
}

#pragma mark - 创建对象

// MARK: - 基本初始化类方法 collectionView
+ (instancetype)cyclePictureControllerWithArray:(NSArray *)picArray andContentType:(ContentType)contentType andFieldName:(NSString *)fieldName andViewFrame:(CGRect)viewFrame andDirection:(UICollectionViewScrollDirection)scrollDirection andIsTimerOn:(BOOL)isOn{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置item大小
    flowLayout.itemSize = viewFrame.size;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = scrollDirection;
    
    LNCyclePictureController *cyclePicController = [[LNCyclePictureController alloc]initWithCollectionViewLayout:flowLayout];
    
    // 设置属性
    cyclePicController.dataContentType = contentType;
    cyclePicController.fieldName = fieldName;
    cyclePicController.pictureArray = picArray;
    cyclePicController.isTimerOpen = isOn;
    cyclePicController.viewFrame = [NSValue valueWithCGRect:viewFrame];
    if (contentType == ContentTypeJSON) {
        cyclePicController.imageUrl = [NSURL URLWithString:picArray.firstObject];
    }
    
    // 设置布局
    cyclePicController.view.frame = viewFrame;
    cyclePicController.collectionView.frame = viewFrame;
    
    return cyclePicController;
}

// MARK : - 根据JSON数据设置图片
+ (instancetype)cyclePictureControllerWithJSONUrl:(NSString *)JSONUrl andFieldName:(NSString *)fieldName andViewFrame:(CGRect)viewFrame andDirection:(UICollectionViewScrollDirection)scrollDirection andIsTimerOn:(BOOL)isOn{
    
    return [self cyclePictureControllerWithArray:@[JSONUrl] andContentType:ContentTypeJSON andFieldName:fieldName andViewFrame:viewFrame andDirection:scrollDirection andIsTimerOn:isOn];
    
}

#pragma mark - 数据源方法
// MARK : - 设置item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    UIImageView *cellPicView = [[UIImageView alloc]init];
    
    // 设置数据
    // 判断接入数组内容
    // 1.图片url
    // 2.图片名称
    // 3.图片本身
    // 4.JSON数据
    switch (self.dataContentType) {
        case ContentTypeImageURL:
        case ContentTypeJSON:
            [cellPicView sd_setImageWithURL:self.pictureArray[indexPath.item]];
            break;
        case ContentTypeImageName:
            cellPicView.image = [UIImage imageNamed:self.pictureArray[indexPath.item]];
        case ContentTypeImage:
            cellPicView.image = self.pictureArray[indexPath.item];
        default:
            break;
    }
    
    cell.backgroundView = cellPicView;
    
    return cell;
}

// 设置图片个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pictureArray.count;
}

// 设置组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

#pragma mark - 懒加载
//- (NSArray *)pictureArray{
//    
//    if (_pictureArray == nil) {
//        _pictureArray = [NSArray array];
//    }
//    return _pictureArray;
//}

@end
