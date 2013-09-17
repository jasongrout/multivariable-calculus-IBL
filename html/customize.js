$(function() {
body=$('body')
button=$("<button>Toggle Marginal Notes</button>")
button.addClass("margintoggle")
button.click(function() {
    body.toggleClass('fullwidth');
    $('.marginpar').toggle();
})
    body.prepend(button);
    body.prepend('<a href="index.html">Return to Table of Contents</a><br/>');

    $("body a[href^='http://']").attr("target","_blank");
    $("body a[href^='https://']").attr("target","_blank");
    sagecell.makeSagecell({"inputLocation": ".sage"});
    sagecell.makeSagecell({"inputLocation": ".sageminimal", template:
sagecell.templates.minimal})

})