# The latest project at work required me to get a rich text editor (RTE) running inside jquery thickbox. After trying out a few different RTEs I finally settled on the Yahoo YUI editor as it looks the nicest, and is easily customized.

# After 5 lines, YUI editor was up and running inside thickbox. Sweet, no problems there. However the insert image and link boxes failed completely, in all browsers. 

# The boxes were created and inserted alongside thickbox, instead of inside. Thankfully thanks to all of YUI editor's events this was an easy fix.
editor.on('windowInsertImageRender', function() {
     document.getElementById('dd-editor').appendChild(this.get('panel').element);
});

# Here, "dd-editor" is the ID of the div surrounding by YUI editor and 'editor' is the name of my YUI editor object. We simply set it to listen to the 'windowInsertImageRender' event and, when it occurs, attach it to the same div that the editor is in.

# That fixed, it seemed to be working very smoothly until, surprise, it fails in IE.

# ![YUI Thickbox Bug](/wp-content/uploads/2009/02/yui-thickbox-scroll-bug.png)

# When the thickbox is too small to hold all of the content and scrollbars appear, scrolling down creates all manners of positioning problems with the toolbar. Drilling down with the IE developer toolbar revealed that scrolling works down to the list element with a class of "yui-toolbar-groupitem". It is the elements inside that bug out.

# After an hour of trying various css positionings and styles, I managed to fix the content area and title bar in place with a bit of jquery.
$("#editor_editor").attr("position", "static")

# A fix for the buttons was eventually found as well, however it isn't so much a fix as it is a sluggish, ungainly hack.

$("#TB_ajaxContent").scroll(function () { editor.toolbar.collapse(true); editor.toolbar.collapse(false); } );

# Hooking in to the scroll event on the thickbox window, each time it moves we collapse and then redisplay the toolbar. This causes the buttons to jump into the correct place at the cost of a very slow scrolling time. 

# Note: the above 2 lines need to be called after the editor has fulled rendered and only in IE. This can be done by using the windowRender event and a bit of jquery, like so:
if ($.browser.msie) {
     editor.on('windowRender', function() {
         $("#editor_editor").attr("position", "static");
         $("#TB_ajaxContent").scroll(function () { editor.toolbar.collapse(true); editor.toolbar.collapse(false); } );
     });
}
