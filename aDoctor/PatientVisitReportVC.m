//
//  PatientVisitReportVC.m
//  aDoctor
//
//  Created by David Iskander on 10/4/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "PatientVisitReportVC.h"

@interface PatientVisitReportVC ()
@property (weak, nonatomic) IBOutlet UIView *customBar;
@property (weak, nonatomic) IBOutlet UIButton *figureButton;
@property (weak, nonatomic) IBOutlet UIButton *notesButton;
@property (weak, nonatomic) IBOutlet UIButton *drugsButton;
@property (weak, nonatomic) IBOutlet UIButton *pharmacyButton;
@property (weak, nonatomic) IBOutlet UIView *figureVC;
@property (weak, nonatomic) IBOutlet UIView *notesVC;
@property (weak, nonatomic) IBOutlet UIView *drugsVC;
@property (weak, nonatomic) IBOutlet UIView *pharmacyVC;

@end

@implementation PatientVisitReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self roundedView:self.figureVC];
    [self roundedView:self.notesVC];
    [self roundedView:self.drugsVC];
    [self roundedView:self.pharmacyVC];
    
    self.figureVC.alpha = 1.0;
    self.notesVC.alpha = 0;
    self.drugsVC.alpha = 0;
    self.pharmacyVC.alpha = 0;
    self.title = @"Figure";
    
}

-(void)roundedView:(UIView *)view
{
    view.layer.cornerRadius = 5;
    view.clipsToBounds = YES;
}

- (IBAction)onFigureButtonPressed:(UIButton *)sender
{
    self.figureVC.alpha = 1.0;
    self.notesVC.alpha = 0;
    self.drugsVC.alpha = 0;
    self.pharmacyVC.alpha = 0;
    self.title = @"Figure";
}


- (IBAction)onNotesButtonPressed:(UIButton *)sender
{
    self.figureVC.alpha = 0;
    self.notesVC.alpha = 1.0;
    self.drugsVC.alpha = 0;
    self.pharmacyVC.alpha = 0;
    self.title = @"Notes";
}


- (IBAction)onDrugsButtonPressed:(UIButton *)sender
{
    self.figureVC.alpha = 0;
    self.notesVC.alpha = 0;
    self.drugsVC.alpha = 1.0;
    self.pharmacyVC.alpha = 0;
    self.title = @"Drugs";
}


- (IBAction)onPharmacyButtonPressed:(UIButton *)sender
{
    self.figureVC.alpha = 0;
    self.notesVC.alpha = 0;
    self.drugsVC.alpha = 0;
    self.pharmacyVC.alpha = 1.0;
    self.title = @"Pharmacy";
}

@end
