// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).ready(function() {

  $(".chat-form").on("ajax:success", function(e, data, status, xhr) {

    $(".chat-display").empty()
    var responseObj = JSON.parse(xhr.responseText)
    // console.log(responseObj.title, responseObj.options)

    var question = responseObj.title;
    var options = responseObj.options;

    $(".chat-display").append(`<div class="chat-q">${question}</div>`)

    options.forEach(function(option) {
      $(".chat-display").append(`<div class="chat-o">${option}</div>`)
    })

  })
})
