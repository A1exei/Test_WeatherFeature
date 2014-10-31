//
//  ViewController.m
//  WeatherFeature_Test
//
//  Created by Alexei Naumann on 10/26/14.
//  Copyright (c) 2014 Alexei Naumann. All rights reserved.
//

#import "ViewController.h"
#import "OWMWeatherAPI.h"

@interface ViewController ()
@property NSArray *possibleCities;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _possibleCities = @[@"Toronto", @"Cancun", @"London", @"Moscow", @"Nairobi", @"Seattle"];
    self.cityPicker.dataSource = self;
    self.cityPicker.delegate = self;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:(235/255.0) green:(65/255.0) blue:(65/255.0) alpha:1.0] CGColor], (id)[[UIColor colorWithRed:(253/255.0) green:(195/255.0) blue:(71/255.0) alpha:1.0] CGColor], nil];
    
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    
    _weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"269dde2fc421e46a4d92a64185f5dc87"]; // Replace the key with your own
    
    // We want localized strings according to the prefered system language
    [_weatherAPI setLangWithPreferedLanguage];
    
    // We want the temperatures in celcius, you can also get them in farenheit.
    [_weatherAPI setTemperatureFormat:kOWMTempFahrenheit];
    
    [self.queryTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:45]];
    [self.currentTempLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:30]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _possibleCities.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _possibleCities[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_weatherAPI currentWeatherByCityName:_possibleCities[row] withCallback:^(NSError *error, NSDictionary *result) {
        if (error) {
            return;
        }
        
        self.queryTextView.text = @"";
        
        
        
//       NSLog(@"%@", [result description]);
        
        NSString *tempString = result[@"main"][@"temp"];
        
        [self runTempuratureKeywordLogic:tempString];
    
        self.queryTextView.text = [self.queryTextView.text stringByAppendingString:
                                   @" ("];
        
        self.queryTextView.text = [self.queryTextView.text stringByAppendingString:
                                   result[@"weather"][0][@"main"]];
        self.queryTextView.text = [self.queryTextView.text stringByAppendingString:
                                   @")"];
        
    }];
    
}




/////// Simple logic to add some hard-wired keywords for certain tempurature ranges ////////

- (void)runTempuratureKeywordLogic:(NSString *)tempuratureString {

    
    ////// Convert tempurature string to an int and then add degree symbol
    int tempNumber = [tempuratureString intValue];
//    NSLog(@"Temp: %d", tempNumber);
    self.currentTempLabel.text = [NSString stringWithFormat:@"%d", tempNumber];
    self.currentTempLabel.text=[NSString stringWithFormat:@"%@%@", self.currentTempLabel.text,
                                [NSString stringWithFormat:@"\u00B0 F"]];
    
    
    
    if (tempNumber < 30) {
        self.queryTextView.text=[NSString stringWithFormat:@"%@%@", self.queryTextView.text, [self.queryTextView.text stringByAppendingString:@" Freezing Cold Snow"]];
        
    } else if (tempNumber < 40) {
        self.queryTextView.text=[NSString stringWithFormat:@"%@%@", self.queryTextView.text, [self.queryTextView.text stringByAppendingString:@" Chill Frost Cold"]];
        
    } else if (tempNumber < 50) {
        self.queryTextView.text=[NSString stringWithFormat:@"%@%@", self.queryTextView.text, [self.queryTextView.text stringByAppendingString:@" Breeze Cool Autumn"]];
        
    } else if (tempNumber < 70) {
        self.queryTextView.text=[NSString stringWithFormat:@"%@%@", self.queryTextView.text, [self.queryTextView.text stringByAppendingString:@" Sweater Breeze Wind"]];
        
    } else if (tempNumber < 85) {
        self.queryTextView.text=[NSString stringWithFormat:@"%@%@", self.queryTextView.text, [self.queryTextView.text stringByAppendingString:@" Warm Sun Happy"]];

    } else if (tempNumber < 125) {
        self.queryTextView.text=[NSString stringWithFormat:@"%@%@", self.queryTextView.text, [self.queryTextView.text stringByAppendingString:@" Hot Heat Desert"]];
        
    } else {
        
    }
    
}
@end
