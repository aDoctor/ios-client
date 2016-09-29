//
//  CalendarVC.m
//  aDoctor
//
//  Created by David Iskander on 9/29/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "CalendarVC.h"
#import "FSCalendar.h"
#import "FSCalendarAnimator.h"
#import "FSCalendarDynamicHeader.h"
#import "UIView+FSExtension.h"


@interface CalendarVC () <FSCalendarDataSource, FSCalendarDelegate>

@end

@implementation CalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
