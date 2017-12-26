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
    Out.ar(0, Pan2.ar(suboutput + clickoutput, 0))!2;
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

)

Synth.new(\kick);
Synth.new(\fullkick);
Synth.new(\closedhat);
Synth.new(\openhat);
s.freeAll

(
Routine({
	var dur = 0.5;
	loop({
		Synth(\fullkick);
		dur.wait;
	});
}).play
)

