//
//  ToevoegenWatViewController.m
//  Bredapp
//
//  Created by Leroy Meijer on 11/2/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "ToevoegenWatViewController.h"
#import "ToevoegenWaarViewController.h"
#import "Activity.h"
#import "Category.h"
#import "Toevoeger.h"

@interface ToevoegenWatViewController ()

@end

@implementation ToevoegenWatViewController{}

@synthesize titel,beschrijving,tags,aanspreekpunt,foto,categorieTextveld;
@synthesize categorieArray;

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
    
    categorieArray = [[NSArray alloc] initWithObjects:@"Sport",@"Cultuur",@"Muziek", nil];

    categoriePicker = [[UIPickerView alloc]init];
    categoriePicker.showsSelectionIndicator = YES;
    categoriePicker.dataSource = self;
    categoriePicker.delegate = self;
    categoriePicker.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *categorie_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(categorie_tapped)];
    [categorie_tap setDelegate:self];
    [categoriePicker addGestureRecognizer:categorie_tap];
    
    self.categorieTextveld.inputView = categoriePicker;
}

-(void)categorie_tapped{
    if([self->categoriePicker selectedRowInComponent:0]>=0)
    {
        [self.categorieTextveld setText:[categorieArray objectAtIndex:[self->categoriePicker selectedRowInComponent:0]]];
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
    return [categorieArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [categorieArray objectAtIndex:row];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage * takenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
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

/*
 //IOS 6 functie
 -(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
 return NO;
 }
 */

- (IBAction)selectOrTakePhoto:(id)sender {
    UIImagePickerController * pickerC = [[UIImagePickerController alloc]init];
    pickerC.delegate = self;
    [self presentViewController:pickerC animated:YES completion:nil];
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
    
    if([sender tag] == 4)
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
        /*
        activity = [[Activity alloc] init];
        activity.title = titel.text;
        activity.category_id = "";
        activity.tags = tags.text;
        activity.content = beschrijving.text;
        
        category = [[Category alloc] init];

        ToevoegenWaarViewController *vc = [segue destinationViewController];
        vc.activity = activity;
        vc.category = category;
       */
        
        Toevoeger *toevoeger = [[Toevoeger alloc] init];
        toevoeger.title = titel.text;
        //toevoeger.category_id = "";
        toevoeger.tags = tags.text;
        toevoeger.content = beschrijving.text;
        
        ToevoegenWaarViewController *vc = [segue destinationViewController];
        vc.toevoeger = toevoeger;
    }
}

@end
