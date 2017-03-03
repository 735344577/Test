//
//  KLBannerView.h
//  AFNetworking
//
//  Created by nice on 16/8/18.
//  Copyright © 2016年 Haitao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PageControlPosition) {
    PageControlDefault,         //默认位置  右下
    PageControlBottomRight,
    PageControlBottomCenter,
    PageControlBottonLeft,
    
    PageControlTopLeft,
    PageControlTopCenter,
    PageControlTopRight,
};



@interface KLBannerView : UIView

/* 定时器时间 默认2s*/
@property (nonatomic, assign) NSInteger timesecond;
/*图片数组*/
@property (nonatomic, strong) NSArray * imageUrls;
/*背景默认图片*/
@property (nonatomic, strong) UIImage * placeholderImage;
/*文字描述*/
@property (nonatomic, strong) NSArray * describes;
/* 是否展示文字描述*/
@property (nonatomic, assign) BOOL isShowText;
/*textColor*/
@property (nonatomic, strong) UIColor * textColor;
/*文字字体*/
@property (nonatomic, strong) UIFont * font;
/*字体大小(系统默认字体)*/
@property (nonatomic, assign) CGFloat fontSize;
/* 点击事件*/
@property (nonatomic, copy) void (^ clickAction)(NSInteger index);

+ (instancetype)initWithFrame:(CGRect)frame
                    imageUrls:(NSArray *)imageUrls;

@end


@interface KLCollectionViewCell : UICollectionViewCell

/*图片*/
@property (nonatomic, strong) UIImageView * imgView;
/*描述文字*/
@property (nonatomic, copy) NSString * text;

@end
