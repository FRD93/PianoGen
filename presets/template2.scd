/*
******************************
******* MODELLO  PRESET *******
******************************

*** Dizionario associativo che deve contenere le sezioni ***

- Name: {String} Nome del preset.

- Tempo: {float} Tempo per il clock.

- Scales: {Vector[String]} Vettore di scale possibili del preset (tra quelle comprese nel dizionario "Scale" dello strumento).

- Scale: {String} Scala (una tra Scales).

- Tone: {int} Nota base della tonalità.

- ChordProgressions: {Vector[Vector[int]]} Matrice di progressioni di accordi possibili. Ogni vettore corrisponde ad una progressione.

- ChordMarkov: {Vector[Vector[int]]} Matrice quadrata di lato len(ChordProgressions) contenente i pesi della catena markoviana della successione delle progressioni

- InstrList {Vector[Vector[String, String]]} Matrice di nomi degli strumenti. Colonna 1: NomeStrumento; Colonna 2: TipoStrumento. Al momento i TipoStrumento supportati sono: { Bass : Key : Lead }.

- Instruments {Dictionary[[String, InstrDataStructure], ]} Dizionario di strutture dati degli strumenti.


*** InstrDataStructure ***

Questo dizionario deve contenere tutte le informazioni di ogni strumento. Comprende:

- Kind: {String} Tipo dello strumento. Gli InstrType al momento supportati sono: { Bass : Key : Lead }.

- Samples: {Vector[String]} Vettore di nomi di campioni possibili per lo strumento.

- Sample: {String} Nome dello strumento di partenza.

- Play: {Boolean} Suonare o meno lo strumento.

- Rhythms: {Vector[Vector[float]]} Matrice di ritmi possibili. Ogni vettore corrisponde ad un ritmo.

- Octave {int} Ottava rispetto al Tone

- Volume {float} Volume in dB dello strumento.

- StaccatoProb {float} Probabilità di staccare la durata di ciascuna nota.

- StaccatoFrac {float} Durata in % della nota staccata

- MIDIChannel {0} Canale MIDI dello strumento.

- MIDICounter {0} Contatore per scrittura file MIDI.

- Notes: Dipende dal tipo di strumento:
- - Bass: {Vector[String, Vector[int]]} Ogni elemento del vettore ha come primo elemento il nome del grado della scala (da 0 a 6), ed un vettore di possibili indici di note della scala (da 0 a 6 più eventuali ottave). Ogni indice è relativo alla tonica del grado della scala (e.g. se il grado è 0 e la nota è 0, allora sarà un Do, mentre se il grado è 4 e la nota è 0, allora sarà un Sol).
- - Key: Come Bass
- - Lead: {KDTree} Una struttura multidimensionale
- - - PernoNotes: Come Notes di Key, ma usate come perni melodici

- - SOLO PER KEY:
- - AllowLowerOctave {Boolean} Aggiungi le stesse note un'ottava sotto?
- - AllowUpperOctave {Boolean} Aggiungi le stesse note un'ottava sppra?
- - MinArpeggioNote {float} Durata minima di un accordo per essere arpeggiato.
- - ArpeggioProb {float} Probabilità di arpeggio per note possibili.

- SOLO PER LEAD:
- - MinPernoDur {float} Durata minima di nota per essere considerata perno melodico
- - StdCondition {Boolean} Legare la scelta melodica alla deviazione standard degli andamenti?
- - MinStd {int} Deviazione standard minima per StdCondition
- - LastNoteDistanceCondition {Boolean} Legare la scelta melodica alla vicinanza tra note degli andamenti?
- - AndamentoCondition {int} Andamento dei movimenti? {1: crescente; 0: uguale; -1: decrescente}
*/


(
~data.put("PlayVelocitySampler", True); // True -> Grand Piano Only
~sampleLibPath = "/Volumes/Backup Dani/Campioni/Instruments/GrandPiano2Full/";
~preset = Dictionary.new
.put("Tempo", 0.75)
.put("Name", "Default")
.put("Scales", ["Major", "Mixolydian", "HarmonicMinor", "Whole"])
.put("Scale", "Mixolydian")
.put("Tone", 36)
.put("ChordProgressions", [
	[0, 4, 5, 2, 3, 4, 5, 0],
	[0, 2, 4, 2, 5, 2, 4, 0],
	[0, 1, 4, 3, 0]
])
.put("Chords", ["0", "1", "2", "3", "4", "5", "6"])
.put("ChordTransitionMatrix", [
	[ 0.28, 0, 0, 0.22, 0.28, 0.22, 0 ],
	[ 0, 0.28, 0.22, 0, 0.28, 0.22, 0 ],
	[ 0, 0, 0.28, 0, 0.22, 0.28, 0.22 ],
	[ 0.22, 0, 0, 0.28, 0.28, 0.22, 0 ],
	[ 0.28, 0, 0, 0.22, 0.28, 0.22, 0 ],
	[ 0, 0.28, 0, 0.22, 0.28, 0.12, 0.1 ],
	[ 0, 0.28, 0.22, 0.22, 0.28, 0, 0 ]
])
.put("ChordProgressionsWeights", [0.5, 0.5])
.put("Instruments", Dictionary.new
	// BASSO
	.put("Basso", Dictionary.new
		.put("Kind", "Bass")
		.put("Samples", ["bass_102", "bass_103", "key_32"])
		.put("Sample", "key_32")
		.put("Play", true)
		.put("Octave", 1)
		.put("Volume", -15)
		.put("StaccatoProb", 0)
		.put("StaccatoFrac", 0.75)
		.put("MIDIChannel", 1)
		.put("MIDICounter", 0)
		.put("Notes", Dictionary.new
			.put("0", [0, 3, 4, 5])
			.put("1", [0, 4])
			.put("2", [0, 4])
			.put("3", [0, 3, 4, 5])
			.put("4", [0, 3, 4, 5])
			.put("5", [0, 4])
			.put("6", [0, 4])
			.put("7", [0, 4])
		)
		.put("Rhythms", Dictionary.new
			.put("01", [1, 2, 1])
			.put("02", [1, 1, 1, 1])
			.put("03", [3, 1])
			.put("04", [1, 0.5, 1, 1.5])
		)
	)
	// PIANOFORTE
	.put("Body", Dictionary.new
		.put("Kind", "Key")
		.put("Samples", ["key_32", "key_34", "lead_106", "lead_105"])
		.put("Sample", "lead_105")
		.put("Play", true)
		.put("Octave", 1)
		.put("AllowLowerOctave", false)
		.put("AllowUpperOctave", false)
		.put("MinArpeggioNote", 0.5)
		.put("ArpeggioProb", 0.5)
		.put("Volume", -12)
		.put("StaccatoProb", 0)
		.put("StaccatoFrac", 0.5)
		.put("MIDIChannel", 0)
		.put("MIDICounter", 0)
		.put("Notes", Dictionary.new
			.put("0", [0, 2, 4, 7, 9, 11])
			.put("1", [0, 2, 4, 7, 9, 11])
			.put("2", [0, 2, 4, 7, 9, 11])
			.put("3", [0, 2, 4, 7, 9, 11])
			.put("4", [0, 2, 4, 6, 9, 11])
			.put("5", [0, 2, 4, 7, 9, 11])
			.put("6", [0, 2, 4, 7, 9, 11])
		)
		.put("Rhythms", Dictionary.new
			.put("01", [2, 2])
			.put("02", [0.5, 1, 0.5, 1, 0.5, 0.5])
		)
	)
	// CHITARRA
	.put("Melody", Dictionary.new
		.put("Kind", "Lead")
		.put("Samples", ["lead_106", "lead_105", "key_32"])
		.put("Sample", "lead_106")
		.put("Play", true)
		.put("Octave", 3)
		.put("Volume", -9)
		.put("StaccatoProb", 0)
		.put("StaccatoFrac", 0.75)
		.put("MIDIChannel", 0)
		.put("MIDICounter", 0)
		.put("MinPernoDur", 0.75)
		.put("StdCondition", true)
		.put("MinStd", 7)
		.put("LastNoteDistanceCondition", true)
		.put("AndamentoCondition", 1)
		.put("Notes", ~data["Movimenti"])
		.put("PernoNotes", Dictionary.new
			.put("0", [0, 2, 4, 7, 11, 15])
			.put("1", [0, 2, 4, 7])
			.put("2", [0, 2, 4, 7, 13, 15])
			.put("3", [0, 2, 4, 7, 13, 15])
			.put("4", [0, 2, 4, 6, 11, 13, 15])
			.put("5", [0, 2, 4, 7])
			.put("6", [0, 2, 4, 7, 13, 15])
		)
		.put("Rhythms", Dictionary.new
			.put("01", [1, 3])
			.put("02", [0.5, 1, 0.5, 1, 0.5, 0.5])
			.put("04", [0.25, 0.5, 0.25, 0.5, 1, 1.5])
		)
	)
);
~data["ChordMarkovChain"].reinit(~preset["Chords"], ~preset["ChordTransitionMatrix"]);
)