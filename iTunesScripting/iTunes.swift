//
//  iTunes.swift
//  iTunesScripting
//
//  Created by Are Digranes on 05.05.15.
//  Copyright (c) 2015 Are Digranes. All rights reserved.
//
//  Version 1.0α    -   05.05.15    -   Initial creation
//

import AppKit
import ScriptingBridge

// Enums

enum iTunesEKnd: String {
    case iTunesEKndTrackListing = "kTrk"                    /* a basic listing of tracks within a playlist */
    case iTunesEKndAlbumListing = "kAlb"                    /* a listing of a playlist grouped by album */
    case iTunesEKndCdInsert = "kCDi"                        /* a printout of the playlist for jewel case inserts */
}

enum iTunesEnum: String {
    case iTunesEnumStandard = "lwst"                        /* Standard PostScript error handling */
    case iTunesEnumDetailed = "lwdt"                        /* print a detailed report of PostScript errors */
}

enum iTunesEPlS: String {
    case iTunesEPlSStopped = "kPSS"
    case iTunesEPlSPlaying = "kPSP"
    case iTunesEPlSPaused = "kPSp"
    case iTunesEPlSFastForwarding = "kPSF"
    case iTunesEPlSRewinding = "kPSR"
}

enum iTunesERpt: String {
    case iTunesERptOff = "kRpO"
    case iTunesERptOne = "kRp1"
    case iTunesERptAll = "kAll"
}

enum iTunesEVSz: String {
    case iTunesEVSzSmall = "kVSS"
    case iTunesEVSzMedium = "kVSM"
    case iTunesEVSzLarge = "kVSL"
}

enum iTunesESrc: String {
    case iTunesESrcLibrary = "kLib"
    case iTunesESrcIPod = "kPod"
    case iTunesESrcAudioCD = "kACD"
    case iTunesESrcMP3CD = "kMCD"
    case iTunesESrcRadioTuner = "kTun"
    case iTunesESrcSharedLibrary = "kShd"
    case iTunesESrcUnknown = "kUnk"
}

enum iTunesESrA: String {
    case iTunesESrAAlbums = "kSrL"                          /* albums only */
    case iTunesESrAAll = "kAll"                             /* all text fields */
    case iTunesESrAArtists = "kSrR"                         /* artists only */
    case iTunesESrAComposers = "kSrC"                       /* composers only */
    case iTunesESrADisplayed = "kSrV"                       /* visible text fields */
    case iTunesESrASongs = "kSrS"                           /* song names only */
}

enum iTunesESpK: String {
    case iTunesESpKNone = "kNon"
    case iTunesESpKBooks = "kSpA"
    case iTunesESpKFolder = "kSpF"
    case iTunesESpKGenius = "kSpG"
    case iTunesESpKITunesU = "kSpU"
    case iTunesESpKLibrary = "kSpL"
    case iTunesESpKMovies = "kSpI"
    case iTunesESpKMusic = "kSpZ"
    case iTunesESpKPodcasts = "kSpP"
    case iTunesESpKPurchasedMusic = "kSpM"
    case iTunesESpKTVShows = "kSpT"
}

enum iTunesEVdK: String {
    case iTunesEVdKNone = "kNon"                            /* not a video or unknown video kind */
    case iTunesEVdKHomeVideo = "kVdH"                       /* home video track */
    case iTunesEVdKMovie = "kVdM"                           /* movie track */
    case iTunesEVdKMusicVideo = "kVdV"                      /* music video track */
    case iTunesEVdKTVShow = "kVdT"                          /* TV show track */
}

enum iTunesERtK: String {
    case iTunesERtKUser = "kRtU"                            /* user-specified rating */
    case iTunesERtKComputed = "kRtC"                        /* iTunes-computed rating */
}

enum iTunesEAPD: String {
    case iTunesEAPDComputer = "kAPC"
    case iTunesEAPDAirPortExpress = "kAPX"
    case iTunesEAPDAppleTV = "kAPT"
    case iTunesEAPDAirPlayDevice = "kAPO"
    case iTunesEAPDUnknown = "kAPU"
}

// All the iTunes scripting protocols

/* Standard Suite */
@objc protocol iTunesPrintSettings {
    optional var copies: Int { get }                        // the number of copies of a document to be printed (ro)
    optional var collating: Bool { get }                    // Should printed copies be collated? (ro)
    optional var startingPage: Int { get }                  // the first page of the document to be printed (ro)
    optional var endingPage: Int { get }                    // the last page of the document to be printed (ro)
    optional var pagesAcross: Int { get }                   // number of logical pages laid across a physical page (ro)
    optional var pagesDown: Int { get }                     // number of logical pages laid out down a physical page (ro)
    optional var requestedPrintTime: NSDate? { get }        // the time at which the desktop printer should print the document (ro)
    optional var printerFeatures: NSArray? { get }          // printer specific options (ro)
    optional var faxNumber: String? { get }                 // for fax number (ro)
    optional var targetPrinter: String? { get }             // for target printer (ro)
    /*
@property (readonly) iTunesEnum errorHandling;  // how errors are handled
    */
    optional func close()                                   // Close an object
    optional func delete()                                  // Delete an element from an object
    optional func duplicateTo(SBObject) -> SBObject         // Duplicate one or more object(s)
    optional func exists() -> Bool                          // Verify if an object exists
    optional func open()                                    // open the specified object(s)
    optional func playOnce(Bool)                            // play the current track or the specified track or file.
    /*
- (void) printPrintDialog:(BOOL)printDialog withProperties:(iTunesPrintSettings *)withProperties kind:(iTunesEKnd)kind theme:(NSString *)theme;  // Print the specified object(s)
    */
}

/* iTunes Suite */
// an item
@objc protocol iTunesItem {
    optional var container: SBObject? { get }               // the container of the item (ro)
    optional var id: Int { get }                            // the id of the item
    optional var index: Int { get }                         // The index of the item in internal application order. (ro)
    optional var name: String? { get }                      // the name of the item
    optional func setName(String)                           //
    optional var persistentID: String? { get }              // the id of the item as a hexadecimal string. This id does not change over time. (ro)
    /*
- (void) printPrintDialog:(BOOL)printDialog withProperties:(iTunesPrintSettings *)withProperties kind:(iTunesEKnd)kind theme:(NSString *)theme;  // Print the specified object(s)
    */
    optional func close()                                   // Close an object
    optional func delete()                                  // Delete an element from an object
    optional func duplicateTo(SBObject) -> SBObject         // Duplicate one or more object(s)
    optional func exists() -> Bool                          // Verify if an object exists
    optional func open()                                    // open the specified object(s)
    optional func playOnce(Bool)                            // play the current track or the specified track or file.
    optional func reveal()                                  // reveal and select a track or playlist
}

// an AirPlay device
@objc protocol iTunesAirPlayDevice : iTunesItem {
    optional var active: Bool { get }                       // is the device currently being played to? (ro)
    optional var available: Bool { get }                    // is the device currently available? (ro)
    optional var kind: String? { get }                      // the kind of the device (iTunesEAPD) (ro)
    optional var networkAddress: String? { get }            // the network (MAC) address of the device (ro)
    optional var protected: Bool { get }                    // is the device password- or passcode-protected?
    optional var selected: Bool { get }                     // is the device currently selected?
    optional func setSelected(Bool)                         //
    optional var supportsAudio: Bool { get }                // does the device support audio playback? (ro)
    optional var supportsVideo: Bool { get }                // does the device support video playback? (ro)
    optional var soundVolume: Int { get }                   // the output volume for the device (0 = minimum, 100 = maximum)
    optional func setSoundVolume(Int)                       //
}

// a piece of art within a track
@objc protocol iTunesArtwork : iTunesItem {
    optional var data: NSImage? { get }                     // data for this artwork, in the form of a picture
    optional func setData(NSImage)                          //
    optional var objectDescription: String? { get }         // description of artwork as a string
    optional func setObjectDescription(String)              //
    optional var downloaded: Bool { get }                   // was this artwork downloaded by iTunes? (ro)
    optional var kind: Int { get }                          // kind or purpose of this piece of artwork
    optional func setKind(Int)                              //
    optional var rawData: NSData? { get }                   // data for this artwork, in original format
    optional func setRawData(NSData)                        //
}

// converts a track to a specific file format
@objc protocol iTunesEncoder : iTunesItem {
    optional var format: String? { get }                    // the data format created by the encoder (ro)
}

// equalizer preset configuration
@objc protocol iTunesEQPreset : iTunesItem {
    optional var band1: Double { get }                      // the equalizer 32 Hz band level (-12.0 dB to +12.0 dB)
    optional func setBand1(Double)                          //
    optional var band2: Double { get }                      // the equalizer 64 Hz band level (-12.0 dB to +12.0 dB)
    optional func setBand2(Double)                          //
    optional var band3: Double { get }                      // the equalizer 125 Hz band level (-12.0 dB to +12.0 dB)
    optional func setBand3(Double)                          //
    optional var band4: Double { get }                      // the equalizer 250 Hz band level (-12.0 dB to +12.0 dB)
    optional func setBand4(Double)                          //
    optional var band5: Double { get }                      // the equalizer 500 Hz band level (-12.0 dB to +12.0 dB)
    optional func setBand5(Double)                          //
    optional var band6: Double { get }                      // the equalizer 1 kHz band level (-12.0 dB to +12.0 dB)
    optional func setBand6(Double)                          //
    optional var band7: Double { get }                      // the equalizer 2 kHz band level (-12.0 dB to +12.0 dB)
    optional func setBand7(Double)                          //
    optional var band8: Double { get }                      // the equalizer 4 kHz band level (-12.0 dB to +12.0 dB)
    optional func setBand8(Double)                          //
    optional var band9: Double { get }                      // the equalizer 8 kHz band level (-12.0 dB to +12.0 dB)
    optional func setBand9(Double)                          //
    optional var band10: Double { get }                     // the equalizer 16 kHz band level (-12.0 dB to +12.0 dB)
    optional func setBand10(Double)                         //
    optional var modifiable: Bool { get }                   // can this preset be modified?
    optional var preamp: Double { get }                     // the equalizer preamp level (-12.0 dB to +12.0 dB)
    optional func setPreamp(Double)                         //
    optional var updateTracks: Bool { get }                 // should tracks which refer to this preset be updated when the preset is renamed or deleted?
    optional func setUpdateTracks(Bool)                     //
}

// a list of songs/streams
@objc protocol iTunesPlaylist: iTunesItem {
    optional var tracks: SBElementArray? { get }            //
    optional var duration: Int { get }                      // the total length of all songs (in seconds) (ro)
    optional var name: String? { get }                      // the name of the playlist
    optional func setName(String)                           //
    optional var parent: iTunesPlaylist? { get }            // folder which contains this playlist (if any) (ro)
    optional var shuffle: Bool { get }                      // play the songs in this playlist in random order?
    optional func setShuffle(Bool)                          //
    optional var size: Int { get }                          // the total size of all songs (in bytes) (ro)
    optional var songRepeat: String? { get }                // playback repeat mode (iTunesERpt)
    optional func setSongRepeat(String)                     //
    optional var specialKind: String? { get }               // special playlist kind (iTunesESpK) (ro)
    optional var time: String? { get }                      // the length of all songs in MM:SS format (ro)
    optional var visible: Bool { get }                      // is this playlist visible in the Source list? (ro)
    optional func moveTo(SBObject)                          // Move playlist(s) to a new location
    optional func searchFor(String, only: String)           // search a playlist for tracks matching the search string. Identical to entering search text in the Search field in iTunes.
}

// The application program
@objc protocol iTunesApplication {
    optional func AirPlayDevices() -> SBElementArray
    optional func browserWindows() -> SBElementArray
    optional func encoders() -> SBElementArray
    optional func EQPresets() -> SBElementArray
    optional func EQWindows() -> SBElementArray
    optional func playlistWindows() -> SBElementArray
    optional func sources() -> SBElementArray
    optional func visuals() -> SBElementArray
    optional func windows() -> SBElementArray
    optional var AirPlayEnabled: Bool { get }               // is AirPlay currently enabled? (ro)
    optional var converting: Bool { get }                   // is a track currently being converted? (ro)
    optional var currentAirPlayDevices: NSArray? { get }    // the currently selected AirPlay device(s)
    //optional func setCurrentAirPlayDevices()              // TODO: setCurrentAirPlayDevices
    optional var currentStreamTitle: String? { get }        // the name of the current song in the playing stream (provided by streaming server) (ro)
    optional var currentStreamURL: String? { get }          // the URL of the playing stream or streaming web site (provided by streaming server) (ro)
    optional var EQEnabled: Bool { get }                    // is the equalizer enabled?
    optional func setEQEnabled(Bool)                        //
    optional var fixedIndexing: Bool { get }                // true if all AppleScript track indices should be independent of the play order of the owning playlist.
    optional func setFixedIndexing(Bool)                    //
    optional var frontmost: Bool { get }                    // is iTunes the frontmost application?
    optional func setFrontmost(Bool)                        //
    optional var fullScreen: Bool { get }                   // are visuals displayed using the entire screen?
    optional func setFullScreen(Bool)                       //
    optional var name: String? { get }                      // the name of the application (ro)
    optional var mute: Bool { get }                         // has the sound output been muted?
    optional func setMute(Bool)                             //
    optional var playerPosition: Double { get }             // the player’s position within the currently playing track in seconds.
    optional func setPlayerPosition(Double)                 //
    optional var selection: SBObject? { get }               // the selection visible to the user
    optional var soundVolume: Int { get }                   // the sound output volume (0 = minimum, 100 = maximum)
    optional func setSoundVolume(Int)                       //
    optional var version: String? { get }                   // the version of iTunes (ro)
    optional var visualsEnabled: Bool { get }               // are visuals currently being displayed?
    optional func setVisualsEnabled(Bool)                   //
    optional var iAdIdentifier: String? { get }             // the iAd identifier
/*
@property (copy) iTunesEncoder *currentEncoder;  // the currently selected encoder (MP3, AIFF, WAV, etc.)
@property (copy) iTunesEQPreset *currentEQPreset;  // the currently selected equalizer preset
@property (copy, readonly) iTunesPlaylist *currentPlaylist;  // the playlist containing the currently targeted track
@property (copy, readonly) iTunesTrack *currentTrack;  // the current targeted track
@property (copy) iTunesVisual *currentVisual;  //  the currently selected visual plug-in
@property (readonly) iTunesEPlS playerState;  // is iTunes stopped, paused, or playing?
@property iTunesEVSz visualSize;  // the size of the displayed visual
*/
    optional func run()                                     // run iTunes
    optional func quit()                                    // quit iTunes
    optional func backTrack()                               // reposition to beginning of current track or go to previous track if already at start of current track
    optional func fastForward()                             // skip forward in a playing track
    optional func nextTrack()                               // advance to the next track in the current playlist
    optional func pause()                                   // pause playback
    optional func playOnce(Bool)                            // play the current track or the specified track or file.
    optional func playpause()                               // toggle the playing/paused state of the current track
    optional func previousTrack()                           // return to the previous track in the current playlist
    optional func resume()                                  // disable fast forward/rewind and resume playback, if playing.
    optional func rewind()                                  // skip backwards in a playing track
    optional func stop()                                    // stop playback
    optional func update()                                  // update the specified iPod
    optional func eject()                                   // eject the specified iPod
    optional func subscribe(String)                         // subscribe to a podcast feed
    optional func updateAllPodcasts()                       // update all subscribed podcast feeds
    optional func updatePodcast()                           // update podcast feed
    optional func openLocation(String)                      // Opens a Music Store or audio stream URL
    /*
- (void) printPrintDialog:(BOOL)printDialog withProperties:(iTunesPrintSettings *)withProperties kind:(iTunesEKnd)kind theme:(NSString *)theme;  // Print the specified object(s)
- (iTunesTrack *) add:(NSArray *)x to:(SBObject *)to;  // add one or more files to a playlist
- (iTunesTrack *) convert:(NSArray *)x;  // convert one or more files or tracks
    */
}

class iTunes {
    
    
}