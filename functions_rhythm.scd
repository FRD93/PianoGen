~data = Dictionary.new
.put("PlayVelocitySampler", False)
.put("PlaySampleDelay", 2)
.put("NormalReverseChoice", [1.0, 0.0])
.put("Scales", Dictionary.new
	.put("Major", [0, 2, 4, 5, 7, 9, 11])
	.put("MelodicMinor", [0, 2, 3, 5, 7, 9, 11])
	.put("MelidicMinorDesc", [0, 2, 3, 5, 7, 8, 10])
	.put("HarmonicMinor", [0, 2, 3, 5, 7, 8, 10])
	.put("Whole", [0, 2, 4, 6, 8, 10, 12])
	.put("Mixolydian", [0, 2, 4, 5, 7, 9, 10])
	.put("Whole", [0, 2, 4, 6, 8, 10])
)
.put("Scale", "Major")
.put("WriteMIDIFile", false)
.put("SamplerOutChannel", 22) // 20: Reverb; 0: Dry
.put("Samples", [ "Clav5", "ClavCA", "ClavCb", "ClavdA", "Clavdb", "ElectricPiano1", "ElectricPiano2", "ElectricPiano3", "ElectricPiano4", "GrandPiano1", "GrandPiano2", "GrandPiano3", "Sample10", "Sample11", "Sample14", "Sample16", "Sample20", "Sample21", "Sample22", "Sample23", "Sample24", "Sample25", "UprightPiano", "WurlPiano" ]).
put("Movimenti", Dictionary.new);
~data["Movimenti"].put("2", Dictionary.new);
7.do({ | note1 |
	7.do({ | note2 |
		if(note2 != note1, {
			var mean = (note1 + note2) / 2;
			~data["Movimenti"]["2"].put(note1.asString ++ note2.asString, Dictionary.new
				.put("DistanceFrom", note1)
				.put("DistanceTo", note2)
				.put("Distance", note2 - note1)
				.put("Mean", mean)
				.put("Std", ((note1 - mean).pow(2) + (note2 - mean).pow(2)) / 2)
				.put("AbsDerivativeMean", (note2 - note1).abs / 2)
				.put("DerivativeMean", (note2 - note1) / 2)
				.put("DerivativeMin", note2 - note1)
				.put("DerivativeMax", note2 - note1)
				.put("Andamento", if((note2 - note1) > 0, {1}, {if((note2 - note1) < 0, {-1}, {0})}))
				.put("Notes", [note1, note2])
			);
		});
	});
});
~data["Movimenti"].put("3", Dictionary.new);
7.do({ | note1 |
	7.do({ | note2 |
		7.do({ | note3 |
			if((note2 != note1) && (note3 != note2), {
				var mean = (note1 + note2 + note3) / 3;
				~data["Movimenti"]["3"].put(note1.asString ++ note2.asString ++ note2.asString, Dictionary.new
					.put("DistanceFrom", note1)
					.put("DistanceTo", note3)
					.put("Distance", note3 - note1)
					.put("Mean", mean)
					.put("Std", ((note1 - mean).pow(2) + (note2 - mean).pow(2) + (note3 - mean).pow(2)) / 3)
					.put("AbsDerivativeMean", ((note2 - note1).abs + (note3 - note2).abs) / 3)
					.put("DerivativeMean", ((note2 - note1) + (note3 - note2)) / 3)
					.put("DerivativeMin", [note2 - note1, note3 - note2].minItem)
					.put("DerivativeMax", [note2 - note1, note3 - note2].maxItem)
					.put("Andamento", if(((note2 - note1) > 0) && ((note3 - note2) > 0), {1}, {if(((note2 - note1) < 0) && ((note3 - note2) < 0), {-1}, {0})}))
					.put("Notes", [note1, note2, note3])
				);
			});
		});
	});
});
~data["Movimenti"].put("4", Dictionary.new);
7.do({ | note1 |
	7.do({ | note2 |
		7.do({ | note3 |
			7.do({ | note4 |
				if((note2 != note1) && (note3 != note2) && (note4 != note3), {
					var mean = (note1 + note2 + note3 + note4) / 4;
					~data["Movimenti"]["4"].put(note1.asString ++ note2.asString ++ note3.asString ++ note4.asString, Dictionary.new
						.put("DistanceFrom", note1)
						.put("DistanceTo", note4)
						.put("Distance", note4 - note1)
						.put("Mean", mean)
						.put("Std", ((note1 - mean).pow(2) + (note2 - mean).pow(2) + (note3 - mean).pow(2) + (note4 - mean).pow(2)) / 4)
						.put("AbsDerivativeMean", ((note2 - note1).abs + (note3 - note2).abs + (note4 - note3).abs) / 4)
						.put("DerivativeMean", ((note2 - note1) + (note3 - note2) + (note4 - note3)) / 4)
						.put("DerivativeMin", [note2 - note1, note3 - note2, note4 - note3].minItem)
						.put("DerivativeMax", [note2 - note1, note3 - note2, note4 - note3].maxItem)
						.put("Andamento", if(((note2 - note1) > 0) && ((note3 - note2) > 0) && ((note4 - note3) > 0), {1}, {if(((note2 - note1) < 0) && ((note3 - note2) < 0) && ((note4 - note3) < 0), {-1}, {0})}))
						.put("Notes", [note1, note2, note3, note4])
					);
				});
			});
		});
	});
});

//
~data.put("CelluleRitmoMelodiche", Dictionary.new);
~data["CelluleRitmoMelodiche"].put("NoteHistory", []);
~data["CelluleRitmoMelodiche"].put("ClearNoteHistory", {
	~data["CelluleRitmoMelodiche"].put("NoteHistory", []);
});
~data["CelluleRitmoMelodiche"].put("AddNoteToHistory", { | noteEvent | // noteEvent: [midinote, notedelta, velocity]
	"adding note to history".postln;
	~data["CelluleRitmoMelodiche"]["NoteHistory"] = ~data["CelluleRitmoMelodiche"]["NoteHistory"].add(noteEvent);
	if(~data["CelluleRitmoMelodiche"]["NoteHistory"].size > 100, {~data["CelluleRitmoMelodiche"].put("NoteHistory", ~data["CelluleRitmoMelodiche"]["NoteHistory"].keep(100))});
});
~data["CelluleRitmoMelodiche"].put("Cells", []);
~data["CelluleRitmoMelodiche"].put("FindCells", {
	var original_data = ~data["CelluleRitmoMelodiche"]["NoteHistory"].copy;
	var hist_rotate = original_data.flop[0].copy;
	var hist = hist_rotate.copy;
	var autocorr_matrix, cells_vector;
	var max_item, cells=[], cell_values;

	// Calcola matrice di autocorrelazione del vettore di note
	autocorr_matrix = (hist.size - 1).collect({ | rot_id |
		hist_rotate = hist_rotate.rotate(1);
		hist.size.collect({ | id |
			if(hist[id] == hist_rotate[id], { true }, { false });
		});
	});
	autocorr_matrix.shape.postln;

	// Find contiguous true values
	autocorr_matrix = autocorr_matrix.collect({ | vec, vec_id |
		var new_vec = (vec.size - 1).collect({ | id |
			if((vec[id] == true) && (vec[id + 1] == true), { true }, { false });
		});
		new_vec  = new_vec ++ [false];

	});
	autocorr_matrix.shape.postln;

	// Remove alone trues
	autocorr_matrix = autocorr_matrix.collect({ | vec, vec_id |
		var new_vec = (1..vec.size-2).collect({ | id |
			if((vec[id - 1] == false) && (vec[id] == true) && (vec[id + 1] == false), { false }, { vec[id] });
		});
		new_vec  = [false] ++ new_vec ++ [false];
	});
	autocorr_matrix.shape.postln;

	// Last of contiguous is false, so set it to true
	autocorr_matrix = autocorr_matrix.collect({ | vec, vec_id |
		var new_vec = (1..vec.size-1).collect({ | id |
			if((vec[id] == false) && (vec[id - 1] == true), { true }, { vec[id] });
		});
		new_vec  = [false] ++ new_vec;
	});
	autocorr_matrix.shape.postln;

	try({
		// Convert autocorrelation matrix in vector
		cells_vector = autocorr_matrix.asInteger.sum;
		cells_vector.postln;
		cells_vector.size.postln;
		max_item = cells_vector.maxItem;

		// Find indexes of cell matches
		cells_vector.do({ | val, id |
			if((val == max_item) && (cells_vector.wrapAt(id - 1) < max_item), {
				var cell = [];
				block { | break |
					10.do({ | id2 |
						if(cells_vector[id + id2] > 0, { cell = cell ++ [id + id2].postln; }, { break.value(999) });
					});
				};
				("Cell:    " ++ cell).postln;
				cells = cells ++ [cell];
			});
		});

		// Find items of indexes
		cell_values = cells.collect({ | cell |
			original_data[cell.first..cell.last]
		});
		("Cell values:" + cell_values).postln;
		~data["CelluleRitmoMelodiche"].put("Cells", cell_values.asSet.asArray);
	}, {});
});

//~data["CelluleRitmoMelodiche"]["FindCells"].value();
//~data["CelluleRitmoMelodiche"]["Cells"].value().collect({ | cell | cell.size });



~data["CelluleRitmoMelodiche"].put("PlayRandomCell", { | sample, chord, octave_add=0, reverse=false |
	var cell = ~data["CelluleRitmoMelodiche"]["Cells"].choose;
	if(cell.size > 0, {
		cell[cell.size - 1][0] = [0, 3, 4].choose;
	});
	octave_add = octave_add + 0;
	if(cell != nil, {
		Routine{
			"Playing cell...".postln;
			if(reverse, { cell = cell.reverse });
			cell.do({ | note |
				var octave = ((note[0] + chord) / ~data["Scales"][~preset["Scale"]].size).trunc;
				var new_note = ((~data["Scales"][~preset["Scale"]].wrapAt(note[0] + chord)  + (12 * octave.trunc)).asInteger % 12);
				("Playing cell note: " ++ (~preset["Tone"].asInteger + new_note + chord + (octave_add * 12))).postln;
				~playSample.value(sample, ~preset["Tone"].asInteger + new_note + (octave_add * 12), note[1] * 0.85, 0.8, "Melody");
				(note[1] * 1).wait;
			});
		}.play(~data["Clock"]);
	});
});


~data.put("Dynamics", Dictionary.new
	.put("Velocity", 32)
	.put("BeatFactor", 1)
	.put("AndamentoGenerator", { | andamento=#[32, 78, 4] |
		var from = andamento[0], to = andamento[1], dur = andamento[2];
		Routine{
			var steps = 100;
			steps.do({ | id |
				~data["Dynamics"].put("Velocity", (from + ((to - from) * id / steps)) );

				// Controllo Granulatori da Velocity
				//~dsp["BassBufferGranulator"].amp_(~data["Dynamics"]["Velocity"] / 127);
				//~dsp["BodyBufferGranulator"].amp_(~data["Dynamics"]["Velocity"] / 127);
				/*
				~dsp["BassBusGranulator"].maxDel_(~data["Dynamics"]["Velocity"] / 2048);
				~dsp["BodyBusGranulator"].maxDel_(~data["Dynamics"]["Velocity"] / 2048);
				~dsp["MelodyBusGranulator"].maxDel_(~data["Dynamics"]["Velocity"] / 2048);
				~dsp["BodyBusGranulator"].maxRate_(~data["Dynamics"]["Velocity"] / 512);
				~dsp["MelodyBusGranulator"].maxRate_(~data["Dynamics"]["Velocity"] / 512);
				*/
				(dur / steps).wait;
			});
		}
	})
	.put("Andamenti", Dictionary.new
		.put("CrescenteVeloce", [50, 120, 2])
		.put("CrescenteNormale", [50, 120, 4])
		.put("CrescenteLento", [50, 120, 8])
		.put("DecrescenteVeloce", [120, 50, 2])
		.put("DecrescenteNormale", [120, 50, 4])
		.put("DecrescenteLento", [120, 50, 8])
	)
	.put("AndamentiTransitionMatrix", [
		[0.1, 0.1, 0.2, 0.1, 0.3, 0.2],
		[0.2, 0.1, 0.3, 0.2, 0.1, 0.1],
		[0.1, 0.3, 0.1, 0.2, 0.2, 0.1],
		[0.2, 0.3, 0.1, 0.1, 0.2, 0.1],
		[0.1, 0.1, 0.3, 0.2, 0.1, 0.2],
		[0.3, 0.1, 0.1, 0.2, 0.2, 0.1],
	])
);
~data["Dynamics"].put("AndamentiMarkovChain", FRDMarkovChain.new(~data["Dynamics"]["Andamenti"].keys.asArray, ~data["Dynamics"]["AndamentiTransitionMatrix"], "CrescenteLento"));
~data["Dynamics"]["AndamentiMarkovChain"].impose("CrescenteLento");
~data["Dynamics"].put("NAndamenti", 0);
~data["Dynamics"].put("DynamicsPlayerGenerator", {

	Routine{
		inf.do({ | id |
			var andamento, andamentoRoutine;
			if(id == 0, {andamento = ~data["Dynamics"]["AndamentiMarkovChain"].current}, {andamento = ~data["Dynamics"]["AndamentiMarkovChain"].next});
			andamentoRoutine = ~data["Dynamics"]["AndamentoGenerator"].value(~data["Dynamics"]["Andamenti"][andamento]);
			~data["Dynamics"].put("NAndamenti", ~data["Dynamics"]["NAndamenti"] + 1);
			andamentoRoutine.play(~data["Clock"]);
			~data["Dynamics"]["Andamenti"][andamento][2].wait;
		});
	}
});

~data.put("ChordMarkovChain", FRDMarkovChain.new(["0", "1", "2", "3", "4", "5", "6"], [
	[ 0.28, 0, 0, 0.22, 0.28, 0.22, 0 ],
	[ 0, 0.28, 0.22, 0, 0.28, 0.22, 0 ],
	[ 0, 0, 0.28, 0, 0.22, 0.28, 0.22 ],
	[ 0.22, 0, 0, 0.28, 0.28, 0.22, 0 ],
	[ 0.28, 0, 0, 0.22, 0.28, 0.22, 0 ],
	[ 0, 0.28, 0, 0.22, 0.28, 0.12, 0.1 ],
	[ 0, 0.28, 0.22, 0.22, 0.28, 0, 0 ]
], "0"));





//~data["Dynamics"]["AndamentiMarkovChain"].next
//~data["Dynamics"]["AndamentiMarkovChain"].current







// Scegli una nota partendo da scala ed accordo. Senza cognizione di prima e dopo.
~chooseNote = { | scale, chord, instr |
	var note, octave;
	note = ~preset["Instruments"][instr]["Notes"][chord.asString].choose;
	octave = ((note + chord) / ~data["Scales"][~preset["Scale"]].size).trunc;
	note = ~data["Scales"][~preset["Scale"]].wrapAt(note + chord) + (12 * octave.trunc);
	note
};

~genMelody = { | scale, rhythm, chord, nextchord |
	var melody = [];
	var decomposed = [];
	var size = rhythm.size;
	while({size > 0}, {
		if(size == 2, { decomposed = decomposed.add(2); size = size - 2; }, {
			if(size == 3, { decomposed = decomposed.add(3); size = size - 3; }, {
				if(size == 4, { decomposed = decomposed.add(2); size = size - 2; }, {
					var choice = [2, 3].choose;
					decomposed = decomposed.add(choice);
					size = size - choice;
				});
			});
		});
	});
	decomposed.do({ | dec |
		melody = melody.add(~preset["MelodicCells"][chord.asString][dec.asString].choose + if(0.15.coin, {7}, {0}));
	});
	melody = melody.flat;
	melody = melody.collect({ | note |
		var octave = ((note + chord) / ~data["Scales"][~preset["Scale"]].size).trunc;
		(~data["Scales"][~preset["Scale"]].wrapAt(note + chord)  + (12 * octave.trunc)).asInteger;
	});
	melody
};

//~chooseNote.value(~preset["Scale"], 0, "Bass")
//~preset["Instruments"]["Basso"]["Notes"]["4"].choose;
// Scegli una nota partendo da scala ed accordo. Senza cognizione di prima e dopo.
~chooseNote = { | scale, chord, instr |
	var note, octave;
	note = ~preset["Instruments"][instr]["Notes"][chord.asString].choose;
	octave = ((note + chord) / ~data["Scales"][~preset["Scale"]].size).trunc;
	note = ~data["Scales"][~preset["Scale"]].wrapAt(note + chord) + (12 * octave.trunc);
	note
};

// Scomponi un {numero > 1} in una sequenza di 4, 3 o 2 (eg. 7 == [4, 3])
~decompose432 = { | number |
	var decomposed = [];
	if(number <= 1, {number}, {
		while({number > 0}, {
			if(number % 4 == 0, { decomposed = decomposed.add(4); number = number - 4; }, {
				if(number % 3 == 0, { decomposed = decomposed.add(3); number = number - 3; }, {
					if(number % 2 == 0, { decomposed = decomposed.add(2); number = number - 2; }, {
						var choice = [2, 3].choose;
						decomposed = decomposed.add(choice);
						number = number - choice;
					});
				});
			});
		});
	});
	decomposed
};

//~genMelodyPernoPreCheck.value("Chitarra", ~preset["Scale"], ~preset["Instruments"]["Chitarra"]["Rhythms"].choose, 0, 0, ~preset["Instruments"]["Chitarra"]["MinPernoDur"]);

~genMelodyPernoPreCheck = { | instr, scale, rhythm, chord, nextchord, minpernodur=0.75, minderivative=4 |
	var melody = [];
	var skip = 0;
	var size = rhythm.size;
	var perni, notperno = true;
	var pernoNotes = ~preset["Instruments"][instr]["PernoNotes"][chord.asString];
	perni = rhythm.collect({ | ry, rid |
		if(ry >= minpernodur, {true}, {false});
	});
	perni = perni.collect({ | pe, pid |
		if((pe == false) && (notperno == true), {
			var nexttrue = 0;
			var num = 0;
			((perni.size-1)..(pid+1)).do({ | pid2 | if(perni[pid+pid2] == true, {nexttrue = pid+pid2});  });
			(pid..perni.size-1).do({ | pid2 | num = num + 1; });
			if((nexttrue < num) && (nexttrue > 0), {num = nexttrue});
			notperno = pe;
			num
		}, {notperno = pe; pe});
	});

	perni.do({ | pe, pid |
		if(skip > 1, {skip = skip + 1}, {
			if(pe.class == Integer, {
				var decomposition = ~decompose432.value(pe);
				var suffix = 0;
				var lastnote;
				if(pid > 0, {
					if((perni[pid + suffix - 1] == true), {perni[pid + suffix - 1] = pernoNotes.choose});
					lastnote = perni[pid + suffix - 1];
				}, {
					lastnote = chord;
				});
				decomposition.do({ | dec, decid |
					var choices = [], choice;
					~preset["Instruments"][instr]["Notes"][dec.asString].keys.do({ | key, id |
						var lastnotedistancecondition = (key[0].asString.asInteger <= (lastnote + 1)) && (key[0].asString.asInteger >= (lastnote - 1));
						var stddevcondition = ~preset["Instruments"][instr]["Notes"][dec.asString][key]["DerivativeMax"] < minderivative;
						var andamentodondition = (~preset["Instruments"][instr]["Notes"][dec.asString][key]["Andamento"] > 0) || (~preset["Instruments"][instr]["Notes"][dec.asString][key]["Andamento"] < 0);
						var distancecondition = ~preset["Instruments"][instr]["Notes"][dec.asString][key]["Distance"].abs < 7;
						if(lastnotedistancecondition && stddevcondition && andamentodondition && distancecondition, {
							choices = choices ++ [key];
						});
					});

					//[choices.choose, choices].postln;
					if(choices.size == 0, { choice = ~preset["Instruments"][instr]["Notes"][dec.asString].choose }, { choice = ~preset["Instruments"][instr]["Notes"][dec.asString][choices.choose] });
					choice = choice["Notes"];
					choice.do({ | note, noteid |
						perni[pid + suffix + noteid] = note;
					});
					suffix = suffix + dec;
				});
				skip = pe;
			});
		});
	});

	perni.do({ | pe, pid |
		if((pe == true) || (pe == false), {perni[pid] = [0, 2, 4].choose});
	});

	melody = perni;
	melody = melody.collect({ | note |
		var octave = ((note + chord) / ~data["Scales"][~preset["Scale"]].size).trunc;
		((~data["Scales"][~preset["Scale"]].wrapAt(note + chord)  + (12 * octave.trunc)).asInteger % 12);
	});
	[melody, perni]
};

~canModulate = { | chord, nextchord, probability |
	if(chord == 4 && nextchord == 0 && (probability).coin, {true}, {false})
};


~generateInstrumentGUI = { | name, instrDataStructure |
	var view = View.new;
	instrDataStructure.put("PlayButton", Button.new.states_([["Off", Color.black, Color.red(0.7)], ["On", Color.black, Color.green(0.7)]]).action_({ | val |
		if(val.value == 1, {instrDataStructure.put("Play", true)}, {instrDataStructure.put("Play", false)});
	}).valueAction_(instrDataStructure["Play"]));
	instrDataStructure.put("InstrumentSelect", PopUpMenu.new.items_(instrDataStructure["Samples"]).action_({ | val | instrDataStructure.put("Sample", val.item); }).valueAction_(instrDataStructure["Samples"].collect({ | yy | yy.asSymbol}).indexOf(instrDataStructure["Sample"].asSymbol));
	);
	instrDataStructure.put("VolumeGUI", NumberBox.new.action_({ | val |
		instrDataStructure.put("Volume", val.value);
	}).value_(instrDataStructure["Volume"]));
	instrDataStructure.put("StaccatoProbGUI", NumberBox.new.action_({ | val |
		instrDataStructure.put("StaccatoProb", val.value);
	}).value_(instrDataStructure["StaccatoProb"]));
	instrDataStructure.put("StaccatoFracGUI", NumberBox.new.action_({ | val |
		instrDataStructure.put("StaccatoFrac", val.value);
	}).value_(instrDataStructure["StaccatoFrac"]));
	// BASS SPECIFIC
	if((instrDataStructure["Kind"] == "Bass"), {
		view.layout_(
			VLayout(
				StaticText.new.string_(name + "(" + instrDataStructure["Kind"] + ")"),
				HLayout(
					instrDataStructure["PlayButton"],
					instrDataStructure["InstrumentSelect"],
					StaticText.new.string_("Volume:"),
					instrDataStructure["VolumeGUI"],
				),
				HLayout(
					StaticText.new.string_("Staccato Probability:"),
					instrDataStructure["StaccatoProbGUI"]
				),
				HLayout(
					StaticText.new.string_("Staccato Fraction:"),
					instrDataStructure["StaccatoFracGUI"]
				),
			)
	)});
	// KEY SPECIFIC
	if((instrDataStructure["Kind"] == "Key"), {
		instrDataStructure.put("AllowLowerOctaveGUI", CheckBox.new.string_("Allow Lower Octave").action_({ | val |
			instrDataStructure.put("AllowLowerOctave", val.value);
		}).value_(instrDataStructure["AllowLowerOctave"]));
		instrDataStructure.put("AllowUpperOctaveGUI", CheckBox.new.string_("Allow Upper Octave").action_({ | val |
			instrDataStructure.put("AllowUpperOctave", val.value);
		}).value_(instrDataStructure["AllowUpperOctave"]));
		instrDataStructure.put("MinArpeggioNoteGUI", NumberBox.new.action_({ | val |
			instrDataStructure.put("MinArpeggioNote", val.value);
		}).value_(instrDataStructure["MinArpeggioNote"]));
		instrDataStructure.put("ArpeggioProbGUI", NumberBox.new.action_({ | val |
			instrDataStructure.put("ArpeggioProb", val.value);
		}).value_(instrDataStructure["ArpeggioProb"]));
		view.layout_(
			VLayout(
				StaticText.new.string_(name + "(" + instrDataStructure["Kind"] + ")"),
				HLayout(
					instrDataStructure["PlayButton"],
					instrDataStructure["InstrumentSelect"],

					StaticText.new.string_("Volume:"),
					instrDataStructure["VolumeGUI"],
				),
				HLayout(
					instrDataStructure["AllowLowerOctaveGUI"],
					instrDataStructure["AllowUpperOctaveGUI"]
				),
				HLayout(
					StaticText.new.string_("Min Arpeggio Note Duration:"),
					instrDataStructure["MinArpeggioNoteGUI"],
				),
				HLayout(
					StaticText.new.string_("Arpeggio Probability:"),
					instrDataStructure["ArpeggioProbGUI"]
				),
				HLayout(
					StaticText.new.string_("Staccato Probability:"),
					instrDataStructure["StaccatoProbGUI"]
				),
				HLayout(
					StaticText.new.string_("Staccato Fraction:"),
					instrDataStructure["StaccatoFracGUI"]
				),

			)
	)});
	// LEAD SPECIFIC
	if(instrDataStructure["Kind"] == "Lead", {
		instrDataStructure.put("MinPernoDurGUI", NumberBox.new.action_({ | val |
			instrDataStructure.put("MinPernoDur", val.value);
		}).value_(instrDataStructure["MinPernoDur"]));
		instrDataStructure.put("StdConditionGUI", CheckBox.new.string_("Std Condition").action_({ | val |
			instrDataStructure.put("StdCondition", val.value);
		}).value_(instrDataStructure["StdCondition"]));
		instrDataStructure.put("MinStdGUI", NumberBox.new.action_({ | val |
			instrDataStructure.put("MinStd", val.value);
		}).value_(instrDataStructure["MinStd"]));
		instrDataStructure.put("LastNoteDistanceConditionGUI", CheckBox.new.string_("Distance Condition").action_({ | val |
			instrDataStructure.put("LastNoteDistanceCondition", val.value);
		}).value_(instrDataStructure["LastNoteDistanceCondition"]));
		instrDataStructure.put("AndamentoConditionGUI", NumberBox.new.action_({ | val |
			instrDataStructure.put("AndamentoCondition", val.value);
		}));

		view.layout_(
			VLayout(
				StaticText.new.string_(name + "(" ++ instrDataStructure["Kind"] ++ ")"),
				HLayout(
					instrDataStructure["PlayButton"],
					instrDataStructure["InstrumentSelect"],

					StaticText.new.string_("Volume:"),
					instrDataStructure["VolumeGUI"],
				),
				HLayout(
					StaticText.new.string_("Min Perno Dur:"),
					instrDataStructure["MinPernoDurGUI"],
				),
				HLayout(
					StaticText.new.string_("Min Std:"),
					instrDataStructure["MinStdGUI"],
				),
				HLayout(
					StaticText.new.string_("Andamento:"),
					instrDataStructure["AndamentoConditionGUI"],
				),
				HLayout(
					instrDataStructure["StdConditionGUI"],
					instrDataStructure["LastNoteDistanceConditionGUI"],
				),
				HLayout(
					StaticText.new.string_("Staccato Probability:"),
					instrDataStructure["StaccatoProbGUI"]
				),
				HLayout(
					StaticText.new.string_("Staccato Fraction:"),
					instrDataStructure["StaccatoFracGUI"]
				),
			)
	)});

	view
};


~readPreset = { |	presetPath |
	var instrViews = [];
	File.open(presetPath, "r").readAllString.interpret;
	~data.put("Clock", TempoClock(~preset["Tempo"]));
	~selectScale.items_(~preset["Scales"]).valueAction_(~preset["Scales"].collect({ | yy | yy.asSymbol}).indexOf(~preset["Scale"].asSymbol));
	~selectTone.valueAction_(~preset["Tone"]);
	~preset["Instruments"].keys.do({ | instrument |
		instrViews = instrViews ++ [~generateInstrumentGUI.value(instrument, ~preset["Instruments"][instrument])];
	});
	~instrumentView.layout_(VLayout(*instrViews));
};

~playSample = { | instr, note, dur, velocity, kind |
	Routine{
		var path = ~sampleLibPathNoVelocity ++ instr +/+ note.asString ++ ".wav";
		var buffer = Buffer.read(s, path);
		//(" velocity: " ++ (velocity + 45).clip(30, 127).asInteger ++ " note: " ++ note ++ "path: " ++ path).postln;
		velocity = velocity * 15;
		(~data["PlaySampleDelay"] + exprand(0.0001, 0.02)).wait;
		Synth.head(~dsp["NoteGroup"], [\Sampler, \SamplerReverse].wchoose(~data["NormalReverseChoice"]), [\buf, buffer, \amp, velocity * FRDAmpComp(note.midicps).pow(0.3) / 127.0, \dur, dur + 0.5, \out, ~dsp[kind ++ "OutCh"]]);
		(dur + 2).wait;
		buffer.free;
	}.play;
};

~playSampleVelocity = { | instr, note, dur, velocity, kind |
	Routine{
		var path = ~sampleLibPath ++ (velocity + 45).clip(30, 127).asInteger.asString +/+ note.asString ++ ".wav";
		var buffer = Buffer.read(s, path);
		var synth = [\Sampler, \SamplerReverse].wchoose(~data["NormalReverseChoice"]);
		//("path: " ++ path ++ " velocity: " ++ (velocity + 45).clip(30, 127).asInteger ++ " note: " ++ note).postln;
		velocity = velocity * 15;
		(~data["PlaySampleDelay"] + exprand(0.0001, 0.02)).wait;
		Synth.head(~dsp["NoteGroup"], synth, [\buf, buffer, \amp, FRDAmpComp(note.midicps).pow(0.3), \dur, dur + 0.5, \out, ~dsp[kind ++ "OutCh"]]);
		(dur + 2).wait;
		buffer.free;
	}.play;
};

~readScaleChordsMIDIFile = { | path="/Users/francescodani/Documents/SuperCollider/MusicaGenerativa/MusicGenerator_V2/data/ScaleChords/Major.MID" |
	var midifile, notes=[], group=[], group_id=0, str, min_note;
	midifile = SimpleMIDIFile.read(path);
	midifile.noteOnEvents(0, 0).collect({ |note_on_event, note_on_event_id |
		if(note_on_event[1] == group_id, {
			group = group ++ note_on_event[4];
		}, {
			group_id = note_on_event[1];
			notes = notes ++ [group];
			group = [];
			group = group ++ note_on_event[4];
		});
	});
	notes = notes ++ [group]; // Last group is not added by default
	//min_note = notes.flat.minItem;
	//("min_note: " ++ min_note).postln;
	//min_note = (min_note / 12).trunc.asInteger * 12;
	//notes = notes - min_note;
	notes = notes % 12;
	str = "Dictionary.new";
	notes.do({| note_vec, note_vec_id |
		str = str ++ ".put(\"" ++ note_vec_id.asString ++ "\", " ++ note_vec.asString ++ ")";
	});
	str.interpret
};

~readRhythmMIDIFile = { | path="/Users/francescodani/Documents/SuperCollider/MusicaGenerativa/MusicGenerator_V2/data/ScaleChords/Major.MID" |
	var midifile, notes=[], group=[], group_id=0, str, division, tempo, tmul, rhythm=[], prev_tick=0, eof_tick;
	midifile = SimpleMIDIFile.read(path);
	division = midifile.division;
	tempo = midifile.tempo;
	tmul = 60 / tempo;
	eof_tick = midifile.noteOnEvents.last[1].roundUp((division * 16));
	midifile.noteOnEvents(0, 0).collect({ |note_on_event, note_on_event_id |
		if(note_on_event[1] > prev_tick, {
			rhythm = rhythm ++ (note_on_event[1] - prev_tick);
			(note_on_event[1] - prev_tick).postln;
		});
		prev_tick = note_on_event[1];

	});
	rhythm = rhythm ++ (midifile.noteOffEvents.last[1] - rhythm.sum);
	rhythm = rhythm / (division * 4);
	rhythm
};

~checkParallelNotes = { | note_group_A=#[33, 35], note_group_B=#[33, 35] |
	if( ((note_group_A[0] % 12) == (note_group_B[0] % 12)) && ((note_group_A[1] % 12) == (note_group_B[1] % 12)), { true }, { false });
};

~getPernoNotesFromScaleNotes = { | scale_notes |
	scale_notes.keysValuesDo({ | key, val |
		if(val.size > 2, {
			val = ([0] ++ val[val.size-2..]).postln;
		});
		scale_notes[key] = (val % 12).sort;
	});
	scale_notes
};

~data.put("BeatRoutines", Dictionary.new
	.put("Bass", { | chord, nextChord, instrName, instrDataStructure |
		Routine{
			var rhythm = instrDataStructure["Rhythms"].choose;
			var sample = ~data["Samples"].choose;
			rhythm.do({ | delta |
				var note = (~preset["Tone"] + ~chooseNote.value(~preset["Scale"], chord, instrName)).asInteger;
				var midinote = note;
				var velocity = ~computeDynamic.value(instrDataStructure);
				var notedelta = if(instrDataStructure["StaccatoProb"].coin, {delta * instrDataStructure["StaccatoFrac"]}, {delta});
				//("Basso midinote: " ++ midinote).postln;
				if(~data["WriteMIDIFile"], {
					m.addNote( midinote, velocity, instrDataStructure["MIDICounter"], delta, channel:instrDataStructure["MIDIChannel"], track:0, sort:true );
				});
				if(~data["PlayVelocitySampler"] == True, {
					sample = instrDataStructure["Sample"];
					~playSampleVelocity.value(sample, midinote, notedelta, velocity, "Bass");

				}, {
					~playSample.value(instrDataStructure["Sample"], midinote, notedelta, velocity, "Bass");
				});
				instrDataStructure.put("MIDICounter", instrDataStructure["MIDICounter"] + delta);

				delta.wait;
			});
		}
	})
	.put("Key", { | chord, nextChord, instrName, instrDataStructure |
		Routine{
			var rhythm = instrDataStructure["Rhythms"].choose;
			rhythm.do({ | delta |
				var notes = instrDataStructure["Notes"][chord.asString];
				var nnotes = ~computeNNotes.value(notes);
				var arpeggio = (instrDataStructure["ArpeggioProb"].coin && (delta <= instrDataStructure["MinArpeggioNote"]).not && (nnotes <= 6));
				var tmpcounter = instrDataStructure["MIDICounter"];
				var sample = ~data["Samples"].choose;
				// if(instrDataStructure["AllowLowerOctave"], {notes = notes ++ (notes - 12)});
				// if(instrDataStructure["AllowUpperOctave"], {notes = notes ++ (notes + 12)});
				if(instrDataStructure["AllowLowerOctave"], {
					notes = notes.collect({ | note, id|
						note = note - 12;
						if(note < (instrDataStructure["Notes"][chord.asString].minItem - 6), { note = note + 12});
						note
					});
				});
				if(instrDataStructure["AllowUpperOctave"], {
					notes = notes.collect({ | note, id|
						note = note + 12;
						if(note > (instrDataStructure["Notes"][chord.asString].maxItem + 6), { note = note - 12});
						note
					});
				});
				notes = if(0.25.coin, {notes.reverse}, {notes});
				if(arpeggio, {
					var keep = if(delta % 0.5 == 0.0, {if(delta < 1, {2}, {4})}, {if(delta < 1, {4}, {2})});
					if(keep >= nnotes, {keep = nnotes - 1});
					notes = notes.scramble.keep(keep);
					nnotes = notes.size;
				}, {
					notes = notes.keep(rrand(4, nnotes));
				});

				if(0.75.coin, {
					notes.do({ | note, noteID |
						var octave = ((note + chord) / ~data["Scales"][~preset["Scale"]].size).trunc.asInteger;
						var midinote = (~preset["Tone"]
							+ (octave.trunc.asInteger * 12)
							+ (instrDataStructure["Octave"] * 12)
							+ ~data["Scales"][~preset["Scale"]].wrapAt((note + chord))).asInteger;
						var velocity = ~computeDynamic.value(instrDataStructure);
						var notedelta = if(instrDataStructure["StaccatoProb"].coin, {delta  * instrDataStructure["StaccatoFrac"]}, {delta});
						if(arpeggio, {notedelta = (notedelta / notes.size)}); //  * (notes.size - noteID)
						/*
						if(arpeggio && (notes.size < 4), {
						Routine{
						~data["PlaySampleDelay"].wait;
						~dsp["BodyBusGranulator"].maxDel_(~data["Dynamics"]["Velocity"] / 2048);
						}.play;

						}, {
						Routine{
						~data["PlaySampleDelay"].wait;
						~dsp["BodyBusGranulator"].maxDel_(0.005);
						}.play;
						});
						*/
						if(~data["WriteMIDIFile"], {
							m.addNote(midinote, velocity, tmpcounter, notedelta, channel:instrDataStructure["MIDIChannel"], track:0, sort:true );
						});
						if(~data["PlayVelocitySampler"] == True, {
							sample = instrDataStructure["Sample"];
							~playSampleVelocity.value(sample, midinote, notedelta, velocity, "Body");
						}, {
							~playSample.value(instrDataStructure["Sample"], midinote, notedelta, velocity, "Body");
						});
						if(arpeggio, { (delta / nnotes).wait; tmpcounter = tmpcounter + (delta / nnotes).round(0.001); });
					});
					instrDataStructure.put("MIDICounter", instrDataStructure["MIDICounter"] + delta);
					if(arpeggio.not, { delta.wait; });
				}, { "skip".postln; delta.wait; });
			})
		}
	})
	.put("Lead", { | chord, nextChord, instrName, instrDataStructure |
		Routine{
			if(true, {
			//if(chord != 0, { // Togliere melodia da 1° grado dà respiro
				var rhythm = instrDataStructure["Rhythms"].choose;
				var sample = ~data["Samples"].choose;
				if(0.75.coin && (~computeNNotes.value(instrDataStructure) > 1), {
					var melody_perni = ~genMelodyPernoPreCheck.value(instrName, ~preset["Scale"], rhythm, chord, nextChord, instrDataStructure["MinPernoDur"]);
					melody_perni[0].do({ | note, id |
						var midinote = (~preset["Tone"] + (instrDataStructure["Octave"] * 12) + note).asInteger;
						var velocity = ~computeDynamic.value(instrDataStructure);
						var delta = rhythm[id];
						var notedelta = if(instrDataStructure["StaccatoProb"].coin, {delta  * instrDataStructure["StaccatoFrac"]}, {delta});
						if(~data["WriteMIDIFile"], {
							m.addNote(midinote, velocity, instrDataStructure["MIDICounter"], notedelta, channel:instrDataStructure["MIDIChannel"], track:0, sort:true );
						});
						if((~data["PlayVelocitySampler"] == True), {
							sample = instrDataStructure["Sample"];
							~playSampleVelocity.value(sample, midinote, notedelta, velocity, "Melody");
						}, {
							~playSample.value(instrDataStructure["Sample"], midinote, notedelta, velocity, "Melody");
						});
						~data["CelluleRitmoMelodiche"]["AddNoteToHistory"].value([melody_perni[1][id], notedelta, velocity]);
						instrDataStructure.put("MIDICounter", instrDataStructure["MIDICounter"] + delta);
						delta.wait;
					});
				}, {
					//"Skipping lead".postln;
					instrDataStructure.put("MIDICounter", instrDataStructure["MIDICounter"] + 4);
					4.wait;
				});
				if(0.25.coin, {


				});
			}, { "Skipping Melody!".postln; });

		}
	})
);

~computeDynamic = { | instrDataStructure |
	var scaleFactor = (~data["Dynamics"]["Velocity"] / 127) * ((~data["Dynamics"]["BeatFactor"] / 255) + 0.5);
	var value = (instrDataStructure["Volume"].dbamp * scaleFactor).asInteger + rrand(-4, 4);
	//("value" + value).postln;
	value
};

~computeNNotes = { | notes, bias=3 |
	var nnotes = (notes.size * ((~data["Dynamics"]["Velocity"] - 30) / 97).pow(2) * ((~data["Dynamics"]["BeatFactor"] / 255) + 0.5) ).roundUp(1).asInteger + bias;
	nnotes
};
/*
~generatePlayRoutine = {
Routine{
var chordMarkovChain = FRDMarkovChain.new(~preset["Chords"], ~preset["ChordTransitionMatrix"], "0");
var chord, nextchord;
var dynamicsRoutine = ~data["Dynamics"]["DynamicsPlayerGenerator"].value();
dynamicsRoutine.play(~data["Clock"]);
chordMarkovChain.impose("0");
chord = chordMarkovChain.current().asString.asInteger;
nextchord = chordMarkovChain.current().asString.asInteger;
inf.do({ | repetition_id |
chord = nextchord;
nextchord = chordMarkovChain.next().asString.asInteger;
//("chord" + chord + " nextchord " + nextchord).postln;
Routine{
Env.new([1.2, 0.5, 0.75, 0.25], [1, 1, 1], [-4, 2, -4, 2]).asSignal(100).do({ | val |
~data["Dynamics"].put("BeatFactor", val * 127);
})
}.play(~data["Clock"]);
~preset["Instruments"].keys.do({ | instr |
var beatRoutine = ~data["BeatRoutines"][~preset["Instruments"][instr]["Kind"]].value(chord, nextchord, instr, ~preset["Instruments"][instr]);
beatRoutine.play(~data["Clock"]);
});
4.wait;
});
};
};
*/


~generatePlayRoutine = {
	~currentNotes = [];
	Routine{
		var chordMarkovChain = ~data["ChordMarkovChain"];
		//var chordMarkovChain = FRDMarkovChain.new(~preset["Chords"], ~preset["ChordTransitionMatrix"], "0");
		var dynamicsRoutine = ~data["Dynamics"]["DynamicsPlayerGenerator"].value();
		var rhythmid, rhythmnum;
		dynamicsRoutine.play(~data["Clock"]);
		chordMarkovChain.impose("0");
		~data.put("Chord",  chordMarkovChain.current().asString.asInteger);
		~data.put("NextChord", chordMarkovChain.current().asString.asInteger);
		inf.do({ | repetition_id |
			~data.put("Chord", ~data["NextChord"]);
			~data.put("NextChord", chordMarkovChain.next().asString.asInteger);

			//("chord" + chord + " nextchord " + nextchord).postln;
			Routine{
				Env.new([1.2, 0.5, 0.75, 0.25], [1, 1, 1], [-4, 2, -4, 2]).asSignal(100).do({ | val |
					~data["Dynamics"].put("BeatFactor", val * 127);
				})
			}.play(~data["Clock"]);

			rhythmid = ~preset["Instruments"].collect({ | instr | instr["Rhythms"].size }).maxItem.rand.asString;
			//rhythmid = ~computeWhichRhythm.value(~preset["Instruments"].collect({ | instr | instr["Rhythms"].size }).maxItem - 1);
			rhythmnum = ~computeWhichRhythm.value(6); // 7 permutazioni, quindi max_id=6
			[rhythmid, rhythmnum].postln;
			~currentNotes = [];

			//~generateFormants.value(~preset["Instruments"]["Body"]["Notes"][chord.asString] + ~preset["Tone"] + 24, 4, 0.3);


			if((~data["Dynamics"]["Velocity"] * 8 / 127).coin, {
				~fnotes = ~preset["Instruments"]["Body"]["Notes"]["0"].collect({ | note |
					var octave = (note / ~data["Scales"][~preset["Scale"]].size).asInteger;
					~data["Scales"][~preset["Scale"]].wrapAt(note) + (octave * 12);
				});
				~fnotes = [0, 7];
				~fnotes = ~data["Chord"] + ~fnotes + ~preset["Tone"] + 0;
				if(1.coin, {
					//~generateFormants.value(~fnotes, 4, 0.3);
				});

				~preset["Instruments"].keys.do({ | instr |
					var beatRoutine = ~data["BeatRoutines"][~preset["Instruments"][instr]["Kind"]].value(~data["Chord"], ~data["NextChord"], instr, ~preset["Instruments"][instr]);
					beatRoutine.play(~data["Clock"]);
				});

				4.wait;
			}, {
				if(0.5.coin, {

					// Spezza battuta in 2
					"\tSpezza battuta in 2".postln;
					2.do({
						if((~data["Dynamics"]["Velocity"] * 8 / 127).coin, {
							var routines = ~preset["Instruments"].keys.collect({ | instr |
								var beatRoutine = ~data["BeatRoutines"][~preset["Instruments"][instr]["Kind"]].value(~data["Chord"], ~data["NextChord"], instr, ~preset["Instruments"][instr]);
								beatRoutine.play(~data["Clock"]);
							});
							~fnotes = ~preset["Instruments"]["Body"]["Notes"]["0"].collect({ | note |
								var octave = (note / ~data["Scales"][~preset["Scale"]].size).asInteger;
								~data["Scales"][~preset["Scale"]].wrapAt(note) + (octave * 12);
							});
							~fnotes = [0, 7];
							~fnotes = ~data["Chord"] + ~fnotes + ~preset["Tone"] + 0;
							//~generateFormants.value(~fnotes, 2, 0.3);
							2.wait;
							routines.do({ | rout | rout.stop; });
							~data.put("Chord", ~data["NextChord"]);
							~data.put("NextChord", chordMarkovChain.next().asString.asInteger);
						}, { 2.wait; "pausa... ci sta?".postln });
					});
				}, {
					// Spezza battuta in 4
					"\tSpezza battuta in 4".postln;
					4.do({
						if(( ~data["Dynamics"]["Velocity"] * 8 / 127).coin, {
							var routines = ~preset["Instruments"].keys.collect({ | instr |
								var beatRoutine = ~data["BeatRoutines"][~preset["Instruments"][instr]["Kind"]].value(~data["Chord"], ~data["NextChord"], instr, ~preset["Instruments"][instr]);
								beatRoutine.play(~data["Clock"]);
							});
							~fnotes = ~preset["Instruments"]["Body"]["Notes"]["0"].collect({ | note |
								var octave = (note / ~data["Scales"][~preset["Scale"]].size).asInteger;
								~data["Scales"][~preset["Scale"]].wrapAt(note) + (octave * 12);
							});
							~fnotes = [0, 7];
							~fnotes = ~data["Chord"] + ~fnotes + ~preset["Tone"] + 0;
							//~generateFormants.value(~fnotes, 1, 0.3);
							1.wait;
							routines.do({ | rout | rout.stop; });
							~data.put("Chord", ~data["NextChord"]);
							~data.put("NextChord", chordMarkovChain.next().asString.asInteger);
						});
					}, { 1.wait; "pausa... ci sta?".postln });
				});
			});

			/*
			// MODULATION START
			if((~data["Chord"] == 4) && (~data["NextChord"] == 0), {
			var octave = (~preset["Tone"] / 12).trunc;
			var newtone = ~preset["Tone"] + 7;
			var newoctave = (newtone / 12).trunc;
			if(newoctave > octave, { newtone = newtone - 12 });
			~preset.put("Tone", newtone);
			"Modulate!".postln;
			~data.put("NextChord", 4);
			});
			// MODULATION END
			*/
			~data["CelluleRitmoMelodiche"]["FindCells"].value();
		});
	};
};
