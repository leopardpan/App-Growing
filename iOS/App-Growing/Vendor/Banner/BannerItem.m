//
//  BannerItem.m
//  App-Growing
//
//  Created by 潘柏信 on 16/4/15.
//  Copyright © 2016年 leopard. All rights reserved.
//

#import "BannerItem.h"

@implementation BannerItem

+ (instancetype)imgName:(NSString *)imgName label:(NSString *)label {

    BannerItem *dataItem = [BannerItem new];
    dataItem.imgName = imgName;
    dataItem.label   = label;
    return dataItem;
}
@end
