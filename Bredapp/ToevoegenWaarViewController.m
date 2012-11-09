//
//  ToevoegenWaarViewController.m
//  Bredapp
//
//  Created by redj on 11/2/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "ToevoegenWaarViewController.h"
#import "MapAnnotation.h"
#import "NSString+JSON.h"
#import "CLLocation+Geocodereverse.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ToevoegenWanneerViewController.h"
#import "Activity.h"
#import "Category.h"

@interface ToevoegenWaarViewController ()

@end

@implementation ToevoegenWaarViewController

@synthesize addressField;
@synthesize mapView;
@synthesize geocoder;
@synthesize activity;
@synthesize category;

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
    mapView.mapType = MKMapTypeHybrid;
    mapView.showsUserLocation = true;
    
    UIPanGestureRecognizer* panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragMap:)];
    [panRec setDelegate:self];
    [self.mapView addGestureRecognizer:panRec];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)didDragMap:(UIGestureRecognizer*)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        
        //NSLog(@"Longitude:%f Latitude:%f", mapView.centerCoordinate.longitude, mapView.centerCoordinate.latitude);
        
        if (!self.geocoder) {
            self.geocoder = [[CLGeocoder alloc] init];
        }
        
        CLLocation *locatie = [[CLLocation alloc] initWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
        
        [self.geocoder reverseGeocodeLocation: locatie completionHandler:
         
         ^(NSArray *placemarks, NSError *error) {
             
             
             
             //Get nearby address
             
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
             
             
             //String to hold address
             
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             
             addressField.text = locatedAt;
             
             //Print the location to console
             //NSLog(@"I am currently at %@",locatedAt);
             
             
         }];
    }
}

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [aMapView setRegion:region animated:YES];
    NSLog(@"map updated");
}

- (void)viewDidUnload
{
    [self setAddressField:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    NSLog(@"We zijn hier");
    
    if (!self.geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    [self.geocoder geocodeAddressString:textField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Info: %@", [error localizedDescription]);
            return;
        }
        
        for (id object in placemarks) {
            CLPlacemark *placemark = object;
            
            MapAnnotation *annotation = [[MapAnnotation alloc] initWithTitle:[NSString stringWithFormat:@"%@ %@", placemark.postalCode, placemark.locality] subtitle:placemark.subLocality coordinate:placemark.location.coordinate];
            
            [self.mapView removeAnnotations:mapView.annotations];
            [self.mapView addAnnotation: annotation];
            
            MKCoordinateRegion region;
            region.center = annotation.coordinate;
            
            MKCoordinateSpan span;
            span.latitudeDelta = 0.01;
            span.longitudeDelta = 0.01;
            region.span = span;
            
            [self.mapView setRegion:region animated:YES];
        }
    }];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toStep3"]) {
        
        ToevoegenWanneerViewController *vc = [segue destinationViewController];
        vc.activity = activity;
        vc.category = category;
        
    }
}

@end
