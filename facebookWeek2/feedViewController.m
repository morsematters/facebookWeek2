//
//  feedViewController.m
//  facebookWeek2
//
//  Created by Erica Morse on 6/29/14.
//  Copyright (c) 2014 YouTube. All rights reserved.
//

#import "feedViewController.h"

@interface feedViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *feedScrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *feedActivityIndicator;

@end

@implementation feedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"News feed";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.feedActivityIndicator startAnimating];
    
    self.feedScrollView.alpha = 0;

    
    
    UIImage *leftButtonImage = [[UIImage imageNamed:@"new-search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(onLeftButton)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIImage *rightButtonImage = [[UIImage imageNamed:@"janky-notifications-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self performSelector:@selector(loadFeed) withObject:nil afterDelay:2];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadFeed
{
    self.feedScrollView.alpha = 1;
    [self.feedActivityIndicator stopAnimating];
    
}

@end
