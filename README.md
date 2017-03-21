Auction iOS App
======

> Auction and bidding for redundant goods, having its own backend.

## Overview

### 1. Main Features
- User management  
Signup, Login, Profile, Setting, ...
- Item Management  
Upload, Search, Category, Contact, Inbox, ...
- Bid Management  
Place bid, Get max bid, Give up, Delete, ...
 
### 2. Techniques 
#### 2.1 UI Implementation
- Implemented responsive UI design with Autolayout
- Used Autoresize for some customized controls
- Implemented length limit of Textfield and TextView    
textFieldDidBeginEditing, textFieldShouldEndEditing functions are used mainly.
- Made tabbar item working as button  
Implemented using shouldSelectViewController of UITabBarControllerDelegate.
- Saved data in plist file  
Created in Resource manually, implemented read/write programatically.

#### 2.2 Third Party Libraries used
- [TPKeyboardAvoiding](https://github.com/michaeltyson/TPKeyboardAvoiding)  
Automatically make view avoiding keyboard
- [ActionSheetPicker](https://github.com/skywinder/ActionSheetPicker-3.0)    
ActionSheetDatePicker and ActionSheetStringPicker are used.
- [TTTAttributedLabel](https://github.com/TTTAttributedLabel/TTTAttributedLabel)    
Make UILabel working as button
- [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD)    
Progress bar used in calling web service
- [AFNetworking](https://github.com/AFNetworking/AFNetworking)    
HTTP processing in iOS

## Need to Improve
- Add logic for push notification
- Integrate social login & sharing
- Integrate chat feature  
... ...