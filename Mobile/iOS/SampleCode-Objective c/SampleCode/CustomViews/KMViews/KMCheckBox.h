//
//  KMCheckBox.h
//  Templates
//
//  Created by KETAN MODHA on 10/02/14.
//  Copyright (c) 2014 KETAN MODHA. All rights reserved.
//

//Create just a box with the default size

// Examples //

//KMCheckbox *allDefaults = [[KMCheckbox alloc] init];
//allDefaults.frame = CGRectMake(self.view.frame.size.width * 0.25, 25, allDefaults.frame.size.width, allDefaults.frame.size.height);
//[self.view addSubview:allDefaults];
//
////Custom Frame
//KMCheckbox *customFrame = [[KMCheckbox alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.25, 25 + allDefaults.frame.size.height + 8, 30, 30)];
//[self.view addSubview:customFrame];
//
////Basic Title
//KMCheckbox *basicTitle = [[KMCheckbox alloc] initWithTitle:@"Basic Title"];
//basicTitle.frame = CGRectMake(self.view.frame.size.width *0.25, customFrame.frame.origin.y + customFrame.frame.size.height + 8, basicTitle.frame.size.width, basicTitle.frame.size.height);
//[self.view addSubview:basicTitle];
//
////Title With custom height
//KMCheckbox *titleWithHeight = [[KMCheckbox alloc] initWithTitle:@"Custom Height" andHeight:30];
//titleWithHeight.frame = CGRectMake(self.view.frame.size.width * 0.25, basicTitle.frame.origin.y + basicTitle.frame.size.height + 8, titleWithHeight.frame.size.width, titleWithHeight.frame.size.height);
//[self.view addSubview:titleWithHeight];
//
////Left Alignment
//KMCheckbox *leftAlignment = [[KMCheckbox alloc] initWithTitle:@"KMCheckboxAlignmentLeft"];
//[leftAlignment setCheckAlignment:KMCheckboxAlignmentLeft];
//leftAlignment.frame = CGRectMake(self.view.frame.size.width * 0.25, titleWithHeight.frame.origin.y +titleWithHeight.frame.size.height + 8, leftAlignment.frame.size.width, leftAlignment.frame.size.height);
//[self.view addSubview:leftAlignment];
//
////Mixed
//KMCheckbox *mixed = [[KMCheckbox alloc] initWithTitle:@"KMCheckboxStateMixed"];
//[mixed setState:KMCheckboxStateMixed];
//mixed.frame = CGRectMake(self.view.frame.size.width * 0.25, leftAlignment.frame.origin.y + leftAlignment.frame.size.height + 8, mixed.frame.size.width, mixed.frame.size.height);
//[self.view addSubview:mixed];
//
////OSX-Style
//KMCheckbox *osx = [[KMCheckbox alloc] initWithTitle:@"OSX Style"];
//osx.flat = NO;
//osx.frame = CGRectMake(self.view.frame.size.width * 0.25, mixed.frame.origin.y + mixed.frame.size.height + 8, osx.frame.size.width, osx.frame.size.height);
//osx.strokeColor = [UIColor colorWithRed: 0.167 green: 0.198 blue: 0.429 alpha: 1];
//osx.checkColor = [UIColor colorWithRed:0.0 green:0.129 blue:0.252 alpha:1.0];
//osx.tintColor = [UIColor colorWithRed: 0.616 green: 0.82 blue: 0.982 alpha: 1];
//osx.uncheckedColor = [UIColor colorWithRed:0.925 green:0.925 blue:0.925 alpha:1.0];
//[self.view addSubview:osx];
//
////Custom Stroke
//KMCheckbox *stroke = [[KMCheckbox alloc] initWithTitle:@"Custom Stroke" andHeight:30];
//stroke.strokeColor = [UIColor redColor];
//stroke.strokeWidth = 3.0;
//stroke.frame = CGRectMake(self.view.frame.size.width * 0.25, osx.frame.origin.y + osx.frame.size.height + 8, stroke.frame.size.width, stroke.frame.size.height);
//[self.view addSubview:stroke];
//
////Custom Check Color
//KMCheckbox *check = [[KMCheckbox alloc] initWithTitle:@"Custom Check Color"];
//check.checkColor = [UIColor blueColor];
//check.frame = CGRectMake(self.view.frame.size.width * 0.25, stroke.frame.origin.y + stroke.frame.size.height + 8, check.frame.size.width, check.frame.size.height);
//[self.view addSubview:check];
//
////Custom tint color
//KMCheckbox *tint = [[KMCheckbox alloc] initWithTitle:@"Custom Tint Color"];
//tint.tintColor = [UIColor colorWithRed: 0.608 green: 0.967 blue: 0.646 alpha: 1];
//tint.frame = CGRectMake(self.view.frame.size.width * 0.25, check.frame.origin.y + check.frame.size.height + 8, tint.frame.size.width, tint.frame.size.height);
//[self.view addSubview:tint];
//
////Custom Unchecked Color
//KMCheckbox *unchecked = [[KMCheckbox alloc] initWithTitle:@"Custom Unchecked Color"];
//unchecked.uncheckedColor = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
//unchecked.frame = CGRectMake(self.view.frame.size.width * 0.25, tint.frame.origin.y + tint.frame.size.height + 8, unchecked.frame.size.width, unchecked.frame.size.height);
//[self.view addSubview:unchecked];
//
////Custom Radius
//KMCheckbox *radius = [[KMCheckbox alloc] initWithTitle:@"Custom Radius"];
//radius.radius = 5.0;
//radius.frame = CGRectMake(self.view.frame.size.width * 0.25, unchecked.frame.origin.y + unchecked.frame.size.height + 8, radius.frame.size.width, radius.frame.size.height);
//[self.view addSubview:radius];
//
////Disabled
//KMCheckbox *disabled = [[KMCheckbox alloc] initWithTitle:@"Disabled"];
//disabled.enabled = NO;
//disabled.frame = CGRectMake(self.view.frame.size.width * 0.25, radius.frame.origin.y + radius.frame.size.height + 8, disabled.frame.size.width, disabled.frame.size.height);
//[self.view addSubview:disabled];
//
////Disabled Checked
//KMCheckbox *disabledChecked = [[KMCheckbox alloc] initWithTitle:@"Disabled Checked"];
//disabledChecked.enabled = NO;
//[disabledChecked setCheckState:KMCheckboxStateChecked];
//disabledChecked.frame = CGRectMake(self.view.frame.size.width * 0.25, disabled.frame.origin.y + disabled.frame.size.height + 8, disabledChecked.frame.size.width, disabledChecked.frame.size.height);
//[self.view addSubview:disabledChecked];

#import <UIKit/UIKit.h>

#define KMCheckboxDefaultHeight 16.0

#define kBoxRadius 0.1875
#define kBoxStrokeWidth 0.05

//States
typedef enum {
    KMCheckboxStateUnchecked = NO, //Default
    KMCheckboxStateChecked = YES,
    KMCheckboxStateMixed
} KMCheckboxState;

//Box location compared to text
typedef enum {
    KMCheckboxAlignmentLeft,
    KMCheckboxAlignmentRight //Default
} KMCheckboxAlignment;

@interface KMCheckBox : UIControl

@property (nonatomic, retain) UILabel *titleLabel; //Label will fill available frame - box size.
@property (nonatomic, assign) KMCheckboxState checkState;
@property (nonatomic, assign) KMCheckboxAlignment checkAlignment UI_APPEARANCE_SELECTOR; //Set the box to the left or right of the text
@property (nonatomic, readonly) CGRect boxFrame; //Location of checkbox in control

//Values, the values returned by using the - (id)value method, this is a convenience method if you have a group of boxes on a page. That way one does not have to do if(box == mybox) {if( mybox.checkState == ... for every checkbox
@property (nonatomic, retain) id checkedValue;
@property (nonatomic, retain) id uncheckedValue;
@property (nonatomic, retain) id mixedValue;
- (id)value;

- (id)init; // create with default height
- (id)initWithFrame:(CGRect)frame; //manually override default frame, checkbox will fill height of frame, and label font size will be determined by the height
- (id)initWithTitle:(NSString *)title; // set the frame with a default height, width will expand to fit text
- (id)initWithTitle:(NSString *)title andHeight:(CGFloat)height;//set the frame with the specified height, width will expand to fit text

- (void)setTitle:(NSString *)title;
- (void)setState:(KMCheckboxState)state __attribute((deprecated("use setCheckState method")));
- (void)setCheckState:(KMCheckboxState)state;//Change state programitically
- (void)toggleState __attribute((deprecated("use toggleCheckState method")));
- (void)toggleCheckState;
- (void)autoFitFontToHeight;//If you change the font, run this to change the font size to fit the frame.
- (void)autoFitWidthToText;

- (UIBezierPath *)getDefaultShape;//One needs to subclass KMCheckbox and override this method to use a custom shape. see method for more details.

//Appearance
@property (nonatomic, assign) BOOL flat UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat strokeWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIColor *strokeColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIColor *checkColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIColor *tintColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIColor *uncheckedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat radius UI_APPEARANCE_SELECTOR;

@end
