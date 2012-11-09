//
//  ToevoegenWatViewController.h
//  Bredapp
//
//  Created by Leroy Meijer on 11/2/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToevoegenWatViewController : UIViewController< UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (assign,nonatomic)NSArray * categorieArray;

@property (strong, nonatomic) IBOutlet UIView * categorieMenu;
@property (strong, nonatomic) IBOutlet UITextField *categorieTextveld;
@property (strong, nonatomic) IBOutlet UIButton *categorieButton;
@property (strong, nonatomic) IBOutlet UITextField *titel;
@property (strong, nonatomic) IBOutlet UITextField *tags;
@property (strong, nonatomic) IBOutlet UITextView *beschrijving;
@property (strong, nonatomic) IBOutlet UITextField *aanspreekpunt;
@property (strong, nonatomic) IBOutlet UIImageView *foto;

- (IBAction)categorieSelectionMade:(UIButton *)sender;
- (IBAction)categorieAction:(UIButton *)sender;
- (IBAction)selectOrTakePhoto:(id)sender;
- (IBAction)saveCategorie:(id)sender;
- (IBAction)textfieldClicked:(id)sender;
- (IBAction)textfieldLooseFocus:(id)sender;

-(void)sync;
-(UIImage*)imageWithImage:(UIImage*)image
             scaledToSize:(CGSize)newSize;


@end
