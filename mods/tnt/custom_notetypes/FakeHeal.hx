function onSpawnNote(note) {
 if (!note.isSustainNote)
     note.texture = 'notes/fakehealnote';
}

function goodNoteHit(note) {
 game.health += -0.15;
}
