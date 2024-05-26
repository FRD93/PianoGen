(
~sampleLibPathNoVelocity = "/Users/francescodani/Documents/SuperCollider/MusicaGenerativa/MusicGenerator_V1/samples/";
~sampleLibPath = "/Volumes/Backup Dani/Campioni/Instruments/GrandPiano2Full/";
// ~sampleLibPathNoVelocity = "/Volumes/Backup Dani/Campioni/Instruments/NordElectro3/";
~midiFilesPath = "/Users/francescodani/Documents/SuperCollider/MusicaGenerativa/MusicGenerator_V2/MIDIFiles/";
File("".resolveRelative ++ "synthdefs.scd", "r").readAllString.interpret;
File("".resolveRelative ++ "dsp.scd", "r").readAllString.interpret;
File("".resolveRelative ++ "functions.scd", "r").readAllString.interpret;
File("".resolveRelative ++ "graphics.scd", "r").readAllString.interpret;
//c = FRDConvolutionPlugIn.new(inCh: 20, outCh: 0, inGain: 0, outGain: 0, convName: "Large Long Echo Hall.wav");
~data.put("PlayVelocitySampler", True);
)
s.record
s.stopRecording
s.scope

~notes = ~readScaleChordsMIDIFile.value("/Users/francescodani/Documents/SuperCollider/MusicaGenerativa/MusicGenerator_V2/data/ScaleChords/Major2th4th.MID");
~notes = ~readScaleChordsMIDIFile.value("/Users/francescodani/Documents/SuperCollider/MusicaGenerativa/MusicGenerator_V2/data/ScaleChords/Major4th.MID");
~notes = ~readScaleChordsMIDIFile.value("/Users/francescodani/Documents/SuperCollider/MusicaGenerativa/MusicGenerator_V2/data/ScaleChords/Major.MID");

Scale.directory
Scale.todi.degrees
Buffer.duration

PathName(~sampleLibPath).keys

~chordMarkovChain = FRDMarkovChain.new(~preset["Chords"], ~preset["ChordTransitionMatrix"], "0");
~chordMarkovChain.next();
~data["PlayVelocitySampler"]
~dsp["BodyGranulatorBuffer"].plot
(
r = Routine{
	var fa, fb, fc;
	fa = {
		~dsp["BassBufferGranulator"].patternDuration_(12);
		~dsp["BassBufferGranulator"].amp_(0.0046875);
		~dsp["BassBufferGranulator"].rate_([0.5, 2, 4, 6].choose);
		~dsp["BassBufferGranulator"].outCh_(~dsp["BassBufferGranulatorOutCh"]);
		~dsp["BassBufferGranulator"].playPattern("tappeto");
	};
	fb = {
		~dsp["BodyBufferGranulator"].patternDuration_(8);
		~dsp["BodyBufferGranulator"].amp_(0.15);
		~dsp["BodyBufferGranulator"].rate_([0.5, 1, 2].choose);
		~dsp["BodyBufferGranulator"].outCh_(~dsp["BodyBufferGranulatorOutCh"]);
		~dsp["BodyBufferGranulator"].playPattern("tappeto");
	};
	fc = {
		~dsp["MelodyBufferGranulator"].patternDuration_(12);
		~dsp["MelodyBufferGranulator"].amp_(0.0375);
		~dsp["MelodyBufferGranulator"].rate_([1, 1.5, 2].choose);
		~dsp["MelodyBufferGranulator"].outCh_(~dsp["MelodyBufferGranulatorOutCh"]);
		~dsp["MelodyBufferGranulator"].playPattern("tappeto");
	};
	loop{
		[fa, fb, fc].choose.value;
		[0.25, 0.5, 1, 2, 4].choose.wait;
	}
};
)
r.reset.play(~data["Clock"]);
r.stop;


~data.put("NormalReverseChoice", [1, 0]);
~data.put("NormalReverseChoice", [0.75, 0.25]);
~data.put("NormalReverseChoice", [0.5, 0.5]);
~data.put("NormalReverseChoice", [0.25, 0.75]);
~data.put("NormalReverseChoice", [0, 1]);

(
t = Routine{
	1024.do({ | id |
		~dsp["MelodyBusGranulator"].maxRate_(id * 0.25 / 1024);
		(8 / 1024).wait;
	});
	1024.do({ | id |
		~dsp["BassBusGranulator"].maxRate_(id * 0.5 / 1024);
		~dsp["BodyBusGranulator"].maxRate_(id * 0.5 / 1024);
		~dsp["MelodyBusGranulator"].maxRate_((id * 0.25 / 1024) + 0.25);
		(16 / 1024).wait;
	});
};
)
t.reset.play(~data["Clock"]);
t.stop;


0.0375 / 8
0.01875





(
~dsp["BassSideChain"].set(\follower, 0.89);
~dsp["BodySideChain"].set(\follower, 1);
~dsp["MelodySideChain"].set(\follower, 1);
)
(
~dsp["BassSideChain"].set(\follower, 0.85);
~dsp["BodySideChain"].set(\follower, 0.85);
~dsp["MelodySideChain"].set(\follower, 0.85);
)
(
~dsp["BassSideChain"].set(\follower, 0);
~dsp["BodySideChain"].set(\follower, 0);
~dsp["MelodySideChain"].set(\follower, 0);
)



(
u = Routine{
	loop{
		var gran = ["BassBufferGranulator", "BodyBufferGranulator", "MelodyBufferGranulator"].choose;
~dsp[gran].patternDuration_(2);
~dsp[gran].amp_(1);
~dsp[gran].rate_(rrand(1, 1).round(1));
~dsp[gran].outCh_(~dsp["OutputReverbInCh"]);
~dsp[gran].playPattern("corto_senza_attacco");
		[0.5, 1, 2].choose.wait;
	}
}
)
u.reset.play(~data["Clock"]);
u.stop;

(
~dsp["BodyBufferGranulator"].patternDuration_(0.075);
~dsp["BodyBufferGranulator"].amp_(3);
~dsp["BodyBufferGranulator"].rate_(0.75);
~dsp["BodyBufferGranulator"].outCh_(~dsp["OutputReverbInCh"]);
~dsp["BodyBufferGranulator"].playPattern("corto_senza_attacco");
)


(
3.do({
	~dsp["BassBufferGranulator"].patternDuration_(0.1);
	~dsp["BassBufferGranulator"].amp_(0.1375);
	~dsp["BassBufferGranulator"].rate_([2, 4, 6, 8].choose);
	~dsp["BassBufferGranulator"].outCh_(~dsp["BassBufferGranulatorOutCh"]);
	~dsp["BassBufferGranulator"].playPattern("tappeto");
});
)
(
~dsp["BodyBufferGranulator"].patternDuration_(4);
~dsp["BodyBufferGranulator"].amp_(0.5);
~dsp["BodyBufferGranulator"].rate_(2);
~dsp["BodyBufferGranulator"].outCh_(~dsp["BodyBufferGranulatorOutCh"]);
~dsp["BodyBufferGranulator"].playPattern("tappeto");
)
(
~dsp["MelodyBufferGranulator"].patternDuration_(4);
~dsp["MelodyBufferGranulator"].amp_(0.25);
~dsp["MelodyBufferGranulator"].rate_(2);
~dsp["MelodyBufferGranulator"].outCh_(~dsp["MelodyBufferGranulatorOutCh"]);
~dsp["MelodyBufferGranulator"].playPattern("tappeto");
)

(
~dsp["BodyBufferGranulator"].patternDuration_(4);
~dsp["BodyBufferGranulator"].amp_(0.25);
~dsp["BodyBufferGranulator"].rate_(3);
~dsp["BodyBufferGranulator"].outCh_(~dsp["BodyBufferGranulatorOutCh"]);
~dsp["BodyBufferGranulator"].playPattern("staccato_crescendo");
)

(
~dsp["BassBusGranulator"].maxDel_(0.0001);
~dsp["BodyBusGranulator"].maxDel_(0.0001);
~dsp["MelodyBusGranulator"].maxDel_(0.0001);
)

(
~dsp["BassBusGranulator"].maxDel_(0.0003);
~dsp["BodyBusGranulator"].maxDel_(0.0003);
~dsp["MelodyBusGranulator"].maxDel_(0.0003);
)

(
~dsp["BassBusGranulator"].maxDel_(0.005);
~dsp["BodyBusGranulator"].maxDel_(0.005);
~dsp["MelodyBusGranulator"].maxDel_(0.005);
~dsp["BassBusGranulator"].maxRate_(0.005);
~dsp["BodyBusGranulator"].maxRate_(0.005);
~dsp["MelodyBusGranulator"].maxRate_(0.005);
)
(
~dsp["BassBusGranulator"].maxDel_(0.005);
~dsp["BodyBusGranulator"].maxDel_(0.005);
~dsp["MelodyBusGranulator"].maxDel_(0.005);
~dsp["BassBusGranulator"].maxRate_(3);
~dsp["BodyBusGranulator"].maxRate_(3);
~dsp["MelodyBusGranulator"].maxRate_(3);
)
(
~dsp["BassBusGranulator"].maxRate_(0.05);
~dsp["BodyBusGranulator"].maxRate_(0.05);
~dsp["MelodyBusGranulator"].maxRate_(0.05);
)
(
~dsp["BassBusGranulator"].maxRate_(0.15);
~dsp["BodyBusGranulator"].maxRate_(0.25);
~dsp["MelodyBusGranulator"].maxRate_(0.5);
)
(
~dsp["BassBusGranulator"].maxRate_(1);
~dsp["BodyBusGranulator"].maxRate_(1);
~dsp["MelodyBusGranulator"].maxRate_(1);
)
(
~dsp["BassBusGranulator"].maxRate_(3);
~dsp["BodyBusGranulator"].maxRate_(3);
~dsp["MelodyBusGranulator"].maxRate_(3);
)
(
~dsp["BassBusGranulator"].maxDel_(0.5);
~dsp["BodyBusGranulator"].maxDel_(1.0);
~dsp["MelodyBusGranulator"].maxDel_(1.0);
~dsp["BassBusGranulator"].maxRate_(3);
~dsp["BodyBusGranulator"].maxRate_(3);
~dsp["MelodyBusGranulator"].maxRate_(3);
)
(
~dsp["BassBusGranulator"].maxDel_(0.5);
~dsp["BodyBusGranulator"].maxDel_(1.0);
~dsp["MelodyBusGranulator"].maxDel_(1.0);
~dsp["MelodyBusGranulator"].amp_(0.0);
~dsp["BassBusGranulator"].maxRate_(0.005);
~dsp["BodyBusGranulator"].maxRate_(0.005);
~dsp["MelodyBusGranulator"].maxRate_(0.005);
)

[0.25, 0.5]
(
~dsp["BassBusGranulator"].minGDur_(0.01);
~dsp["BassBusGranulator"].maxGDur_(0.1);
~dsp["BodyBusGranulator"].minGDur_(0.01);
~dsp["BodyBusGranulator"].maxGDur_(0.1);
~dsp["MelodyBusGranulator"].minGDur_(0.01);
~dsp["MelodyBusGranulator"].maxGDur_(0.1);
)
(
~dsp["BassBusGranulator"].minGDur_(0.05);
~dsp["BassBusGranulator"].maxGDur_(0.5);
~dsp["BodyBusGranulator"].minGDur_(0.05);
~dsp["BodyBusGranulator"].maxGDur_(0.5);
~dsp["MelodyBusGranulator"].minGDur_(0.05);
~dsp["MelodyBusGranulator"].maxGDur_((0.5));
)

