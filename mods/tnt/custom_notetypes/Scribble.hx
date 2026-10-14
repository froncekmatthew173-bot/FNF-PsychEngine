function onSpawnNote(note) {
 if (!note.isSustainNote)
     note.texture = 'notes/scribblenote';
}

function goodNoteHit(note) {
 game.health += -0.1;
}
