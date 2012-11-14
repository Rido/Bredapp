//
//  DetailActivityViewController.m
//  Bredapp
//
//  Created by Rick Artz on 11/7/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "DetailActivityViewController.h"
#import "ImageCache.h"
#import <Socialize/Socialize.h>

@interface DetailActivityViewController ()

@end

@implementation DetailActivityViewController

@synthesize activity, imageView, titleLabel,contentLabel,startLabel,endLabel,adresLabel;

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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE d MMMM HH:mm"];
    
	// Do any additional setup after loading the view.
    titleLabel.text = activity.title;
    adresLabel.text = activity.address;
    contentLabel.text = [activity content];
    startLabel.text = [dateFormatter stringFromDate:activity.begin];
    endLabel.text = [dateFormatter stringFromDate:activity.end];
    
    if (activity.image.length > 5)
    {
        self.imageView.image = [UIImage imageWithData: activity.image];
    }
    else if (activity.image_url.length > 5)
    {
        NSDictionary *imageInfo = [[NSDictionary alloc] initWithObjectsAndKeys:activity.image_url, @"url", nil];
        
        [NSThread detachNewThreadSelector:@selector(loadImageInBackground:)
                                 toTarget:self
                               withObject:imageInfo];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)delen:(id)sender {    
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

- (void) loadImageInBackground:(NSDictionary *)info
{
    NSURL *imageURL = [NSURL URLWithString:[info objectForKey:@"url"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    
    // Assume image is an instance variable
    UIImage *image = [UIImage imageWithData: imageData];
    activity.image = imageData;
    [self.imageView setImage:image];
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
