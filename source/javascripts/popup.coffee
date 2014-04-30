$ ->
  $(".js-popup").click ->
    $(".panel").addClass("hidden")
    name = $(this).parents(".icon").data("name")
    $panel = $(".js-#{name}")
    marginLeft = ($(window).width() - ($panel.width() / 100 * $(window).width())) / 2 #suck
    $panel.css({marginLeft: marginLeft})
    $panel.removeClass("hidden")


  $(".js-close").click ->
    $(this).parents(".panel").addClass("hidden")
