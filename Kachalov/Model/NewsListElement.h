//
//  NewsListElement.h
//  Kachalov
//
//  Created by User on 25.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NewsListElement : NSObject

@property (nonatomic) NSString  *date;
@property (nonatomic) NSString  *text;
@property (nonatomic) NSString  *imageURL;
@property (nonatomic) UIImage   *image;
@property (nonatomic) NSString  *detailURL;

@end
