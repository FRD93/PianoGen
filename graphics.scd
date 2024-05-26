(





~win = Window.new("Musica Generativa V1"); // .front;
~openPreset = Button.new.states_([["Apri Preset", Color.black, Color.gray]]).action_({
	Dialog.openPanel({ | presetPath |
		~win.layout_();
		~readPreset.value(presetPath);
	}, path: "/Users/francescodani/Documents/SuperCollider/MusicaGenerativa/MusicGenerator_V2/presets");
});

~selectScale = PopUpMenu.new.items_([]).action_({ | val |
	~preset.put("Scale", val.item);
	("Nuova scala selezionata:" + ~preset["Scale"]).postln;
});

~selectTone = NumberBox.new.action_({ | val |
	~preset.put("Tone", val.value);
}).value_(0);

~writeMIDIFile = CheckBox.new.string_("Write MIDI  File").action_({ | val |
	~data["WriteMIDIFile"] = val.value;
}).value_(false);

~distance = Slider.new.action_({ | val | ~data["Distance"] = val.value }).valueAction_(~data["Distance"]);
~mean = Slider.new.action_({ | val | ~data["Mean"] = val.value }).valueAction_(~data["Mean"]);
~absDerivativeMean = Slider.new.action_({ | val | ~data["AbsDerivativeMean"] = val.value }).valueAction_(~data["AbsDerivativeMean"]);

~play = Button.new.states_([["Stop", Color.black, Color.red(0.7)], ["Playing", Color.black, Color.green(0.7)]]).action_({ | val |
	if(val.value == 1, {
		if(~data["WriteMIDIFile"], {
			m = SimpleMIDIFile( ~midiFilesPath ++ 1000.rand ++ ".mid");
			m.init1( 3, 60 * 2 / ~preset["Tempo"], "4/4" );
			m.timeMode = \seconds;
		});
		~playRoutine = ~generatePlayRoutine.value();
		~playRoutine.play(~data["Clock"]);
		"Playing...".postln;
	}, {
		if(~data["WriteMIDIFile"], {
			m.adjustEndOfTrack;
			m.write;
		});
		~playRoutine.stop;
		"Stop.".postln;
	});
});

~instrumentView = View.new;

~win.layout_(
	HLayout(
		VLayout(
			// Apri preset,
			HLayout(
				~openPreset, ~play, ~writeMIDIFile
			),
			// Preset stuff
			HLayout(
				StaticText.new.string_("Scale:"),
				~selectScale
			),
			HLayout(
				StaticText.new.string_("Base tone:"),
				~selectTone
			),
			~instrumentView,
			StaticText.new.string_("©2022 Francesco Roberto Dani")
		),
		HLayout(
			VLayout(
				StaticText.new.string_("Distance"),
				~distance
			),
			VLayout(
				StaticText.new.string_("Mean"),
				~mean
			),
			VLayout(
				StaticText.new.string_("AbsDerivativeMean"),
				~absDerivativeMean
			),
		),
	)
);
)