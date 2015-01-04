HomePage=
  init: -> 
    $('#title-btn, .details-btn').mouseenter ->
      $(@).addClass('inv-btn')
    $('#title-btn, .details-btn').mouseleave ->
      $(@).removeClass('inv-btn')
    $('.navbar-nav').on('click','li', ->
      $('li').removeClass('active')
      $(@).addClass('active'))
    $('.navbar-brand').on('click', ->
      $('.navbar-nav').find('li').removeClass('active'))

SystemIncidents=
  init: ->
    $('body').css('overflow','hidden')
    $('#details-modal').on('click','.modal-close-btn, .modal-X-btn', ->
      $('#details-modal').html('')
      $('#details-modal').hide()
      $('body').css('overflow','visible'))
    $('#details-modal').on('mouseenter','.modal-close-btn', ->
      $(@).addClass('inv-btn'))
    $('#details-modal').on('mouseenter','.modal-X-btn', ->
      $(@).addClass('inv-X-btn'))
    $('#details-modal').on('mouseleave','.modal-close-btn', ->
      $(@).removeClass('inv-btn'))
    $('#details-modal').on('mouseleave','.modal-X-btn', ->
      $(@).removeClass('inv-X-btn'))

LoginForm=
  init: ->
    $('#login-modal').on('click', '#cancel-btn', ->
      $('#login-modal').html('')
      $('#login-modal').hide())

$(document).ready ->
  HomePage.init()
  SystemIncidents.init()
  LoginForm.init()