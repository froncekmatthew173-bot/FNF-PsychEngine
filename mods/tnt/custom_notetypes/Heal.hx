function onSpawnNote(note) {
 if (!note.isSustainNote)
     note.texture = 'notes/healnote';
}

function goodNoteHit(note) {
 game.health += 0.2;
}
