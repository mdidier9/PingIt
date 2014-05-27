# NOTE: RIGHT NOW THIS FILE IS UNNECESSARY, BUT I WANT TO KEEP IT JUST IN CASE.


jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init(appId: '764749046879221', cookie: true, xfbml: true, version: 'v2.0')

  $('#login').click (e) ->
    e.preventDefault()
    FB.login (response) ->
      window.location = '/auth/facebook/callback' if response.authResponse

  $('#logout').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true
