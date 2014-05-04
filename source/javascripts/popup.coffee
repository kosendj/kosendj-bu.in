$ ->
  $(".js-popup").click ->
    $(".panel").addClass("hidden")
    name = $(this).parents(".icon").data("name")
    $panel = $(".js-#{name}")
    $panel.removeClass("hidden")
    $(".rug").removeClass("hidden")

  $(".js-close, .rug").click ->
    $(".panel").addClass("hidden")
    $(".rug").addClass("hidden")
