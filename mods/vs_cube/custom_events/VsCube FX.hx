// PsychEngine 1.0.4 HScript for events emitted by the Vs Cube port.
// Converted charts emit chart events as [time, [["VsCube FX 0..N", target, value]]].
function onEvent(event:String, value1:String, value2:String)
{
	switch (event)
	{
		// Default no-op; FX mapping kept in port/dossiers/vscube.md
	}
}