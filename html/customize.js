$(function() {
body=$('body')
button=$("<button>Toggle Marginal Notes</button>")
button.click(function() {
    body.toggleClass('fullwidth');
    $('.marginpar').toggle();
})
body.prepend(button);
})