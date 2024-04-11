$(document).on('turbo:load', function(){
  $('.treeview > ol').nestedSortable({
      handle: 'span.sort',
      items: 'li',
      toleranceElement: '> div'
  })
})