//
//  main.swift
//  iTunesScripting
//
//  Created by Are Digranes on 05.05.15.
//  Copyright (c) 2015 Are Digranes. All rights reserved.
//

// Example of use:
import ScriptingBridge
var tunes: iTunesApplication
if let tunesApp = SBApplication(bundleIdentifier: iTunesBundleIdentifier) {
    tunes = tunesApp
} else {
    println("No tunes today")
    exit(0)
}

if let apdevices = tunes.AirPlayDevices?() {
    for d in apdevices {
        if let apdev = d as? iTunesAirPlayDevice {
            if let name = apdev.name!, net = apdev.networkAddress! {
                println("iTunes AirPlay devices: \(name) at \(net)")
                if let eapd = iTunesEAPD(rawValue: apdev.kind!) {
                    switch eapd {
                    case .iTunesEAPDComputer:
                        println("Device is of type computer")
                    case .iTunesEAPDAirPortExpress:
                        println("Device is of type Airport Express")
                    case .iTunesEAPDAppleTV:
                        println("Device is of type Apple TV")
                    case .iTunesEAPDAirPlayDevice:
                        println("Device is of type AirPlay device")
                    case .iTunesEAPDUnknown:
                        println("Device is of unknown type")
                    }
                }
            }
        }
    }
}

if let track = tunes.currentTrack! {
    print("Now playing: ")
    if let name = track.name! {
        print("\(name) ")
    }
    if let artist = track.artist! {
        print("by \(artist) ")
    }
    if let album = track.album! {
        print("from \(album) ")
    }
    if let composer = track.composer! {
        print("composed by \(composer) ")
    }
    print("\n")
    print("File is ")
    if let kind = track.kind! {
        print("\(kind) ")
    }
    if let bitRate = track.bitRate {
        print("\(bitRate) kbps ")
    }
    if let sampleRate = track.sampleRate {
        print("\(sampleRate) hz ")
    }
    if let time = track.time! {
        print("lasting \(time) ")
    }
    if let dateAdded = track.dateAdded! {
        print("added on \(dateAdded) ")
    }
    if let persistentID = track.persistentID! {
        print("and have ID \(persistentID) ")
    }
    print("\n")
}

