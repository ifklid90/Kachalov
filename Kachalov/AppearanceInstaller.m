//
//  AppearanceInstaller.m
//  Kachalov
//
//  Created by User on 19.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "AppearanceInstaller.h"
#import <UIKit/UIKit.h>

@implementation AppearanceInstaller

+ (void) applyAppearance {
    UIFont *navigationBarFont = [UIFont fontWithName:@"EngraversGothicBold" size:20.0];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : navigationBarFont}];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    UIFont *segmentControlFont = [UIFont fontWithName:@"EngraversGothicBold" size:16.0];
    
    [[UISegmentedControl appearance] setTintColor: [UIColor whiteColor]];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSFontAttributeName : segmentControlFont, NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSFontAttributeName : segmentControlFont, NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    
    UIImage *image = [UIImage imageNamed:@"SegmentViewBackgroundImageStateNormal.png"];
    UIImage *finalImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(2.0, 0.0, 2.0, 0.0)];
    [[UISegmentedControl appearance] setBackgroundImage:finalImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *image2 = [UIImage imageNamed:@"SegmentViewBackgroundImageStateSelected.png"];
    UIImage *finalImage2 = [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(4.0, 3.0, 4.0, 3.0)];
    [[UISegmentedControl appearance] setBackgroundImage:finalImage2 forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    UIImage *deviderImage = [UIImage imageNamed:@"Artboard 4.png"];
    [[UISegmentedControl appearance] setDividerImage:deviderImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIImage *deviderImage2 = [[UIImage imageNamed:@"Artboard 7"] resizableImageWithCapInsets:UIEdgeInsetsMake(3.0, 1.0, 3.0, 1.0)];
    [[UISegmentedControl appearance] setDividerImage:deviderImage2 forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    UIImage *deviderImage3 = [[UIImage imageNamed:@"Artboard 6"] resizableImageWithCapInsets:UIEdgeInsetsMake(3.0, 1.0, 3.0, 1.0)];
    [[UISegmentedControl appearance] setDividerImage:deviderImage3 forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

@end
