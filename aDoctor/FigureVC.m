//
//  FigureVC.m
//  aDoctor
//
//  Created by David Iskander on 10/7/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "FigureVC.h"

@interface FigureVC ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *bodyPartSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *figureBodyTypeSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *bodySideSegmentControl;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation FigureVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (IBAction)segmentControlPressed:(UISegmentedControl *)sender {
    // upper-muscles-front
    if (self.bodyPartSegmentControl.selectedSegmentIndex == 0 &&
        self.bodySideSegmentControl.selectedSegmentIndex == 0 &&
        self.figureBodyTypeSegmentControl.selectedSegmentIndex == 1)
    {
        self.image.image = [UIImage imageNamed:@"upper-muscles-front"];
        NSLog(@"upper-muscles-front");
    }
    
    //lower-muscles-front
    if (self.bodyPartSegmentControl.selectedSegmentIndex == 1 &&
        self.bodySideSegmentControl.selectedSegmentIndex == 0 &&
        self.figureBodyTypeSegmentControl.selectedSegmentIndex == 1)
    {
        self.image.image = [UIImage imageNamed:@"lower-muscles-front"];
        NSLog(@"lower-muscles-front");
    }
    
    //upper-muscles-back
    if (self.bodyPartSegmentControl.selectedSegmentIndex == 0 &&
        self.bodySideSegmentControl.selectedSegmentIndex == 1 &&
        self.figureBodyTypeSegmentControl.selectedSegmentIndex == 1)
    {
        self.image.image = [UIImage imageNamed:@"upper-muscles-back"];
        NSLog(@"upper-muscles-back");
    }
    
    //lower-muscles-back
    if (self.bodyPartSegmentControl.selectedSegmentIndex == 1 &&
        self.bodySideSegmentControl.selectedSegmentIndex == 1 &&
        self.figureBodyTypeSegmentControl.selectedSegmentIndex == 1)
    {
        self.image.image = [UIImage imageNamed:@"lower-muscles-back"];
        NSLog(@"lower-muscles-front");
    }
}


@end
