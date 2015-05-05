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

// iTunes version where we picked up the definitions
let iTunesScriptVersion = "12.1.2.27"

// The iTunes bundle identifier
let iTunesBundleIdentifier = "com.apple.iTunes"

// Enums of 4cc types

enum iTunesEKnd: DescType {
    case iTunesEKndTrackListing =   0x6B54726B  // kTrk     /* a basic listing of tracks within a playlist */
    case iTunesEKndAlbumListing =   0x6B416C62  // kAlb     /* a listing of a playlist grouped by album */
    case iTunesEKndCdInsert =       0x6B434469  // kCDi     /* a printout of the playlist for jewel case inserts */
}

enum iTunesEnum: DescType {
    case iTunesEnumStandard =       0x6C777374  // lwst     /* Standard PostScript error handling */
    case iTunesEnumDetailed =       0x6C776474  // lwdt     /* print a detailed report of PostScript errors */
}

enum iTunesEPlS: DescType {
    case iTunesEPlSStopped =        0x6B505353  // kPSS
    case iTunesEPlSPlaying =        0x6B505350  // kPSP
    case iTunesEPlSPaused =         0x6B505370  // kPSp
    case iTunesEPlSFastForwarding = 0x6B505346  // kPSF
    case iTunesEPlSRewinding =      0x6B505352  // kPSR
}

enum iTunesERpt: DescType {
    case iTunesERptOff =            0x6B527030  // kRpO
    case iTunesERptOne =            0x6B527031  // kRp1
    case iTunesERptAll =            0x6B416C6C  // kAll
}

enum iTunesEVSz: DescType {
    case iTunesEVSzSmall =          0x6B565353  // kVSS
    case iTunesEVSzMedium =         0x6B56534D  // kVSM
    case iTunesEVSzLarge =          0x6B56534C  // kVSL
}

enum iTunesESrc: DescType {
    case iTunesESrcLibrary =        0x6B4C6962  // kLib
    case iTunesESrcIPod =           0x6B506F64  // kPod
    case iTunesESrcAudioCD =        0x6B414344  // kACD
    case iTunesESrcMP3CD =          0x6B4D4344  // kMCD
    case iTunesESrcRadioTuner =     0x6B54756E  // kTun
    case iTunesESrcSharedLibrary =  0x6B536864  // kShd
    case iTunesESrcUnknown =        0x6B556E6B  // kUnk
}

enum iTunesESrA: DescType {
    case iTunesESrAAlbums =         0x6B53724C  // kSrL     /* albums only */
    case iTunesESrAAll =            0x6B416C6C  // kAll     /* all text fields */
    case iTunesESrAArtists =        0x6B537252  // kSrR     /* artists only */
    case iTunesESrAComposers =      0x6B537243  // kSrC     /* composers only */
    case iTunesESrADisplayed =      0x6B537256  // kSrV     /* visible text fields */
    case iTunesESrASongs =          0x6B537253  // kSrS     /* song names only */
}

enum iTunesESpK: DescType {
    case iTunesESpKNone =           0x6B4E6F6E  // kNon
    case iTunesESpKBooks =          0x6B537041  // kSpA
    case iTunesESpKFolder =         0x6B537046  // kSpF
    case iTunesESpKGenius =         0x6B537047  // kSpG
    case iTunesESpKITunesU =        0x6B537055  // kSpU
    case iTunesESpKLibrary =        0x6B53704C  // kSpL
    case iTunesESpKMovies =         0x6B537049  // kSpI
    case iTunesESpKMusic =          0x6B53705A  // kSpZ
    case iTunesESpKPodcasts =       0x6B537050  // kSpP
    case iTunesESpKPurchasedMusic = 0x6B53704D  // kSpM
    case iTunesESpKTVShows =        0x6B537054  // kSpT
}

enum iTunesEVdK: DescType {
    case iTunesEVdKNone =           0x6B4E6F6E  // kNon     /* not a video or unknown video kind */
    case iTunesEVdKHomeVideo =      0x6B566448  // kVdH     /* home video track */
    case iTunesEVdKMovie =          0x6B56644D  // kVdM     /* movie track */
    case iTunesEVdKMusicVideo =     0x6B566456  // kVdV     /* music video track */
    case iTunesEVdKTVShow =         0x6B566454  // kVdT     /* TV show track */
}

enum iTunesERtK: DescType {
    case iTunesERtKUser =           0x6B527455  // kRtU     /* user-specified rating */
    case iTunesERtKComputed =       0x6B527443  // kRtC     /* iTunes-computed rating */
}

enum iTunesEAPD: DescType {
    case iTunesEAPDComputer =       0x6B415043  // kAPC
    case iTunesEAPDAirPortExpress = 0x6B415058  // kAPX
    case iTunesEAPDAppleTV =        0x6B415054  // kAPT
    case iTunesEAPDAirPlayDevice =  0x6B41504F  // kAPO
    case iTunesEAPDUnknown =        0x6B415055  // kAPU
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
    optional var errorHandling: DescType { get }            // how errors are handled (iTunesEnum) (ro)
    optional func close()                                   // Close an object
    optional func delete()                                  // Delete an element from an object
    optional func duplicateTo(SBObject) -> SBObject         // Duplicate one or more object(s)
    optional func exists() -> Bool                          // Verify if an object exists
    optional func open()                                    // open the specified object(s)
    optional func playOnce(Bool)                            // play the current track or the specified track or file.
    optional func printPrintDialog(Bool, withProperties: iTunesPrintSettings, kind: DescType, theme: String)  // Print the specified object(s) (kind: (iTunesEKnd))
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
    optional func printPrintDialog(Bool, withProperties: iTunesPrintSettings, kind: DescType, theme: String)  // Print the specified object(s) (kind: (iTunesEKnd))
    optional func close()                                   // Close an object
    optional func delete()                                  // Delete an element from an object
    optional func duplicateTo(SBObject) -> SBObject         // Duplicate one or more object(s)
    optional func exists() -> Bool                          // Verify if an object exists
    optional func open()                                    // open the specified object(s)
    optional func playOnce(Bool)                            // play the current track or the specified track or file.
    optional func reveal()                                  // reveal and select a track or playlist
}

// an AirPlay device
@objc protocol iTunesAirPlayDevice: iTunesItem {
    optional var active: Bool { get }                       // is the device currently being played to? (ro)
    optional var available: Bool { get }                    // is the device currently available? (ro)
    optional var kind: DescType { get }                     // the kind of the device (iTunesEAPD) (ro)
    optional var networkAddress: String? { get }            // the network (MAC) address of the device (ro)
    optional func protected() -> Bool                       // is the device password- or passcode-protected?
    optional var selected: Bool { get }                     // is the device currently selected?
    optional func setSelected(Bool)                         //
    optional var supportsAudio: Bool { get }                // does the device support audio playback? (ro)
    optional var supportsVideo: Bool { get }                // does the device support video playback? (ro)
    optional var soundVolume: Int { get }                   // the output volume for the device (0 = minimum, 100 = maximum)
    optional func setSoundVolume(Int)                       //
}

// a piece of art within a track
@objc protocol iTunesArtwork: iTunesItem {
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
@objc protocol iTunesEncoder: iTunesItem {
    optional var format: String? { get }                    // the data format created by the encoder (ro)
}

// equalizer preset configuration
@objc protocol iTunesEQPreset: iTunesItem {
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
    optional var songRepeat: DescType { get }               // playback repeat mode (iTunesERpt)
    optional func setSongRepeat(DescType)                   //
    optional var specialKind: DescType { get }              // special playlist kind (iTunesESpK) (ro)
    optional var time: String? { get }                      // the length of all songs in MM:SS format (ro)
    optional var visible: Bool { get }                      // is this playlist visible in the Source list? (ro)
    optional func moveTo(SBObject)                          // Move playlist(s) to a new location
    optional func searchFor(String, only: String)           // search a playlist for tracks matching the search string. Identical to entering search text in the Search field in iTunes.
}

// a playlist representing an audio CD
@objc protocol iTunesAudioCDPlaylist: iTunesPlaylist {
    optional var audioCDTracks: SBElementArray? { get }     //
    optional var artist: String? { get }                    // the artist of the CD
    optional func setArtist(String)                         //
    optional var compilation: Bool { get }                  // is this CD a compilation album?
    optional func setCompilation(Bool)                      //
    optional var composer: String? { get }                  // the composer of the CD
    optional func setComposer(String)                       //
    optional var discCount: Int { get }                     // the total number of discs in this CD’s album
    optional func setDiscCount(Int)                         //
    optional var discNumber: Int { get }                    // the index of this CD disc in the source album
    optional func setDiscNumber(Int)                        //
    optional var genre: String? { get }                     // the genre of the CD
    optional func setGenre(String)                          //
    optional var year: Int { get }                          // the year the album was recorded/released
    optional func setYear(Int)                              //
}

// the master music library playlist
@objc protocol iTunesLibraryPlaylist: iTunesPlaylist {
    optional var fileTracks: SBElementArray? { get }        //
    optional var URLTracks: SBElementArray? { get }         //
    optional var sharedTracks: SBElementArray? { get }      //
}

// the radio tuner playlist
@objc protocol iTunesRadioTunerPlaylist: iTunesPlaylist {
    optional var URLTracks: SBElementArray? { get }         //
}

// a music source (music library, CD, device, etc.)
@objc protocol iTunesSource: iTunesItem {
    optional func audioCDPlaylists() -> SBElementArray?     //
    optional func libraryPlaylists() -> SBElementArray?     //
    optional func playlists() -> SBElementArray?            //
    optional func radioTunerPlaylists() -> SBElementArray?  //
    optional func userPlaylists() -> SBElementArray?        //
    optional var capacity: Int64 { get }                    // the total size of the source if it has a fixed size (ro)
    optional var freeSpace: Int64 { get }                   // the free space on the source if it has a fixed size (ro)
    optional var kind: DescType { get }                     // (iTunesESrc) (ro)
    optional func update()                                  // update the specified iPod
    optional func eject()                                   // eject the specified iPod
}

// playable audio source
@objc protocol iTunesTrack: iTunesItem {
    optional func artworks() -> SBElementArray?             //
    optional var album: String? { get }                     // the album name of the track
    optional func setAlbum(String)                          //
    optional var albumArtist: String? { get }               // the album artist of the track
    optional func setAlbumArtist(String)                    //
    optional var albumRating: Int { get }                   // the rating of the album for this track (0 to 100)
    optional func setAlbumRating(Int)                       //
    optional var albumRatingKind: DescType { get }          // the rating kind of the album rating for this track (iTunesERtK)
    optional func setAlbumRatingKind(DescType)              //
    optional var artist: String? { get }                    // the artist/source of the track
    optional func setArtist(String)                         //
    optional var bitRate: Int { get }                       // the bit rate of the track (in kbps) (ro)
    optional var bookmark: Double { get }                   // the bookmark time of the track in seconds
    optional func setBookmark(Double)                       //
    optional var bookmarkable: Bool { get }                 // is the playback position for this track remembered?
    optional func setBookmarkable(Bool)                     //
    optional var bpm: Int { get }                           // the tempo of this track in beats per minute
    optional func setBpm(Int)                               //
    optional var category: String? { get }                  // the category of the track
    optional func setCategory(String)                       //
    optional var comment: String? { get }                   // freeform notes about the track
    optional func setComment(String)                        //
    optional var compilation: Bool { get }                  // is this track from a compilation album?
    optional func setCompilation(Bool)                      //
    optional var composer: String? { get }                  // the composer of the track
    optional func setComposer(String)                       //
    optional var databaseID: Int { get }                    // the common, unique ID for this track. If two tracks in different playlists have the same database ID, they are sharing the same data. (ro)
    optional var dateAdded: NSDate? { get }                 // the date the track was added to the playlist (ro)
    optional var objectDescription: String? { get }         // the description of the track
    optional func setObjectDescription(String)              //
    optional var discCount: Int { get }                     // the total number of discs in the source album
    optional func setDiscCount(Int)                         //
    optional var discNumber: Int { get }                    // the index of the disc containing this track on the source album
    optional func setDiscNumber(Int)                        //
    optional var duration: Double { get }                   // the length of the track in seconds (ro)
    optional var enabled: Bool { get }                      // is this track checked for playback?
    optional func setEnabled(Bool)                          //
    optional var episodeID: String? { get }                 // the episode ID of the track
    optional func setEpisodeID(String)                      //
    optional var episodeNumber: Int { get }                 // the episode number of the track
    optional func setEpisodeNumber(Int)                     //
    optional var EQ: String { get }                         // the name of the EQ preset of the track
    optional func setEQ(String)                             //
    optional var finish: Double { get }                     // the stop time of the track in seconds
    optional func setFinish(Double)                         //
    optional var gapless: Bool { get }                      // is this track from a gapless album?
    optional func setGapless(Bool)                          //
    optional var genre: String? { get }                     // the music/audio genre (category) of the track
    optional func setGenre(String)                          //
    optional var grouping: String? { get }                  // the grouping (piece) of the track. Generally used to denote movements within a classical work.
    optional func setGrouping(String)                       //
    optional var iTunesU: Bool { get }                      // is this track an iTunes U episode? (ro)
    optional var kind: String? { get }                      // a text description of the track (ro)
    optional var longDescription: String? { get }           //
    optional func setLongDescription(String)                //
    optional var lyrics: String? { get }                    // the lyrics of the track
    optional func setLyrics(String)                         //
    optional var modificationDate: NSDate? { get }          // the modification date of the content of this track (ro)
    optional var playedCount: Int { get }                   // number of times this track has been played
    optional func setPlatedCount(Int)                       //
    optional var playedDate: NSDate? { get }                // the date and time this track was last played
    optional func setPlayedDate(NSDate)                     //
    optional var podcast: Bool { get }                      // is this track a podcast episode? (ro)
    optional var rating: Int { get }                        // the rating of this track (0 to 100)
    optional func setRating(Int)                            //
    optional var ratingKind: DescType { get }               // the rating kind of this track (iTunesERtK) (ro)
    optional var releaseDate: NSDate? { get }               // the release date of this track (ro)
    optional var sampleRate: Int { get }                    // the sample rate of the track (in Hz) (ro)
    optional var seasonNumber: Int { get }                  // the season number of the track
    optional func setSeasonNumber(Int)                      //
    optional var shufflable: Bool { get }                   // is this track included when shuffling?
    optional func setShufflable(Bool)                       //
    optional var skippedCount: Int { get }                  // number of times this track has been skipped
    optional func setSkippedCount(Int)                      //
    optional var skippedDate: NSDate? { get }               // the date and time this track was last skipped
    optional func setSkippedDate(NSDate)                    //
    optional var show: String? { get }                      // the show name of the track
    optional func setShow(String)                           //
    optional var sortAlbum: String? { get }                 // override string to use for the track when sorting by album
    optional func setSortAlbum(String)                      //
    optional var sortArtist: String? { get }                // override string to use for the track when sorting by artist
    optional func setSortArtist(String)                     //
    optional var sortAlbumArtist: String? { get }           // override string to use for the track when sorting by album artist
    optional func setSortAlbumArtist(String)                //
    optional var sortName: String? { get }                  // override string to use for the track when sorting by name
    optional func setSortName(String)                       //
    optional var sortComposer: String? { get }              // override string to use for the track when sorting by composer
    optional func setSortComposer(String)                   //
    optional var sortShow: String? { get }                  // override string to use for the track when sorting by show name
    optional func setSortShow(String)                       //
    optional var size: Int64 { get }                        // the size of the track (in bytes) (ro)
    optional var start: Double { get }                      // the start time of the track in seconds
    optional func setStart(Double)                          //
    optional var time: String? { get }                      // the length of the track in MM:SS format (ro)
    optional var trackCount: Int { get }                    // the total number of tracks on the source album
    optional func setTrackCount(Int)                        //
    optional var trackNumber: Int { get }                   // the index of the track on the source album
    optional func setTrackNumber(Int)                       //
    optional var unplayed: Bool { get }                     // is this track unplayed?
    optional func setUnplayed(Bool)                         //
    optional var videoKind: DescType { get }                // kind of video track (iTunesEVdK)
    optional func setVideoKind(DescType)                    //
    optional var volumeAdjustment: Int { get }              // relative volume adjustment of the track (-100% to 100%)
    optional func setVolumeAdjustment(Int)                  //
    optional var year: Int { get }                          // the year the track was recorded/released
    optional func setYear(Int)
}

// a track on an audio CD
@objc protocol iTunesAudioCDTrack: iTunesTrack {
    optional var location: NSURL? { get }                   // the location of the file represented by this track (ro)
}

// a track representing an audio file (MP3, AIFF, etc.)
@objc protocol iTunesFileTrack: iTunesTrack {
    optional var location: NSURL? { get }                   // the location of the file represented by this track
    optional func setLocation(NSURL)                        //
    optional func refresh()                                 // update file track information from the current information in the track’s file
}

// a track residing in a shared library
@objc protocol iTunesSharedTrack: iTunesTrack {
    // TODO: iTunesSharedTrack empty?
}

// a track representing a network stream
@objc protocol iTunesURLTrack: iTunesTrack {
    optional var address: String? { get }                   // the URL for this track
    optional func setAddress(String)                        //
    optional func download()                                // download podcast episode
}

// custom playlists created by the user
@objc protocol iTunesUserPlaylist: iTunesPlaylist {
    optional var fileTracks: SBElementArray? { get }        //
    optional var URLTracks: SBElementArray? { get }         //
    optional var sharedTracks: SBElementArray? { get }      //
    optional var shared: Bool { get }                       // is this playlist shared?
    optional func setShared(Bool)                           //
    optional var smart: Bool { get }                        // is this a Smart Playlist? (ro)
}

// a folder that contains other playlists
@objc protocol iTunesFolderPlaylist: iTunesUserPlaylist {
    // TODO: iTunesFolderPlaylist empty?
}

// a visual plug-in
@objc protocol iTunesVisual: iTunesItem {
    // TODO: iTunesVisual empty?
}

// any window
@objc protocol iTunesWindow: iTunesItem {
    optional var bounds: NSRect { get }                     // the boundary rectangle for the window
    optional func setBounds(NSRect)                         //
    optional var closeable: Bool { get }                    // does the window have a close box? (ro)
    optional var collapseable: Bool { get }                 // does the window have a collapse (windowshade) box? (ro)
    optional var collapsed: Bool { get }                    // is the window collapsed?
    optional func setCollapsed(Bool)                        //
    optional var position: NSPoint { get }                  // the upper left position of the window
    optional func setPosition(NSPoint)                      //
    optional var resizable: Bool { get }                    // is the window resizable? (ro)
    optional var visible: Bool { get }                      // is the window visible?
    optional func setVisible(Bool)                          //
    optional var zoomable: Bool { get }                     // is the window zoomable? (ro)
    optional var zoomed: Bool { get }                       // is the window zoomed?
    optional func setZoomed(Bool)                           //
}

// the main iTunes window
@objc protocol iTunesBrowserWindow: iTunesWindow {
    optional var minimized: Bool { get }                    // is the small player visible?
    optional func setMinimized(Bool)                        //
    optional var selection: SBObject? { get }               // the selected songs (ro)
    optional var view: iTunesPlaylist? { get }              // the playlist currently displayed in the window
    optional func setView(iTunesPlaylist)                   //
}

// the iTunes equalizer window
@objc protocol iTunesEQWindow: iTunesWindow {
    optional var minimized: Bool { get }                    // is the small EQ window visible?
    optional func setMinimized(Bool)                        //
}

// a sub-window showing a single playlist
@objc protocol iTunesPlaylistWindow: iTunesWindow {
    optional var selection: SBObject? { get }               // the selected songs (ro)
    optional var view: iTunesPlaylist? { get }              // the playlist currently displayed in the window (ro)
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
    optional func setCurrentAirPlayDevice(iTunesAirPlayDevice)  // TODO: setCurrentAirPlayDevices
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
    optional var currentEncoder: iTunesEncoder? { get }     // the currently selected encoder (MP3, AIFF, WAV, etc.)
    optional func setCurrentEncoder(iTunesEncoder)          //
    optional var currentEQPreset: iTunesEQPreset? { get }   // the currently selected equalizer preset
    optional func setCurrentEQPreset(iTunesEQPreset)        //
    optional var currentPlaylist: iTunesPlaylist? { get }   // the playlist containing the currently targeted track (ro)
    optional var currentTrack: iTunesTrack? { get }         // the current targeted track (ro)
    optional var currentVisual: iTunesVisual? { get }       //  the currently selected visual plug-in
    optional func setCurrentVisual(iTunesVisual)            //
    optional var playerState: DescType { get }              // is iTunes stopped, paused, or playing? (iTunesEPlS) (ro)
    optional var visualSize: DescType { get }               // the size of the displayed visual (iTunesEVSz)
    optional func setVisualSize(DescType)                   //
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
    optional func add(NSArray, to: SBObject) -> iTunesTrack // add one or more files to a playlist
    optional func convert(NSArray) -> iTunesTrack           // convert one or more files or tracks
    optional func printPrintDialog(Bool, withProperties: iTunesPrintSettings, kind: DescType, theme: String)  // Print the specified object(s) (kind: (iTunesEKnd))
}

extension SBApplication: iTunesApplication {}

extension SBObject: iTunesItem, iTunesAirPlayDevice, iTunesArtwork, iTunesEncoder, iTunesEQPreset, iTunesPlaylist, iTunesAudioCDPlaylist, iTunesLibraryPlaylist, iTunesRadioTunerPlaylist, iTunesSource, iTunesTrack, iTunesAudioCDTrack, iTunesFileTrack, iTunesSharedTrack, iTunesURLTrack, iTunesUserPlaylist, iTunesFolderPlaylist, iTunesVisual, iTunesWindow, iTunesBrowserWindow, iTunesEQWindow, iTunesPlaylistWindow {}

class iTunes {
    
    
}