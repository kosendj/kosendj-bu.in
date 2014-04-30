$ ->
  $(".js-popup").click ->
    $(".panel").addClass("hidden")
    name = $(this).parents(".icon").data("name")
    $panel = $(".js-#{name}")
    $panel.removeClass("hidden")


  $(".js-close").click ->
    $(this).parents(".panel").addClass("hidden")
