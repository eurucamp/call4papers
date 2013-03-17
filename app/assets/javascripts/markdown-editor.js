//= require showdown
//= require jquery.ba-resize
//= require jquery.caret.1.02
//= require markdowneditor

$('#editor').markdownEditor({
  toolbarLoc: $('#toolbar'),
  toolbar:    'default',
  preview:    $('#preview')
});
// $('#preview').show();
