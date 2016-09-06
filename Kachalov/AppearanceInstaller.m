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
    UIFont *navigationBarFont = [UIFont fontWithName:@"EngraversGothicBold" size:22.0];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : navigationBarFont}];
    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    UIFont *barButtonFont = [UIFont fontWithName:@"EngraversGothicBold" size:16.0];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]] setTitleTextAttributes:@{NSFontAttributeName : barButtonFont} forState:UIControlStateNormal];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    UIFont *segmentControlFont = [UIFont fontWithName:@"EngraversGothicBold" size:16.0];
    
    [[UISegmentedControl appearance] setTintColor: [UIColor whiteColor]];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSFontAttributeName : segmentControlFont, NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSFontAttributeName : segmentControlFont, NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    
    UIImage *image = [UIImage imageNamed:@"SegmentViewBackgroundImageStateNormal.png"];
    UIImage *finalImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(2.0, 0.0, 2.0, 0.0)];
    [[UISegmentedControl appearance] setBackgroundImage:finalImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *image2 = [UIImage imageNamed:@"SegmentViewBackgroundImageStateSelected.png"];
    UIImage *finalImage2 = [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 4.0, 5.0, 4.0)];
    [[UISegmentedControl appearance] setBackgroundImage:finalImage2 forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    UIImage *deviderImage = [UIImage imageNamed:@"SegmentViewDividerLNRN.png"];
    [[UISegmentedControl appearance] setDividerImage:deviderImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIImage *deviderImage2 = [[UIImage imageNamed:@"SegmentViewDeviderLNRS.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(4.0, 1.0, 4.0, 1.0)];
    [[UISegmentedControl appearance] setDividerImage:deviderImage2 forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    UIImage *deviderImage3 = [[UIImage imageNamed:@"SegmentViewDeviderLSRN.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(4.0, 1.0, 4.0, 1.0)];
    [[UISegmentedControl appearance] setDividerImage:deviderImage3 forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [UITableViewCell appearance].selectionStyle = UITableViewCellSelectionStyleNone;
    
}

@end
