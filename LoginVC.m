//
//  LoginVC.m
//  aDoctor
//
//  Created by David Iskander on 9/26/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()<UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signinButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    self.signinButton.layer.cornerRadius = 5;
    self.signinButton.clipsToBounds = YES;
    
    self.logoImage.layer.cornerRadius = 20;
    self.logoImage.clipsToBounds = YES;
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.emailTextField.text length]==0 || [self validateEmailWithString:self.emailTextField.text]) {
        [textField resignFirstResponder];
        
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter valid email address." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        [textField becomeFirstResponder];
        return NO;
    }
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self validateEmailWithString:self.emailTextField.text];
    return [self.emailTextField resignFirstResponder];
}

@end
