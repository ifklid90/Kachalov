//
//  ArrowButton.h
//  Kachalov
//
//  Created by User on 16.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ArrowButton : UIButton
/*!
 * @brief 0 - right, 1 - down, 2 - left, 3 - up
 * 
 */
@property (nonatomic) IBInspectable NSUInteger direction;
@property (nonatomic) IBInspectable CGFloat borderIndent;
@property (nonatomic) IBInspectable CGFloat borderWidth;

@property (nonatomic) IBInspectable UIColor *borderColour;

@property (nonatomic) IBInspectable CGFloat arrowWidth;
@property (nonatomic) IBInspectable CGFloat arrowSize;


@end
