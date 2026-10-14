function onSpawnNote(note) {
 if (!note.isSustainNote)
     note.texture = 'notes/minenote';
}

function goodNoteHit(note) {
 game.health += -0.25;
}
