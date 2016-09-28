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
    // Do any additional setup after loading the view.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

@end
