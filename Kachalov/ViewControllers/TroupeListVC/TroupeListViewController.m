//
//  TroupeListViewController.m
//  Kachalov
//
//  Created by User on 27.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "TroupeListViewController.h"
#import "TroupeListParser.h"
#import "ActorListCell.h"
#import "ActorListElement.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LoadingCell.h"

@interface TroupeListViewController ()

@property (nonatomic) NSURLSession *defaultSession;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@property (nonatomic) NSMutableArray *actorsList;
//@property (nonatomic) NSString *nextPageURL;

@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@property (nonatomic) NSArray *URLs;
@property (nonatomic) NSMutableArray *nextPageURLs;
@property (nonatomic) NSInteger sectionIdx;
@property (nonatomic) NSArray *actorLists;

@end

@implementation TroupeListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    self.URLs = @[@"http://www.teatrkachalov.ru/leaders/", @"http://www.teatrkachalov.ru/troupe/", @"http://www.teatrkachalov.ru/musicians/"];
    self.nextPageURLs = [@[[NSNull null], [NSNull null], [NSNull null]] mutableCopy];
    self.actorLists = @[[NSMutableArray new], [NSMutableArray new], [NSMutableArray new]];
    
    [self loadActors];
    
}

#pragma mark Table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.nextPageURLs[self.sectionIdx] != [NSNull null]){
        return [self.actorLists[self.sectionIdx] count] + 1;
    } else {
        return [self.actorLists[self.sectionIdx] count];
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.actorLists[self.sectionIdx] count]){
        return [self tableView:tableView actorCellForRowAtIndexPath:indexPath];
    } else {
        return [self loadingCell];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView actorCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"ActorListCell";
    ActorListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    ActorListElement *element = self.actorLists[self.sectionIdx][indexPath.row];

    cell.actorNameLabel.text = element.actorName;
    
    NSMutableString *URLstring = [NSMutableString stringWithString: @"http://www.teatrkachalov.ru"];
    [URLstring appendString:element.actorImageURL];
    NSURL *url = [NSURL URLWithString:URLstring];
    [cell.actorImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone){
            cell.actorImageView.alpha = 0.0;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 cell.actorImageView.alpha = 1.0;
                             }];
        }
    }];
    
    
    return cell;
}

- (UITableViewCell *)loadingCell {
    
    NSString *cellId = @"LoadingCell";
    LoadingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    
    [cell.activityIndicator startAnimating];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == [self.actorLists[self.sectionIdx] count] - 2 && self.nextPageURLs[self.sectionIdx] != [NSNull null]) {
        [self loadNextPage];
    }
}

#pragma mark Networking
- (void)loadActors
{
    NSString *urlString = self.URLs[self.sectionIdx];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.defaultSession = [NSURLSession sessionWithConfiguration:config];
    [self.dataTask cancel];
    
    [self showActivityIndicator];
    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
            });
            NSLog(@"%@", [error localizedDescription]);
        } else {
            
            NSString *htmlCodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSArray *elements = [TroupeListParser parseTroupeListFromString:htmlCodeString];
            
            NSString *nextLink = [TroupeListParser parseNextPageLinkFromString:htmlCodeString];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];

                if (nextLink){
                    self.nextPageURLs[_sectionIdx] = nextLink;
                }
                
                self.actorsList = [elements mutableCopy];
                [self.actorLists[_sectionIdx] addObjectsFromArray:elements];
                
                
                [self.tableView reloadData];
            });
            
        }
    }];
    [self.dataTask resume];
}

- (void)loadNextPage
{
    NSString *next = [NSString stringWithFormat:@"http://www.teatrkachalov.ru%@", self.nextPageURLs[self.sectionIdx]];
    NSURL *url = [NSURL URLWithString:next];
    [self.dataTask cancel];
    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            NSString *htmlCodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSArray *result = [TroupeListParser parseTroupeListFromString:htmlCodeString];
            NSString *parsedNextLink = [TroupeListParser parseNextPageLinkFromString:htmlCodeString];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.actorLists[_sectionIdx] addObjectsFromArray:result];
                if (parsedNextLink){
                    self.nextPageURLs[_sectionIdx] = parsedNextLink;
                } else {
                    self.nextPageURLs[_sectionIdx] = [NSNull null];
                }
                [self.tableView reloadData];
            });
            
        }
    }];
    [self.dataTask resume];
}

- (IBAction)navigationSegmentVelueChanged:(id)sender {
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    self.sectionIdx = [segmentControl selectedSegmentIndex];
    
    [self.tableView reloadData];
    if ([self.actorLists[self.sectionIdx] count] == 0){
        [self loadActors];
    }
}

#pragma mark Activity Indicator
- (void)showActivityIndicator
{
    if (!self.activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    self.activityIndicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    self.activityIndicator.center = self.view.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
}


@end
