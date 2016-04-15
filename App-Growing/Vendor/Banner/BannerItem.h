//
//  BannerItem.h
//  App-Growing
//
//  Created by 潘柏信 on 16/4/15.
//  Copyright © 2016年 leopard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerItem : NSObject

@property (nonatomic) NSString *imgName;
@property (nonatomic) NSString *label;

+ (instancetype)imgName:(NSString *)urlString label:(NSString *)label;

@end
