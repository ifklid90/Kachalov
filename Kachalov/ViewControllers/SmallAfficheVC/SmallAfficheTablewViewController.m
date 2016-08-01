//
//  SmallAfficheTablewViewController.m
//  Kachalov
//
//  Created by User on 29.06.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "SmallAfficheTablewViewController.h"
#import "SmallAfficheParser.h"
#import "SmallAfficheCell.h"
#import "SmallAfficheElement.h"

@interface SmallAfficheTablewViewController ()

@property (nonatomic) NSURLSession *defaultSession;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@property (nonatomic) NSArray *smallSceneMonths;
@property (nonatomic) NSArray *largeSceneMonths;

@property (nonatomic) NSArray *smallSceneElementsByMonths;
@property (nonatomic) NSArray *largeSceneElementsByMonths;

@end

@implementation SmallAfficheTablewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    if (self.dataTask != nil) {
//        [self.dataTask cancel];
//    }
    
    
    self.tableView.backgroundColor = [UIColor blackColor];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.defaultSession = [NSURLSession sessionWithConfiguration:config];


    NSURL *url = [NSURL URLWithString:@"http://www.teatrkachalov.ru"];

    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"%@", [error localizedDescription]);
        } else {

            NSString *htmlCodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", htmlCodeString);
            SmallAfficheParser *parser = [SmallAfficheParser new];
            [parser parseWithString:htmlCodeString];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self showDataWithParser:parser];
            });

        }
    }];
    [self.dataTask resume];
}

- (void)showDataWithParser:(SmallAfficheParser *)parser
{
    self.smallSceneMonths = parser.smallSceneMonths;
    self.largeSceneMonths = parser.largeSceneMonths;

    self.smallSceneElementsByMonths = parser.smallSceneElementsByMonths;
    self.largeSceneElementsByMonths = parser.largeSceneElementsByMonths;

    [[self tableView] reloadData];
}

#pragma mark Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.largeSceneMonths count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.largeSceneElementsByMonths[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.largeSceneMonths[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"SmallAfficheTableViewCell";
    SmallAfficheCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

//    cell.textLabel.text =
    SmallAfficheElement *element = self.largeSceneElementsByMonths[indexPath.section][indexPath.row];

    cell.dateTextLabel.text     = element.date;
    cell.dayTextLabel.text      = element.day;
    cell.premiereTextLabel.text = element.premiere;
    cell.authorTextLabel.text   = element.author;
    cell.nameTextLabel.text     = element.name;
    cell.genreTextLabel.text    = element.genre;
    cell.ageRatingLabel.text    = element.ageRaiting;

//    section][indexPath.row] description];
//    cell.textLabel.text = [self.largeSceneElementsByMonths[indexPath.section][indexPath.row] description];
    return cell;
}


@end
