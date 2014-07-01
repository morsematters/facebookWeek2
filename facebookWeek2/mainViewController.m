//
//  mainViewController.m
//  facebookWeek2
//
//  Created by Erica Morse on 6/25/14.
//  Copyright (c) 2014 YouTube. All rights reserved.
//

#import "mainViewController.h"
#import "feedViewController.h"

@interface mainViewController ()
@property (weak, nonatomic) IBOutlet UIView *signinView;
- (IBAction)onBeginEditEmail:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *signupandhelpView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)loginButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;


- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
- (IBAction)onTap:(id)sender;

- (IBAction)onEdit:(id)sender;
- (IBAction)onEditEmail:(id)sender;
- (IBAction)onEditPassword:(id)sender;


@end

@implementation mainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginButton.alpha=.7;
    [self.loginButton setEnabled:NO];
//    float originViewPosition = self.signinView.frame.origin.y;
//    self.signUpButton.enabled = NO;
//    if(self.passwordTextField != nil && self.emailTextField != nil){
//        self.signUpButton.enabled = YES;
//    }
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showErrorAlert:(id)sender{
    
}

- (IBAction)onBeginEditEmail:(id)sender {

//    self.signinView.center = CGPointMake(self.signinView.center.x, self.signinView.center.y-70);
//    self.signUpButton.center = CGPointMake(self.signUpButton.center.x, self.signUpButton.center.y-160);
}
- (IBAction)loginButton:(id)sender {
    self.activityIndicator.alpha =1;
    [self.activityIndicator startAnimating];
    self.loginButton.enabled = NO;
    self.emailTextField.enabled = NO;
    self.passwordTextField.enabled = NO;
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"logging_in_button"] forState:UIControlStateDisabled];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"logging_in_button"] forState:UIControlStateNormal];

    
    
    if([self.passwordTextField.text isEqualToString:@"password"])
    {
        NSLog(@"valid password");
        [self performSelector:@selector(loginSuccess) withObject:nil afterDelay:2];
        
    }else{
        NSLog(@"not valid password");
        [self loginFail];
    }

   
}

- (void)loginSuccess{
    NSLog(@"success");
    [self.activityIndicator stopAnimating];
    UIViewController *vc = [[feedViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical; // Rises from below
    [self presentViewController:navigationController animated:YES completion:nil];
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(79/255.0) green:(106/255.0) blue:(160/255.0) alpha:1];
    NSDictionary *titleTextAttributes =
    @{
      NSForegroundColorAttributeName : [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1]
      };
    
    navigationController.navigationBar.titleTextAttributes = titleTextAttributes;



}
- (void)loginFail{
    NSLog(@"Fali");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect password" message:@"The password you entered is incorrect. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}



- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
//    NSLog(@"origin: %f", self.signinView.frame.origin.y);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.signinView.frame = CGRectMake(0, self.signinView.frame.origin.y -  kbSize.height +140, self.signinView.frame.size.width, self.signinView.frame.size.height);
                         self.signupandhelpView.frame =CGRectMake(self.signupandhelpView.frame.origin.x, self.signupandhelpView.frame.origin.y -  kbSize.height + 60, self.signupandhelpView.frame.size.width, self.signupandhelpView.frame.size.height);


                     }
                     completion:nil];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}



- (void)willHideKeyboard:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.signinView.frame = CGRectMake(0,self.view.frame.size.height - self.signinView.frame.size.height, self.signinView.frame.size.width, self.signinView.frame.size.height);
                         self.signupandhelpView.frame = CGRectMake(self.signupandhelpView.frame.origin.x,self.view.frame.size.height - self.signupandhelpView.frame.size.height, self.signupandhelpView.frame.size.width, self.signupandhelpView.frame.size.height);

                     }
                     completion:nil];
}


- (IBAction)onEditEmail:(id)sender {
    NSLog(@"that worked");
    if ([self.emailTextField.text length] != 0 && [self.passwordTextField.text length] != 0 ) {
        NSLog(@"YES");
        [self.loginButton setEnabled:YES];
        self.loginButton.alpha = 1;
    }
    else {
        NSLog(@"NO");
        [self.loginButton setEnabled:NO];
        self.loginButton.alpha = .5;
    }
}

- (IBAction)onEditPassword:(id)sender {
    NSLog(@"that worked");
    if ([self.emailTextField.text length] != 0 && [self.passwordTextField.text length] != 0 ) {
        NSLog(@"YES");
        [self.loginButton setEnabled:YES];
        self.loginButton.alpha = 1;
    }
    else {
        NSLog(@"NO");
        [self.loginButton setEnabled:NO];
        self.loginButton.alpha = .5;
    }

}
@end
