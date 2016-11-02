//
//  ReviewsVC.m
//  aDoctor
//
//  Created by David Iskander on 9/27/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "ReviewsVC.h"
#import "ReviewCell.h"

@interface ReviewsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *namesArray;
@property NSMutableArray *imagesArray;
@property NSMutableArray *starsArray;
@property NSMutableArray *reviewsArray;


@end

@implementation ReviewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)getReviews{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://adoctor.herokuapp.com/api/user"]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", jsonArray);
        
        for (NSDictionary *diction in jsonArray) {
            NSString *name = [diction objectForKey:@"fistName"];
            UIImage *image = [diction objectForKey:@"gender"];
            NSString *stars = [diction objectForKey:@"_insurancePlanID"];
            NSString *review = [diction objectForKey:@"birthdate"];
            
            [self.namesArray addObject:name];
            [self.imagesArray addObject:image];
            [self.starsArray addObject:stars];
            [self.reviewsArray addObject:review];
            
            [self.tableView reloadData];
        }
        
    }] resume];
    
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.name = [self.namesArray objectAtIndex:indexPath.row];
    cell.image = [self.imagesArray objectAtIndex:indexPath.row];
    //cell.star1 = [self.namesArray objectAtIndex:indexPath.row];
    cell.review = [self.reviewsArray objectAtIndex:indexPath.row];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.namesArray.count;
}

@end
