//
//  ReviewsVC.m
//  aDoctor
//
//  Created by David Iskander on 9/27/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "ReviewsVC.h"

@interface ReviewsVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ReviewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Get request, just for testing
    //    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //    [request setURL:[NSURL URLWithString:@"https://adoctor.herokuapp.com/api/reviews"]];
    //    [request setHTTPMethod:@"GET"];
    //
    //    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    //        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //        NSLog(@"requestReply: %@", requestReply);
    //    }] resume];
    //
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

@end
