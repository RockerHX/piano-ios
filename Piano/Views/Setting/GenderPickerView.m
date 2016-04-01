//
//  GenderPickerView.m
//  mia
//
//  Created by linyehui on 2015/09/09.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import "GenderPickerView.h"
#import "Masonry.h"
#import "UIConstants.h"

const static NSInteger kGenderPickerComponentCount = 1;
const static NSInteger kGenderPickerComponentIndex = 0;

@interface GenderPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation GenderPickerView {
	UIPickerView 	*_genderPicker;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if(self){
		self.userInteractionEnabled = YES;
//		self.backgroundColor = [UIColor redColor];

		[self initUI];
}

	return self;
}

- (void)dealloc {
}

- (void)initUI {
	self.backgroundColor = UIColorByHex(0xa2a2a2);
	[self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blankTouchAction:)]];

	_genderPicker = [[UIPickerView alloc]init];
	_genderPicker.backgroundColor = [UIColor whiteColor];
	_genderPicker.showsSelectionIndicator=YES;
	_genderPicker.delegate=self;
	_genderPicker.dataSource=self;
	[self addSubview:_genderPicker];

	[_genderPicker mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.mas_left);
		make.bottom.equalTo(self.mas_bottom);
		make.right.equalTo(self.mas_right);
	}];
}

- (void)setGender:(NSInteger)gender {
	_gender = gender;
	if (_gender == MIAGenderMale) {
		[_genderPicker selectRow:0 inComponent:kGenderPickerComponentIndex animated:NO];
	} else {
		[_genderPicker selectRow:1 inComponent:kGenderPickerComponentIndex animated:NO];
	}
}

#pragma mark - delegate 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return kGenderPickerComponentCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if(0 == row) {
		return @"男";
	} else {
		return @"女";
	}
}

#pragma mark - action

- (void)blankTouchAction:(id)sender {
	MIAGender result = MIAGenderUnknown;
	if (0 == [_genderPicker selectedRowInComponent:kGenderPickerComponentIndex]) {
		result = MIAGenderMale;
	} else {
		result = MIAGenderFemale;
	}

	if (_delegate && [_delegate respondsToSelector:@selector(genderPickerDidSelected:)]) {
		[_delegate genderPickerDidSelected:result];
	}
	[self removeFromSuperview];
}

@end
