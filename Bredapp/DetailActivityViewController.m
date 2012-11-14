//
//  DetailActivityViewController.m
//  Bredapp
//
//  Created by Rick Artz on 11/7/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "DetailActivityViewController.h"
#import <Socialize/Socialize.h>

@interface DetailActivityViewController ()

@end

@implementation DetailActivityViewController

@synthesize activity, titleLabel,contentLabel,startLabel,adresLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    titleLabel.text = [activity title];
    adresLabel.text = @"Grote Markt 1";
    contentLabel.text = [activity content];
    startLabel.text = @"2012 23 november, 1700 uur";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)delen:(id)sender {
    UIImage *image = [UIImage imageNamed:@"Default.png"];
    
    NSString *title = [NSString stringWithFormat:@"%@\n", titleLabel.text];
    NSString *date = [NSString stringWithFormat:@"%@\n", startLabel.text];
    NSString *where = [NSString stringWithFormat:@"%@\n", adresLabel.text];
    NSString *description = [NSString stringWithFormat:@"%@\n", contentLabel.text];
    NSString *content = title;
    
    content = [content stringByAppendingString:date];
    content = [content stringByAppendingString:where];
    content = [content stringByAppendingString:description];

    [self showShareDialogWithOptions];
}

- (void)showShareDialogWithOptions {
    id<SZEntity> entity = [SZEntity entityWithKey:@"activity" name:@"Bredapp activiteit"];
    
    SZShareOptions *options = [SZShareUtils userShareOptions];
    
    options.dontShareLocation = YES;
    
    options.willShowSMSComposerBlock = ^(SZSMSShareData *smsData) {
        smsData = [NSString stringWithFormat:@"Kom ook naar de Bredapp activiteit \"%@\" %@", activity.title, activity.image_url];
        
        NSLog(@"Sharing SMS");
    };
    
    options.willShowEmailComposerBlock = ^(SZEmailShareData *emailData) {
        emailData.messageBody = [NSString stringWithFormat:@"Kom ook naar de Bredapp activiteit \"%@\" %@", activity.title, activity.image_url];
        
        NSLog(@"Sharing Email");
    };
    
    options.willAttemptPostingToSocialNetworkBlock = ^(SZSocialNetwork network, SZSocialNetworkPostData *postData) {
        if (network == SZSocialNetworkTwitter) {
            NSString *customStatus = [NSString stringWithFormat:@"Kom ook naar de Bredapp activiteit \"%@\" %@", activity.title, activity.image_url];
            
            [postData.params setObject:customStatus forKey:@"status"];
            
        } else if (network == SZSocialNetworkFacebook) {
            NSString *customMessage = [NSString stringWithFormat:@"Kom ook naar de Bredapp activiteit \"%@\" %@", activity.title, activity.image_url];
            
            [postData.params setObject:customMessage forKey:@"message"];
            [postData.params setObject:activity.image_url forKey:@"link"];
            [postData.params setObject:activity.title forKey:@"name"];
            [postData.params setObject:@"Bredapp" forKey:@"description"];
        }
        
        NSLog(@"Posting to %d", network);
    };
    
    options.didSucceedPostingToSocialNetworkBlock = ^(SZSocialNetwork network, id result) {
        NSLog(@"Posted %@ to %d", result, network);
    };
    
    options.didFailPostingToSocialNetworkBlock = ^(SZSocialNetwork network, NSError *error) {
        NSLog(@"Failed posting to %d", network);
    };
    
    [SZShareUtils showShareDialogWithViewController:self options:options entity:entity completion:^(NSArray *shares) {
        // `shares` is a list of all shares created during the lifetime of the share dialog
        NSLog(@"Created %d shares: %@", [shares count], shares);
    } cancellation:^{
        NSLog(@"Share creation cancelled");
    }];
}


- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setContentLabel:nil];
    [self setStartLabel:nil];
    [self setAdresLabel:nil];
    [super viewDidUnload];
}

@end
