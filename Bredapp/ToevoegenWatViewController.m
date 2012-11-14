//
//  ToevoegenWatViewController.m
//  Bredapp
//
//  Created by Leroy Meijer on 11/2/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "ToevoegenWatViewController.h"
#import "ToevoegenWaarViewController.h"
#import "TempActivity.h"
#import "JsonParser.h"

@interface ToevoegenWatViewController ()

@end

@implementation ToevoegenWatViewController{
    NSString *fotoUrl;
}

@synthesize titel,beschrijving,tags,aanspreekpunt,foto,categorieTextveld;
@synthesize activity, category;
@synthesize myApp, managedObjectContext,selectedText,categoriePlaatje;
@synthesize fetchedResultsController = _fetchedResultsController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectedRow = 0;
	// Do any additional setup after loading the view.
    
    // Custom buttons
//    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *backImage = [UIImage imageNamed:@"back_button.png"];
//    [back setBackgroundImage:backImage forState:UIControlStateNormal];
//    [back addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
//    back.frame = CGRectMake(50, 20, 51, 43);
//    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:back];
//    self.navigationItem.leftBarButtonItem = backButton;
    
    myApp = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [myApp managedObjectContext];
    categorieen = [[NSMutableArray alloc]init];
    
    
    //laad categorieen in van db http://www.larsvanbeek.nl/BredAppWs/categories/
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    id  sectionInfo =
    [[_fetchedResultsController sections] objectAtIndex:0];
    
    for(int i = 0; i<[sectionInfo numberOfObjects]; i++)
    {
        Category * t = [[self.fetchedResultsController fetchedObjects] objectAtIndex:i];
        [categorieen addObject:t];
    }

    
   // categoriePicker = [[UIPickerView alloc]init];
   // categoriePicker.showsSelectionIndicator = YES;
   // categoriePicker.dataSource = self;
   // categoriePicker.delegate = self;
   // categoriePicker.userInteractionEnabled = YES;
    
   // UITapGestureRecognizer *categorie_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(categorie_tapped)];
   // [categorie_tap setDelegate:self];
   // [categoriePicker addGestureRecognizer:categorie_tap];
    
    self.categorieTextveld.delegate = self;
    self.categorieTextveld.inputView = categoriePicker;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Category" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"category_id" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"CategoryList"];
    self.fetchedResultsController = theFetchedResultsController;
    //_fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}


-(void)categorie_tapped{
    if([self->categoriePicker selectedRowInComponent:0]>=0)
    {
        Category *t = [categorieen objectAtIndex:[self->categoriePicker selectedRowInComponent:0]];
        category = t;
        [self.categorieTextveld setText:t.name];
        [self.categorieTextveld resignFirstResponder];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.titel resignFirstResponder];
    [self.tags resignFirstResponder];
    [self.beschrijving resignFirstResponder];
    [self.aanspreekpunt resignFirstResponder];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    id  sectionInfo =
    [[_fetchedResultsController sections] objectAtIndex:component];
    return [sectionInfo numberOfObjects];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //id  sectionInfo =
    //[[_fetchedResultsController sections] objectAtIndex:component];
    //Category * t = [[self.fetchedResultsController fetchedObjects] objectAtIndex:row];
    //[categorieen addObject:t];
    //return t.name;
    Category *t = [categorieen objectAtIndex:row];
    return t.name;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedRow = row;
    Category *t =  [categorieen objectAtIndex:row];
    category = t;
    categorieTextveld.text = t.name;
    categoriePlaatje.image = [UIImage imageWithData:(t.image)];
    selectedText = categorieTextveld.text;
    
    
   // NSData *imageData = UIImagePNGRepresentation(image);
    
    //UIImage *image=[UIImage imageWithData:data];
}

- (void)setComboData:(NSMutableArray *)data
{
    categoriedataArray = data;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage * takenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    takenImage = [self imageWithImage:takenImage scaledToSize:CGSizeMake(400, 400)];
    fotoUrl = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"URL: %@", fotoUrl);
    self.foto.image = takenImage;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIImage*)imageWithImage:(UIImage*)image
             scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self showPicker:textField];
    return YES;
    /*
    BOOL editable = YES;
    if(textField == categorieTextveld)
    {
        editable = YES;
    }
    return editable;
     */
}

/*
 //IOS 6 functie
 -(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
 return NO;
 }
 */

- (IBAction)selectOrTakePhoto:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Foto maken",@"Bestaande foto",@"Annuleer", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];

    
    
    /*UIImagePickerController * pickerC = [[UIImagePickerController alloc]init];
    pickerC.delegate = self;
    [self presentViewController:pickerC animated:YES completion:nil];
     */
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
        UIImagePickerController * pickerC = [[UIImagePickerController alloc]init];
        pickerC.delegate = self;
    
        if(buttonIndex == 0)
        {
            //foto maken
            #if TARGET_IPHONE_SIMULATOR
            NSLog("Dit is de simulator je kunt geen foto maken!");
            #else
            pickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickerC animated:YES completion:nil];
            #endif
        }
        else if(buttonIndex == 1)
        {
            //foto zoeken
            //UIImagePickerController * pickerC = [[UIImagePickerController alloc]init];
            
            [self presentViewController:pickerC animated:YES completion:nil];
        }
}

- (IBAction)showPicker:(id)sender
{
    categoriePicker = [[UIPickerView alloc] init];
    categoriePicker.showsSelectionIndicator = YES;
    categoriePicker.dataSource = self;
    categoriePicker.delegate = self;
    
    [categoriePicker selectRow:selectedRow inComponent:0 animated:NO];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [toolbar sizeToFit];
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil
                                                                                       action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Klaar"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(doneClicked:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    
    categorieTextveld.inputView = categoriePicker;
    categorieTextveld.inputAccessoryView = toolbar;
}


- (void)doneClicked:(id)sender
{
    [categorieTextveld resignFirstResponder];
}

- (IBAction)textfieldClicked:(id)sender {
    //NSLog(@"User clicked %@", sender);
    
    //tag 0 = titel
    //tag 1 = categorie hoeft niets te gebeuren
    //tag 2 = tags
    //tag 3 = beschrijving er kan GEEN IBAction aan een UITextView gekoppeld worden
    //tag 4 = aanspreekpunt
    switch ([sender tag]){
        case 0:{
            self.titel.text = @"";
            break;
        }
        case 1:{
            break;
        }
        case 2:{
            self.tags.text = @"";
            break;
        }
        case 3:{
            self.beschrijving.text = @"";
            break;
        }
        case 4: {
            self.aanspreekpunt.text = @"";
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame;
                frame = self.view.frame;
                frame.origin.y=-150;
                self.view.frame = frame;
            }];
            break;
        }
        default:{
            break;
        }
    }
}



- (IBAction)textfieldLooseFocus:(id)sender {
    //NSLog(@"User clicked %@", sender);
    
    //tag 0 = titel
    //tag 1 = categorie hoeft niets te gebeuren
    //tag 2 = tags
    //tag 3 = beschrijving er kan GEEN IBAction aan een UITextView gekoppeld worden
    //tag 4 = aanspreekpunt
    
    if([sender tag] == 4 || [sender tag] == 3)
    {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame;
            frame = self.view.frame;
            frame.origin.y=0;
            self.view.frame = frame;
        }];
    }
    
    NSString * t = [sender text];
    t = [t stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger i = t.length;
    if(i == 0 || t == @"")
    {
        switch ([sender tag]){
            case 0:{
                self.titel.text = @"Titel";
                break;
            }
            case 1:{
                break;
            }
            case 2:{
                self.tags.text = @"Tags, Tags...";
                break;
            }
            case 3:{
                self.beschrijving.text = @"";
                break;
            }
            case 4: {
                self.aanspreekpunt.text = @"Aanspreekpunt* optioneel";
                break;
            }
            default:{
                break;
            }
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    //[self setCategorieButton:nil];
    [super viewDidUnload];
}
- (void)dealloc {

    [super dealloc];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toStep2"]) {
        //[NSEntityDescription entityForName:@"Activity" inManagedObjectContext:self.managedObjectContext];
        
//        activity = (Activity *) [NSEntityDescription insertNewObjectForEntityForName:@"Activity"
//                                                                        inManagedObjectContext:[self managedObjectContext]];
        
        activity = [[TempActivity alloc] init];
        
        //activity
        activity.category_id = category.category_id;
        activity.title = self.titel.text;
        activity.fkactivity2category = category;
        activity.tags = self.tags.text;
        activity.content = self.beschrijving.text;
        activity.image = self.foto.image;
        
        ToevoegenWaarViewController *vc = [segue destinationViewController];
        vc.activity = activity;
    }
}

@end
