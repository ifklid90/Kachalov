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
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (nonatomic) NSInteger monthIndex;
@property (nonatomic) NSInteger sceneIndex;

@end

@implementation SmallAfficheTablewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 50;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.defaultSession = [NSURLSession sessionWithConfiguration:config];


    NSURL *url = [NSURL URLWithString:@"http://www.teatrkachalov.ru"];

    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"%@", [error localizedDescription]);
        } else {

            NSString *htmlCodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@", htmlCodeString);
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
    
    [self reloadMonthLabel];

    [self.table reloadData];
}

#pragma mark Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sceneIndex == 0) {
        return [self.largeSceneElementsByMonths[self.monthIndex] count];
    } else {
        return [self.smallSceneElementsByMonths[self.monthIndex] count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"SmallAfficheTableViewCell";
    SmallAfficheCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    SmallAfficheElement *element;
    if (self.sceneIndex == 0) {
        element = self.largeSceneElementsByMonths[self.monthIndex][indexPath.row];
    } else {
        element = self.smallSceneElementsByMonths[self.monthIndex][indexPath.row];
    }
    

    cell.dateTextLabel.text     = element.date;
    cell.dayTextLabel.text      = element.day;
    cell.premiereTextLabel.text = element.premiere;
    cell.authorTextLabel.text   = element.author;
    cell.nameTextLabel.text     = element.name;
    cell.genreTextLabel.text    = element.genre;
    cell.ageRatingLabel.text    = element.ageRaiting;
    
    return cell;
}

- (IBAction)sceneSegmentControlValueChanged:(id)sender {
    
    self.sceneIndex = [self.segmentedControl selectedSegmentIndex];
    self.monthIndex = 0;
    [self reloadMonthLabel];
    [self.table reloadData];
}

- (IBAction)leftButtonPressed:(id)sender {
    NSInteger monthsCount;
    if (self.sceneIndex == 0) {
        monthsCount = [self.largeSceneMonths count];
    } else {
        monthsCount = [self.smallSceneMonths count];
    }
    
    if (self.monthIndex == 0) {
        self.monthIndex = monthsCount - 1;
    } else {
        self.monthIndex = (self.monthIndex - 1) % monthsCount;
    }
    
    [self reloadMonthLabel];
    [self.table reloadData];
}

- (IBAction)rightButtonPressed:(id)sender {
    NSInteger monthsCount;
    if (self.sceneIndex == 0) {
        monthsCount = [self.largeSceneMonths count];
    } else {
        monthsCount = [self.smallSceneMonths count];
    }
    self.monthIndex = (self.monthIndex + 1) % monthsCount;
    
    [self reloadMonthLabel];
    [self.table reloadData];
}

- (void)reloadMonthLabel {
    if (self.sceneIndex == 0) {
        self.monthLabel.text = self.largeSceneMonths[self.monthIndex];
    } else {
        self.monthLabel.text = self.smallSceneMonths[self.monthIndex];
    }
}


@end
