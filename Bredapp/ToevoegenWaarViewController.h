//
//  ToevoegenWaarViewController.h
//  Bredapp
//
//  Created by redj on 11/2/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Activity.h"
#import "Category.h"

@interface ToevoegenWaarViewController : UIViewController <UITextFieldDelegate, UIGestureRecognizerDelegate>{
    CLGeocoder *_geocoder;
}

@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) IBOutlet UITextField *addressField;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) Activity *activity;
@property (retain, nonatomic) IBOutlet UIButton *eigenLocatie;
@property (retain, nonatomic) IBOutlet UIButton *laatZien;

@end
