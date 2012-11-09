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

@interface ToevoegenWaarViewController ()

@end

@implementation ToevoegenWaarViewController{
    
    NSMutableArray *myAnnotations;
}

@synthesize addressField;
@synthesize mapView;
@synthesize geocoder;

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
    
    addressField.delegate = self;
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //user needs to press for 2 seconds
    [self.mapView addGestureRecognizer:lpgr];
    [lpgr release];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer* panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragMap:)];
    [panRec setDelegate:self];
    [self.mapView addGestureRecognizer:panRec];
    
    mapView.mapType = MKMapTypeHybrid;
    mapView.showsUserLocation = true;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)dismissKeyboard {
    [addressField resignFirstResponder];
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    
    if (!self.geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    CLLocation *locatie = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    
    [self.geocoder reverseGeocodeLocation: locatie completionHandler:
     
     ^(NSArray *placemarks, NSError *error) {
         
         
         
         //Get nearby address
         
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         
         
         
         //String to hold address
         
         NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         
         addressField.text = locatedAt;
         
         MapAnnotation *annotation = [[MapAnnotation alloc] initWithTitle:@"test" subtitle:@"bla" coordinate:touchMapCoordinate];
         
         MKCoordinateRegion region;
         region.center = annotation.coordinate;
         
         MKCoordinateSpan span;
         span.latitudeDelta = 0.01;
         span.longitudeDelta = 0.01;
         region.span = span;
         
         [self.mapView removeAnnotations:mapView.annotations];
         [self.mapView addAnnotation: annotation];
         [self.mapView setRegion:region animated:YES];
         [annotation release];
         
         //Print the location to console
         //NSLog(@"I am currently at %@",locatedAt);
         
         
     }];
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

- (IBAction)updateLocatie:(id)sender {
    if (!self.geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    [self.geocoder geocodeAddressString:addressField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Info: %@", [error localizedDescription]);
            return;
        }
        
        for (id object in placemarks) {
            CLPlacemark *placemark = object;
            
            MapAnnotation *annotation = [[MapAnnotation alloc] initWithTitle:[NSString stringWithFormat:@"%@ %@", placemark.postalCode, placemark.locality] subtitle:placemark.subLocality coordinate:placemark.location.coordinate];
            
            
            [self.mapView removeAnnotations:myAnnotations];
            [self.mapView addAnnotation: annotation];
            
            [myAnnotations addObject:annotation];
            
            MKCoordinateRegion region;
            region.center = annotation.coordinate;
            
            MKCoordinateSpan span;
            span.latitudeDelta = 0.01;
            span.longitudeDelta = 0.01;
            region.span = span;
            
            [self.mapView setRegion:region animated:YES];
        }
        
        [addressField resignFirstResponder];
    }];
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

- (IBAction)mijnLocatie:(id)sender {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = mapView.userLocation.location.coordinate.latitude;
    location.longitude = mapView.userLocation.location.coordinate.longitude;
    
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithTitle:@"" subtitle:@"" coordinate:mapView.userLocation.location.coordinate];
    
    
    [self.mapView removeAnnotations:myAnnotations];
    [self.mapView addAnnotation: annotation];
    
    [myAnnotations addObject:annotation];
    
    region.span = span;
    region.center = location;
    [mapView setRegion:region animated:YES];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
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
            
            [self.mapView removeAnnotations:myAnnotations];
            [self.mapView addAnnotation: annotation];
            
            [myAnnotations addObject:annotation];
            
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
        NSLog(@"Naar stap 3!");
    }
}

@end
