//
//  ToevoegenWatViewController.h
//  Bredapp
//
//  Created by Leroy Meijer on 11/2/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TempActivity.h"
#import "Category.h"

@interface ToevoegenWatViewController : UIViewController< UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    UIPickerView*categoriePicker;
    NSMutableArray*categorieen;
    NSInteger selectedRow;
    NSMutableArray *categoriedataArray;
}
@property (nonatomic, retain) NSString *selectedText;
@property (nonatomic, strong) AppDelegate *myApp;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,retain) NSFetchedResultsController * fetchedResultsController;

@property (strong, nonatomic) IBOutlet UITextField *categorieTextveld;
@property (strong, nonatomic) IBOutlet UITextField *titel;
@property (strong, nonatomic) IBOutlet UITextField *tags;
@property (strong, nonatomic) IBOutlet UITextView *beschrijving;
@property (strong, nonatomic) IBOutlet UITextField *aanspreekpunt;
@property (strong, nonatomic) IBOutlet UIImageView *foto;

@property (strong, nonatomic) TempActivity *activity;
@property (strong, nonatomic) Category *category;

- (IBAction)selectOrTakePhoto:(id)sender;
- (IBAction)textfieldClicked:(id)sender;
- (IBAction)textfieldLooseFocus:(id)sender;

-(void) setComboData:(NSMutableArray *) data;
-(void)categorie_tapped;
-(UIImage*)imageWithImage:(UIImage*)image
             scaledToSize:(CGSize)newSize;


@end
