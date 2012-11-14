//
//  ToevoegenVoorbeeldViewController.m
//  Bredapp
//
//  Created by Rick Artz on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "ToevoegenVoorbeeldViewController.h"
#import "MBProgressHUD.h"

@interface ToevoegenVoorbeeldViewController ()

@end

@implementation ToevoegenVoorbeeldViewController

@synthesize activity, activityImage;
@synthesize category;
@synthesize titleLabel;
@synthesize datetimeTextView;
@synthesize whereTextView;
@synthesize descriptionTextView;
@synthesize myApp, managedObjectContext;
@synthesize flUploadEngine = _flUploadEngine;
@synthesize flOperation = _flOperation;

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
    
    myApp = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [myApp managedObjectContext];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    titleLabel.text = activity.title;
    datetimeTextView.text = [formatter stringFromDate:activity.begin];
    whereTextView.text = activity.address;
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
   
//    SHKItem *item = [SHKItem image:image title:content];
//    
//    // Get the ShareKit action sheet
//    SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
//    
//    // ShareKit detects top view controller (the one intended to present ShareKit UI) automatically,
//    // but sometimes it may not find one. To be safe, set it explicitly
//    [SHK setRootViewController:self];
//    
//    // Display the action sheet
//    [actionSheet showFromToolbar:self.navigationController.toolbar];
}

- (IBAction)klaar:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lege velden"
                                                    message:@"U heeft niet alle velden volledig of correct ingevuld."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    if([activity.category_id intValue] <= 0
//       [activity.title length] <= 1 ||
//       [activity.content length] <= 5 ||
//       activity.image == nil ||
//       [activity.co_lat doubleValue] <= 0 ||
//       [activity.co_long doubleValue] <= 0 ||
//       [activity.address length] <= 0 ||
//       activity.begin == nil ||
//       activity.end == nil
       )
    {
        [alert show];
    }
    else
    {
        [self performSegueWithIdentifier:@"toBegin" sender:self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    // Post Image
    NSData *image = UIImageJPEGRepresentation(activity.image, 0.1);
    
    self.flUploadEngine = [[FileUploadEngine alloc] initWithHostName:@"larsvanbeek.nl" customHeaderFields:nil];
    
    NSMutableDictionary *postParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"app", @"bredapp",
                                       nil];
    self.flOperation = [self.flUploadEngine postDataToServer:postParams path:@"/BredAppWs/images"];
    
    [self.flOperation addData:image forKey:@"image" mimeType:@"image/jpeg" fileName:@"upload.jpg"];
    
    [self.flOperation onCompletion:^(MKNetworkOperation *operation)
    {
        NSLog(@"%@", [operation responseString]);
        activity.image_url = [NSString stringWithFormat:@"http://www.larsvanbeek.nl/%@", [operation responseString]];
    }
    onError:^(NSError *error) {
        NSLog(@"%@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];        
    }];
    
    //[self.flUploadEngine enqueueOperation:self.flOperation ];
    
    NSString *device_id = @"123dsdasl";
    NSString *category_id = [activity.category_id stringValue];
    NSString *location = activity.address;
    NSString *title = activity.title;
    NSString *description = activity.content;
    NSString *tags = activity.tags;
    NSString *co_lat = [activity.co_lat stringValue];
    NSString *co_long = [activity.co_long stringValue];
    
    NSDateFormatter *dateFormatterB = [[NSDateFormatter alloc] init];
    [dateFormatterB setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *begin = [dateFormatterB stringFromDate:activity.begin];
    
    NSDateFormatter *dateFormatterE = [[NSDateFormatter alloc] init];
    [dateFormatterE setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *end = [dateFormatterE stringFromDate:activity.begin];
    NSLog(@"%@", activity.image_url);
    
    NSString *post = [NSString stringWithFormat:@"device_id=%1$@&category_id=%2$@&location=%3$@&title=%4$@&content=%5$@&tags=%6$@&co_lat=%7$@&co_long=%8$@&begin=%9$@&end=%10$@&image=%11$@",device_id,category_id,location,title,description,tags,co_lat,co_long,begin,end,activity.image_url];
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    //NSLog([NSString stringWithFormat:@"%@",post]);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://www.larsvanbeek.nl/BredAppWs/activities/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSLog(@"Data posted");
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"Return string: %@",returnString);
    
    Activity *newActivity = (Activity *) [NSEntityDescription insertNewObjectForEntityForName:@"Activity"
                                                                       inManagedObjectContext:[self managedObjectContext]];

    newActivity.activity_id = [NSNumber numberWithInt:[returnString intValue]];
    newActivity.begin = activity.begin;
    newActivity.category_id = activity.category_id;
    newActivity.address = activity.address;
    newActivity.co_lat = activity.co_lat;
    newActivity.co_long = activity.co_long;
    newActivity.content = activity.content;
    newActivity.device_id = activity.device_id;
    newActivity.end = activity.end;
    //newActivity.image = activity.image;
    newActivity.tags = activity.tags;
    newActivity.title = activity.title;
    newActivity.image_url = activity.image_url;
    newActivity.fkactivity2category = activity.fkactivity2category;
    
    [myApp saveContext];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end