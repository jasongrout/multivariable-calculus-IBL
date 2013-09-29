$(function() {
body=$('body')
button=$("<button>Toggle Marginal Notes</button>")
button.addClass("margintoggle")
button.click(function() {
    body.toggleClass('fullwidth');
    $('.marginpar').toggle();
})
    $("body a[href^='http://']").attr("target","_blank");
    $("body a[href^='https://']").attr("target","_blank");
    sagecell.makeSagecell({"inputLocation": ".sage"});
    sagecell.makeSagecell({"inputLocation": ".sageminimal", template:
sagecell.templates.minimal})

    var toc=$('<ol></ol>')
    $('body > section > section:visible').each(function(i,e) {
        var sect = $(e)
        var title = sect.children('h1')
        var id = 'section-'+i;
        sect.attr('id', id);
        
        toc.append('<li><a href=#'+id+'>'+title.html()+'</a></li>')
    })
    body.prepend(toc);
    body.prepend(button);
    body.prepend('<a href="index.html">Return to Table of Contents</a><br/>');
})