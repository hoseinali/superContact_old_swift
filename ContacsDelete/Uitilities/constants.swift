//
//  constants.swift
//  ContacsDelete
//
//  Created by hosein on 7/22/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation

// typealias
typealias COMPLETION_SUCCESS = (_ Success:Bool) -> ()

// identifire
let DELETE_CONATACT_CELL = "contactCell"
let DUPLICATE_CONTACT_CELL = "duplicateCell"
let SECRET_CONTACT_CELL = "secretCell"
let SAME_NAME_CELL = "sameNameCell"
let DETAIL_SAME_NAME_CELL = "detailSameNameCell"
let SAME_PHONE_CELL = "samePhoneCell"
let DETAIL_SAME_PHONE_CELL = "detailSamePhoneCell"
let NO_NUMBER_CELL = "noNumberCell"
let NO_NAME_CELL = "noNmeCell"
let SAME_CONTACT_CELL = "SameContactCell"
let DETAIL_SAME_CONTACT_CELL = "detailSameContactCell"

// segue
let GO_TO_SECRET_CONTACT = "goToSecretContact"
let GO_TO_DETAIL_SAME_NAME = "goToDetailSameName"
let GO_TO_DETIAL_SAME_PHONE = "goToDetialSamePhone"
let GO_TO_DETIAL_SAME_CONTACT = "goToDetialSameContact"

// font
let FONT_TITEL = "PRIMETIME"

// NOTIFACTION NAMAE
let FETECH_CONATACT_NOTIFACTION = Notification.Name("fetechContact")
let FETECH_SAME_PHONE_NOTIFICATION = Notification.Name("fetechSamePhone")

// user default
let PASSWORD_KEY = "password"
let IS_CERATED_PASSWORD = "IsCeratedPassword"
