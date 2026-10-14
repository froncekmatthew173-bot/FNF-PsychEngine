function onSpawnNote(note) {
 if (!note.isSustainNote)
     note.texture = 'notes/warningnote';
}

function goodNoteHit(note) {
 // no health change
}
