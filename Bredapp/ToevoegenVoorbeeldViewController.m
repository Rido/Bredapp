//
//  ToevoegenVoorbeeldViewController.m
//  Bredapp
//
//  Created by Rick Artz on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "ToevoegenVoorbeeldViewController.h"
#import "SHK.h"

@interface ToevoegenVoorbeeldViewController ()

@end

@implementation ToevoegenVoorbeeldViewController

@synthesize activity, activityImage;
@synthesize category;
@synthesize titleLabel;
@synthesize datetimeTextView;
@synthesize whereTextView;
@synthesize descriptionTextView;

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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    titleLabel.text = activity.title;
    datetimeTextView.text = [formatter stringFromDate:activity.begin];
    whereTextView.text = activity.adres;
    descriptionTextView.text = activity.content;
}

- (IBAction)delen:(id)sender {
    // Example: Use an image in our resource bundle
    //Hier ff de name aanpassen met de activity fotourl
    UIImage *image = [UIImage imageNamed:@"Default.png"];
    
    NSString *title = [NSString stringWithFormat:@"%@\n", titleLabel.text];
    NSString *date = [NSString stringWithFormat:@"%@\n", datetimeTextView.text];
    NSString *where = [NSString stringWithFormat:@"%@\n", whereTextView.text];
    NSString *description = [NSString stringWithFormat:@"%@\n", descriptionTextView.text];
    NSString *content = title;
    
    content = [content stringByAppendingString:date];
    content = [content stringByAppendingString:where];
    content = [content stringByAppendingString:description];
   
    SHKItem *item = [SHKItem image:image title:content];
    
    // Get the ShareKit action sheet
    SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    
    // ShareKit detects top view controller (the one intended to present ShareKit UI) automatically,
    // but sometimes it may not find one. To be safe, set it explicitly
    [SHK setRootViewController:self];
    
    // Display the action sheet
    [actionSheet showFromToolbar:self.navigationController.toolbar];
}

- (IBAction)klaar:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lege velden"
                                                    message:@"Controleer of alle velden zijn ingevuld."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    if([activity.category_id intValue] == 0){
        [alert show];
        [alert release];
    } else {
        [self performSegueWithIdentifier:@"toBegin" sender:self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *device_id = @"123dsdasl";
    NSString *category_id = [activity.category_id stringValue];
    NSString *location = activity.adres;
    NSString *title = activity.title;
    NSString *description = activity.content;
    NSString *tags = activity.tags;
    NSString *co_lat = [activity.co_lat stringValue];
    NSString *co_long = [activity.co_long stringValue];
    
    NSDateFormatter *dateFormatterB = [[NSDateFormatter alloc] init];
    [dateFormatterB setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *begin = [dateFormatterB stringFromDate:activity.begin];
    [dateFormatterB release];
    
    NSDateFormatter *dateFormatterE = [[NSDateFormatter alloc] init];
    [dateFormatterE setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *end = [dateFormatterE stringFromDate:activity.begin];
    
    [dateFormatterE release];
    
    NSString *image = @"http://www.dufacoshop.nl/media/apple-logo1.jpg";
    
    NSString *post = [NSString stringWithFormat:@"device_id=%1$@&category_id=%2$@&location=%3$@&title=%4$@&content=%5$@&tags=%6$@&co_lat=%7$@&co_long=%8$@&begin=%9$@&end=%10$@&image=%11$@",device_id,category_id,location,title,description,tags,co_lat,co_long,begin,end,image];
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    //NSLog([NSString stringWithFormat:@"%@",post]);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:@"http://www.larsvanbeek.nl/BredAppWs/activities/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSLog(@"Data posted");
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"Return string: %@",returnString);
}

- (void)dealloc {
    [activityImage release];
    [super dealloc];
}
@end
