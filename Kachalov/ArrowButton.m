//
//  ArrowButton.m
//  Kachalov
//
//  Created by User on 16.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "ArrowButton.h"

@implementation ArrowButton

- (void)drawRect:(CGRect)rect {
    
    //border
    CGFloat borderIndent = 1.0;
    if (self.borderIndent > 0.0) {
        borderIndent = self.borderIndent;
    }
    CGFloat borderWidth = 1.0;
    if (self.borderWidth > 0.0) {
        borderWidth = self.borderWidth;
    }
    
    CGRect borderRect = CGRectMake(rect.origin.x + borderIndent , rect.origin.y + borderIndent, rect.size.width - (2 * borderIndent), rect.size.height - (2 * borderIndent));
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRect:borderRect];
    [self.borderColour setStroke];
    borderPath.lineWidth = borderWidth;
    [borderPath stroke];
    
    //arrow
    CGFloat arrowSize = MIN(rect.size.height, rect.size.width)/4;
    if (self.arrowSize > 0.0 && self.arrowSize < MIN(rect.size.height, rect.size.width)) {
        arrowSize = self.arrowSize;
    }
    CGFloat arrowWidth = 1.0;
    if (self.arrowWidth > 0.0) {
        arrowWidth = self.arrowWidth;
    }
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    CGPoint arrowStart;
    CGPoint arrowMidle;
    CGPoint arrowEnd;
    
    NSUInteger direction = self.direction % 4;
    
    switch (direction) {
        case 1:
            arrowStart = CGPointMake(center.x - arrowSize, center.y - (arrowSize/2));
            arrowMidle = CGPointMake(center.x, center.y + (arrowSize/2));
            arrowEnd   = CGPointMake(center.x + arrowSize, center.y - (arrowSize/2));
            break;
            
        case 2:
            arrowStart = CGPointMake(center.x + (arrowSize/2), center.y - arrowSize);
            arrowMidle = CGPointMake(center.x - (arrowSize/2), center.y);
            arrowEnd   = CGPointMake(center.x + (arrowSize/2), center.y + arrowSize);
            break;
            
        case 3:
            arrowStart = CGPointMake(center.x - arrowSize, center.y + (arrowSize/2));
            arrowMidle = CGPointMake(center.x, center.y - (arrowSize/2));
            arrowEnd   = CGPointMake(center.x + arrowSize, center.y + (arrowSize/2));
            break;
            
        default:
            arrowStart = CGPointMake(center.x - (arrowSize/2), center.y - arrowSize);
            arrowMidle = CGPointMake(center.x + (arrowSize/2), center.y);
            arrowEnd   = CGPointMake(center.x - (arrowSize/2), center.y + arrowSize);
            break;
    }
    
    [arrowPath moveToPoint:arrowStart];
    [arrowPath addLineToPoint:arrowMidle];
    [arrowPath addLineToPoint:arrowEnd];
    
    [self.borderColour setStroke];
    arrowPath.lineWidth = arrowWidth;
    [arrowPath stroke];
    
}

@end
