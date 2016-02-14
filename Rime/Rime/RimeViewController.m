//
//  ViewController.m
//  Rime
//
//  Created by rav subedi on 12/1/15.
//  Copyright © 2015 Ravi Kumar Subedi. All rights reserved.
//

#import "RimeViewController.h"
#import "RimeEntities.h"
#import "RimeCoreStack.h"
#import <CoreLocation/CoreLocation.h>

@interface RimeViewController ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) UIImage *pickedImage;
@property(nonatomic, strong) NSString *location;
@property(nonatomic, assign) enum rimeEntryMood pickedMood;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;
@property (weak, nonatomic) IBOutlet UIButton *averageButton;
@property (weak, nonatomic) IBOutlet UIButton *badButton;
@property (weak, nonatomic) IBOutlet UIView *accessoryView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation RimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *date;
    if (self.entitie != nil) {
        self.textView.text = self.entitie.body;
        self.pickedMood = self.entitie.mood;
        date = [NSDate dateWithTimeIntervalSince1970:self.entitie.date];
        }else {
        //self.pickedMood = rimeEntryMoodGood;
        date = [NSDate date];
        [self loadLocation];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"EEEE MMMM dd, yyyy"];
    
    self.dateLabel.text = [dateFormatter stringFromDate:date];
    
    self.textView.inputAccessoryView = self.accessoryView;
    self.imageButton.layer.cornerRadius = CGRectGetWidth(self.imageButton.frame)/2.0f;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dismissSelf{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadLocation{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = 1000;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        }
    [self.locationManager startUpdatingLocation];
    
    }
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self.locationManager stopUpdatingLocation];
    CLLocation *location = [locations firstObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks firstObject];
        self.location = placemark.name;
    }];
}
-(void)insertRimeEntry{
    RimeCoreStack *coredataStack = [RimeCoreStack defaultStack];
    RimeEntities *entity = [NSEntityDescription insertNewObjectForEntityForName:@"RimeEntities" inManagedObjectContext:coredataStack.managedObjectContext];
    entity.body = self.textView.text;
    entity.date = [[NSDate date]timeIntervalSince1970];
    entity.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    entity.mood = self.pickedMood;
    entity.location = self.location;
    [coredataStack saveContext];
}

- (void)updateRimeEntry{
    self.entitie.body = self.textView.text;
    self.entitie.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    self.entitie.mood = self.pickedMood;
    RimeCoreStack *coredataStack = [RimeCoreStack defaultStack];
    [coredataStack saveContext];
}
- (IBAction)cancelWasPressed:(id)sender {
    if (self.entitie != nil) {
        [self updateRimeEntry];
    } else{
        [self insertRimeEntry];
    }
    [self dismissSelf];
}
- (void)promptForSource{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Image Source" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Roll", nil];
    [actionSheet showInView:self.view];
}
- (void)promptForCamera {
    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)promptForPhotoRoll {
    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.pickedImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setPickedImage:(UIImage *)pickedImage{
    _pickedImage = pickedImage;
    if (pickedImage == nil) {
         [self.imageButton setImage:[UIImage imageNamed:@"icn_noimage"] forState:UIControlStateNormal];
    }else{
        [self.imageButton setImage:pickedImage forState:UIControlStateNormal];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        if (buttonIndex != actionSheet.firstOtherButtonIndex) {
            [self promptForPhotoRoll];
        } else {
            [self promptForCamera];
        }
    }
}



- (void)setPickedMood:(enum rimeEntryMood)pickedMood{
    _pickedMood = pickedMood;
    self.badButton.alpha = 0.5f;
    self.averageButton.alpha = 0.5f;
    self.badButton.alpha = 0.5f;
    
    switch (pickedMood) {
        case rimeEntryMoodAverage:
            self.averageButton.alpha = 1.0f;
            break;
        case rimeEntryMoodBad:
            self.badButton.alpha = 1.0f;
            break;
        case rimeEntryMoodGood:
            self.goodButton.alpha = 1.0f;
            break;
    }
}
- (IBAction)doneWasPressed:(id)sender {
    [self insertRimeEntry];
    [self dismissSelf];
}
- (IBAction)goodWasPressed:(id)sender {
    self.pickedMood = rimeEntryMoodGood;
}
- (IBAction)averageWasPressed:(id)sender {
    self.pickedMood = rimeEntryMoodAverage;
}
- (IBAction)badWasPressed:(id)sender {
    self.pickedMood = rimeEntryMoodBad;
}
- (IBAction)imageButtonWasPressed:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        [self promptForSource];
    } else{
        [self promptForPhotoRoll];
    }
}

@end
