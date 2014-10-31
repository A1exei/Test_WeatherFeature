//
//  ViewController.h
//  WeatherFeature_Test
//
//  Created by Alexei Naumann on 10/26/14.
//  Copyright (c) 2014 Alexei Naumann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWMWeatherAPI.h"

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>


@property (strong, nonatomic) IBOutlet UIPickerView *cityPicker;
@property OWMWeatherAPI *weatherAPI;
@property (strong, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (strong, nonatomic) IBOutlet UITextView *queryTextView;
@property NSDateFormatter *dateFormatter;
@end

