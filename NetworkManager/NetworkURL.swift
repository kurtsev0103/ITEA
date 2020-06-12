//
//  NetworkURL.swift
//  NetworkURL
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import UIKit

/*
* --------------------------------------------------------
*      Singleton
* --------------------------------------------------------
*/

let kSharedNetworkHelpers = NetworkHelpers.shared

/*
 * --------------------------------------------------------
 *      HTTP Basic Authentication
 * --------------------------------------------------------
 */

let kHTTPUsername           = ""
let kHTTPPassword           = ""
let OS                      = UIDevice.current.systemVersion
let kAppVersion             = "1.0"
let kDeviceModel            = UIDevice.current.model

/*
 * --------------------------------------------------------
 *      API Base URL defined by Targets.
 * --------------------------------------------------------
 */

// wizz Server
let kBASEURL                    = "https://filter.aladin.od.ua/api/"
let kSERVERURL                  = "https://filter.aladin.od.ua/"
let kImageBaseUrl               = ""

let kAuthentication     = "Authentication"
let kEncryptionKey      = ""

/* --------------------------------------------------------
 *      Used Web Services Name
 * --------------------------------------------------------
 */

let kSignUp                      = "register"
let kLogin                       = "login"
let kPerson                      = "user"
let kSettings                    = "settings"
let kRoomSettings                = "room/setting"
let kFriend                      = "friend"
let kPhoto                       = "foto"
let kFile                        = "file"
let kForgotPassword              = "password/reset"
let kExportChat                  = "export"
let kDegrading                   = "degrading"
let kAbusive                     = "abusive"
let kDefaultAvatartUrl           = "/files/avatars/default.png"
let kInviteUser                  = "invite"

/*
 * --------------------------------------------------------
 *      API Request & Response Parameters Keys
 * --------------------------------------------------------
 */

let kEmail                      = "email"
let kPhone                      = "phone_number"
let kPassword                   = "password"
let kName                       = "name"
let kChildren                   = "children"
let kNames                      = "names"
let kAuthtype                   = "authtype"
let kDateOfBirth                = "date_of_birth"
let kChannel                    = "channel"
let kWork                       = "work"
let kAuthType                   = "authtype"
let kStartDate                  = "start"
let kEndDate                    = "end"
let kRoomId                     = "room_id"
let kAvatar                     = "avatar"
let kSettingsUser               = "settings"
let kSettingsMy                 = "settings_my"
let kSettingsSpouse             = "setting_spouse"

let kTokenDevice                = "token_device"
let kDevice_type                = "device_type"
let kDeviceId                   = "device_id"
let kRegistrationId             = "registration_id"

let kMessage                    = "message"
let kIsEmailVerified            = "is_email_verified"
let kMediaFiles                 = "media_files"
let kProfilePicture             = "profile_picture"
