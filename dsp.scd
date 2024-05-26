(
~dsp = Dictionary.new;
// Mixer Channels
~dsp.put("BassOutCh", 20);
~dsp.put("BodyOutCh", 22);
~dsp.put("MelodyOutCh", 24);
~dsp.put("BassBusGranulatorOutCh", 26);
~dsp.put("BodyBusGranulatorOutCh", 28);
~dsp.put("MelodyBusGranulatorOutCh", 30);
~dsp.put("BassBufferGranulatorOutCh", 32);
~dsp.put("BodyBufferGranulatorOutCh", 34);
~dsp.put("MelodyBufferGranulatorOutCh", 36);
~dsp.put("OutputReverbInCh", 40);
~dsp.put("OutputCh", 0);
// Mixer Groups
~dsp.put("NoteGroup", Group.head(s));
~dsp.put("GranulatorGroup", Group.after(~dsp["NoteGroup"]));
~dsp.put("SideChainGroup", Group.after(~dsp["GranulatorGroup"]));
~dsp.put("ReverbGroup", Group.after(~dsp["SideChainGroup"]));
// Buffers
~dsp.put("BassGranulatorBuffer", Buffer.alloc(s, s.sampleRate * 4, 1));
~dsp.put("BodyGranulatorBuffer", Buffer.alloc(s, s.sampleRate * 4, 1));
~dsp.put("MelodyGranulatorBuffer", Buffer.alloc(s, s.sampleRate * 4, 1));
// Permanent Synths
~dsp.put("BassGranulatorBufferFill", Synth.head(~dsp["GranulatorGroup"], \FillGranulatorBufferLoop, [
	\in, ~dsp["BassOutCh"],
	\gain, 1,
	\prev, 0.15,
	\next, 0.85,
	\buf, ~dsp["BassGranulatorBuffer"]
]));
~dsp.put("BodyGranulatorBufferFill", Synth.head(~dsp["GranulatorGroup"], \FillGranulatorBufferLoop, [
	\in, ~dsp["BodyOutCh"],
	\gain, 1,
	\prev, 0.15,
	\next, 0.85,
	\buf, ~dsp["BodyGranulatorBuffer"]
]));
~dsp.put("MelodyGranulatorBufferFill", Synth.head(~dsp["GranulatorGroup"], \FillGranulatorBufferLoop, [
	\in, ~dsp["MelodyOutCh"],
	\gain, 1,
	\prev, 0.15,
	\next, 0.85,
	\buf, ~dsp["MelodyGranulatorBuffer"]
]));

~dsp.put("BassBusGranulator", FRDContinuousBusGranulator.new(~dsp["BassOutCh"], ~dsp["BassBusGranulatorOutCh"], maxDel: 0.0001, maxRate: 0.0001, amp: 1, addAction: 'addToTail', actionNode: ~dsp["GranulatorGroup"]));
~dsp.put("BodyBusGranulator", FRDContinuousBusGranulator.new(~dsp["BodyOutCh"], ~dsp["BodyBusGranulatorOutCh"], maxDel: 0.0001, maxRate: 0.0001, amp: 1, addAction: 'addToTail', actionNode: ~dsp["GranulatorGroup"]));
~dsp.put("MelodyBusGranulator", FRDContinuousBusGranulator.new(~dsp["MelodyOutCh"], ~dsp["MelodyBusGranulatorOutCh"], maxDel: 0.0001, maxRate: 0.0001, amp: 1, addAction: 'addToTail', actionNode: ~dsp["GranulatorGroup"]));

~dsp.put("BassBufferGranulator", FRDBufferGranulator.new(~dsp["BassGranulatorBuffer"], ~dsp["BassBufferGranulatorOutCh"], addAction: 'addToTail', actionNode: ~dsp["GranulatorGroup"]));
~dsp.put("BodyBufferGranulator", FRDBufferGranulator.new(~dsp["BodyGranulatorBuffer"], ~dsp["BodyBufferGranulatorOutCh"], addAction: 'addToTail', actionNode: ~dsp["GranulatorGroup"]));
~dsp.put("MelodyBufferGranulator", FRDBufferGranulator.new(~dsp["MelodyGranulatorBuffer"], ~dsp["MelodyBufferGranulatorOutCh"], addAction: 'addToTail', actionNode: ~dsp["GranulatorGroup"]));
/*
~dsp.put("BassBufferGranulator", FRDContinuousBufferGranulator.new(~dsp["BassGranulatorBuffer"], ~dsp["OutputReverbInCh"], 0.5, amp: 0, addAction: 'addToTail', actionNode: ~dsp["GranulatorGroup"]));
~dsp.put("BodyBufferGranulator", FRDContinuousBufferGranulator.new(~dsp["BodyGranulatorBuffer"], ~dsp["OutputReverbInCh"], 0.5, amp: 0, addAction: 'addToTail', actionNode: ~dsp["GranulatorGroup"]));
~dsp.put("MelodyBufferGranulator", FRDContinuousBufferGranulator.new(~dsp["MelodyGranulatorBuffer"], ~dsp["OutputReverbInCh"], 0.5, amp: 0, addAction: 'addToTail', actionNode: ~dsp["GranulatorGroup"]));
*/

~dsp.put("BassSideChain", Synth.head(~dsp["SideChainGroup"], \SideChainStereo, [\mainCh, ~dsp["BassBusGranulatorOutCh"], \sideCh, ~dsp["BassBufferGranulatorOutCh"], \out, ~dsp["OutputReverbInCh"]]));
~dsp.put("BodySideChain", Synth.head(~dsp["SideChainGroup"], \SideChainStereo, [\mainCh, ~dsp["BodyBusGranulatorOutCh"], \sideCh, ~dsp["BodyBufferGranulatorOutCh"], \out, ~dsp["OutputReverbInCh"]]));
~dsp.put("MelodySideChain", Synth.head(~dsp["SideChainGroup"], \SideChainStereo, [\mainCh, ~dsp["MelodyBusGranulatorOutCh"], \sideCh, ~dsp["MelodyBufferGranulatorOutCh"], \out, ~dsp["OutputReverbInCh"]]));
~dsp.put("OutputReverb", FRDConvolutionPlugIn.new(
	inCh: ~dsp["OutputReverbInCh"],
	outCh: ~dsp["OutputCh"],
	inGain: 0,
	outGain: 0,
	convName: "Large Long Echo Hall.wav",
	addAction: 'addToTail',
	actionNode: ~dsp["ReverbGroup"]
));
/*
~dsp.put("BassTrueOut", Synth.head(~dsp["ReverbGroup"], \RedirectStereo, [\in, ~dsp["BassOutCh"], \out, ~dsp["OutputReverbInCh"]]));
~dsp.put("BodyTrueOut", Synth.head(~dsp["ReverbGroup"], \RedirectStereo, [\in, ~dsp["BodyOutCh"], \out, ~dsp["OutputReverbInCh"]]));
~dsp.put("MelodyTrueOut", Synth.head(~dsp["ReverbGroup"], \RedirectStereo, [\in, ~dsp["MelodyOutCh"], \out, ~dsp["OutputReverbInCh"]]));
*/
)





//~dsp["BodyGranulatorBuffer"].plot




















