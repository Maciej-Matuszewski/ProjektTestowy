//
//  TestTableViewController.m
//  
//
//  Created by Maciej Matuszewski on 09.11.2015.
//
//

#import "TestTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

#import "TestModel.h"
#import "TestTableViewCell.h"

@interface TestTableViewController ()

@property NSMutableArray *records;

@end

@implementation TestTableViewController

#define testURL @"http://cms.fivedottwelve.com/api/v1/resources?lang=pl"

#define reuseIdentifierString @"cell"

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Projekt testowy"];
    
    [self.tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:reuseIdentifierString];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.records count];
}

#pragma mark - Customize Cells

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierString forIndexPath:indexPath];
    if( cell == NULL){
        cell = [[TestTableViewCell alloc] init];
        
    }
    [cell awakeFromNib];
    
    TestModel *model = [self.records objectAtIndex:indexPath.row];
    [cell setBackgroundColor:[self colorFromHexString:model.path_color]];
    [cell.imageView setImageWithURL:[NSURL URLWithString:[model.main_photo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [cell.titleLabel setText:model.name];
    [cell.descriptionLabel setText:model.descriptionString];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TestModel *model = [self.records objectAtIndex:indexPath.row];
    
    CGRect rect = [[[NSAttributedString alloc] initWithString:model.descriptionString
                                                   attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}] boundingRectWithSize:(CGSize){(self.view.frame.size.width-75), CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    return rect.size.height>60.0f?rect.size.height+40.0f:60.0f;
    return 60.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - LOAD DATA

- (void)loadData{
    [self setRecords:[[NSMutableArray alloc] init]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:testURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for(NSDictionary* dict in [responseObject objectForKey:@"paths"]){
            NSError* err = nil;
            [self.records addObject:[[TestModel alloc] initWithDictionary:dict error:&err]];        }
        
        [self sortData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)sortData{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for(TestModel *model in self.records)if(model.activated && !model.deleted)[temp addObject:model];
    [self setRecords:[[temp sortedArrayUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES]]] mutableCopy]];
    
    [self.tableView reloadData];

}

#pragma mark - COLOR

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
