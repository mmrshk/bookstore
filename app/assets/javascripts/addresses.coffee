fieldVisibility = ->
    if $('#use_billing').prop('checked')
      $('.billing_addresses').slideDown 'slow'
    else
      $('.billing_addresses').slideUp 'slow'

$('#use_billing-id').click ->
  fieldVisibility()

fieldVisibility()
