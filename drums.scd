/** Synth Definitions */

(
SynthDef.new(\kick, {
	var osc, env, output;
	osc = {SinOsc.ar(60)};
	env = {Line.ar(1, 0, 1, doneAction: 2)};
	output = osc * env;
	Out.ar(0, Pan2.ar(output, 0)!2);
}).add;

SynthDef(\fullkick, {
	var subosc, subenv, suboutput, clickosc, clickenv, clickoutput;
    subosc = {SinOsc.ar(60)};
	subenv = {Line.ar(1, 0, 1, doneAction: 2)};
    clickosc = {LPF.ar(WhiteNoise.ar(2),1500)};
    clickenv = {Line.ar(1, 0, 0.02)};
    suboutput = (subosc * subenv);
    clickoutput = (clickosc * clickenv);
    Out.ar(0, Pan2.ar(suboutput + clickoutput, 0));
}).add;

SynthDef(\openhat, {
    var hatosc, hatenv, hatnoise, hatoutput;
    hatnoise = {LPF.ar(WhiteNoise.ar(1),6000)};
    hatosc = {HPF.ar(hatnoise,2000)};
    hatenv = {Line.ar(1, 0, 0.3, doneAction: 2)};
    hatoutput = (hatosc * hatenv);
    Out.ar(0, Pan2.ar(hatoutput, 0)
    )

}).add;

SynthDef(\closedhat, {
    var hatosc, hatenv, hatnoise, hatoutput;
    hatnoise = {LPF.ar(WhiteNoise.ar(1),6000)};
    hatosc = {HPF.ar(hatnoise,2000)};
    hatenv = {Line.ar(1, 0, 0.1, doneAction: 2)};
    hatoutput = (hatosc * hatenv);
    Out.ar(0, Pan2.ar(hatoutput, 0));
}).add;

SynthDef(\snare, {
	var drumosc, filterenv, volenv, drumoutput, snaposc, snapenv, fulloutput;
	drumosc = {Pulse.ar(100)};
	filterenv = {Line.ar(1, 0, 0.2, doneAction: 0)};
	volenv = {Line.ar(1, 0, 0.6, doneAction: 2)};
	drumoutput = {LPF.ar(drumosc,(filterenv *1000) + 30)};
	snaposc = {BPF.ar(HPF.ar(WhiteNoise.ar(1),500),1500)};
	snapenv = {Line.ar(1, 0, 0.2, doneAction: 0)};
	fulloutput = (drumoutput * volenv) + (snaposc * snapenv);
	Out.ar(0, Pan2.ar(fulloutput, 0);
)}).add;

SynthDef('clap', {
	var claposc, clapenv, clapnoise, clapoutput;
	clapnoise = {BPF.ar(LPF.ar(WhiteNoise.ar(1),7500),1500)};
	clapenv = {Line.ar(1, 0, 0.6, doneAction: 2)};

	clapoutput = {
		Mix.arFill(7, {arg i;	EnvGen.ar(Env.new([0,0,1,0],[0.01 * i,0,0.04])) * clapnoise * 0.5});
	};

	Out.ar(0, Pan2.ar(clapoutput * clapenv, 0)):

}).add;
)

/** Patterns */

(
Pbind(
	\instrument, \fullkick,
	\dur, 0.5
).play;

Pbind(
	\instrument, \clap,
	\dur, 1
).play;

Pbind(
	\instrument, \closedhat,
	\dur, Pseq([0.5, 0.5, 0.15, 0.15, 0.2, 0.5], inf)
).play;

)

Synth.new(\kick);
Synth.new(\fullkick);
Synth.new(\closedhat);
Synth.new(\openhat);
Synth.new(\snare);
Synth.new(\clap);
s.freeAll
