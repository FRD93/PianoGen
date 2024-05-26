// Mac M1 Paths
/*
(
Routine{
	~sampleLibPath = "/Volumes/Backup Dani/Campioni/Instruments/GrandPiano2Full/";
	~midiFilesPath = "/Users/francescodani/Documents/SuperCollider/MusicaGenerativa/MusicGenerator_V2/MIDIFiles/";
	File("".resolveRelative ++ "synthdefs.scd", "r").readAllString.interpret;
	File("".resolveRelative ++ "dsp.scd", "r").readAllString.interpret;
	File("".resolveRelative ++ "functions.scd", "r").readAllString.interpret;
	File("".resolveRelative ++ "graphics.scd", "r").readAllString.interpret;
	"A".postln;
	~readPreset.value("".resolveRelative ++ "presets/template2.scd");
	~data.put("PlayVelocitySampler", True);
	"B".postln;
	~playRoutine = ~generatePlayRoutine.value();
	"C".postln;
	0.1.wait;
	s.volume_(-9);
	~playRoutine.play(~data["Clock"]);
	"OK: Running...".postln;
}.play(AppClock);
)
*/

// ProLiant Ubuntu Server Paths
// File("/home/francesco/Documents/SuperCollider/MusicGenerator_V2/init_headless.scd", "r").readAllString.interpret;
(
Routine{
	~sampleLibPath = "/home/francesco/Documents/Samples/GrandPiano2Full/";
	~midiFilesPath = "/home/francesco/Documents/SuperCollider/MusicGenerator_V2/MIDIFiles/";
	File("".resolveRelative ++ "synthdefs.scd", "r").readAllString.interpret;
	File("".resolveRelative ++ "dsp.scd", "r").readAllString.interpret;
	File("".resolveRelative ++ "functions.scd", "r").readAllString.interpret;
	File("".resolveRelative ++ "graphics.scd", "r").readAllString.interpret;
	"A".postln;
	~readPreset.value("".resolveRelative ++ "presets/template2.scd");
	~data.put("PlayVelocitySampler", True);
	"B".postln;
	~playRoutine = ~generatePlayRoutine.value();
	"C".postln;
	0.1.wait;
	s.volume_(-9);
	~playRoutine.play(~data["Clock"]);
	"OK: Running...".postln;
}.play(AppClock);
)
















